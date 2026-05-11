import uuid
from datetime import datetime
from typing import Optional, TYPE_CHECKING

from sqlalchemy import BigInteger, Boolean, Float, ForeignKey, Index, Integer, Text
from sqlalchemy.dialects.postgresql import JSONB, UUID
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy.sql import func

from app.db.base import Base

if TYPE_CHECKING:
    from app.models.questions import Question


class QuestionAnalytics(Base):
    """Aggregate analytics per question — updated by background jobs, never in hot path."""

    __tablename__ = "question_analytics"

    question_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("questions.id", ondelete="CASCADE"),
        primary_key=True,
    )

    # Volume
    times_shown: Mapped[int] = mapped_column(BigInteger, default=0, nullable=False)
    times_answered: Mapped[int] = mapped_column(BigInteger, default=0, nullable=False)
    times_skipped: Mapped[int] = mapped_column(BigInteger, default=0, nullable=False)

    # Performance
    correct_rate: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    average_response_time_ms: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    median_response_time_ms: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    abandonment_rate: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    report_rate: Mapped[Optional[float]] = mapped_column(Float, nullable=True)

    # Derived scores (updated by ML pipeline)
    engagement_score: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    fun_score: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    frustration_score: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    virality_score: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    learning_score: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    difficulty_real: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    freshness_score: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    replayability_score: Mapped[Optional[float]] = mapped_column(Float, nullable=True)

    # Per-option pick distribution: {"option_uuid": 0.45, ...}
    option_pick_rates: Mapped[dict] = mapped_column(
        JSONB, default=dict, server_default="{}", nullable=False
    )
    # Difficulty breakdown by audience: {"kids_10_13": 0.72, "adults": 0.41}
    audience_difficulty_profiles: Mapped[dict] = mapped_column(
        JSONB, default=dict, server_default="{}", nullable=False
    )

    updated_at: Mapped[datetime] = mapped_column(
        default=None, server_default=func.now(), onupdate=func.now(), nullable=False
    )

    question: Mapped["Question"] = relationship(back_populates="analytics")


class QuestionFeedback(Base):
    """Individual per-player feedback on a question during or after a match."""

    __tablename__ = "question_feedback"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    player_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), nullable=False)
    question_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("questions.id", ondelete="CASCADE"),
        nullable=False,
    )
    match_id: Mapped[Optional[uuid.UUID]] = mapped_column(
        UUID(as_uuid=True), nullable=True
    )
    # liked | fun | boring | too_easy | too_hard | too_specific | ambiguous | offensive
    feedback_type: Mapped[str] = mapped_column(Text, nullable=False)
    created_at: Mapped[datetime] = mapped_column(
        default=None, server_default=func.now(), nullable=False
    )
    metadata_: Mapped[dict] = mapped_column(
        "metadata", JSONB, default=dict, server_default="{}", nullable=False
    )

    question: Mapped["Question"] = relationship(back_populates="feedback")

    __table_args__ = (
        Index("ix_question_feedback_question_id", "question_id"),
        Index("ix_question_feedback_player_id", "player_id"),
        Index("ix_question_feedback_type", "feedback_type"),
    )


class QuestionAttempt(Base):
    """Every single answer submitted by a player — the most critical table for analytics."""

    __tablename__ = "question_attempts"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    match_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), nullable=False)
    player_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), nullable=False)
    question_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("questions.id", ondelete="CASCADE"),
        nullable=False,
    )
    question_version: Mapped[int] = mapped_column(Integer, default=1, nullable=False)

    response_time_ms: Mapped[Optional[int]] = mapped_column(Integer, nullable=True)
    correct: Mapped[bool] = mapped_column(Boolean, nullable=False)
    points_earned: Mapped[int] = mapped_column(Integer, default=0, nullable=False)

    created_at: Mapped[datetime] = mapped_column(
        default=None, server_default=func.now(), nullable=False
    )

    # What the player selected — format depends on answer_mode:
    # multiple_choice: ["option_uuid"]
    # numeric:         {"value": 42}
    # text:            {"value": "messi"}
    # multi_select:    ["option_a", "option_c"]
    selected_answers: Mapped[dict] = mapped_column(JSONB, nullable=False)

    # Snapshot of which options were displayed (may differ due to rotation)
    # [{"id": "uuid", "text": "...", "order": 0}, ...]
    displayed_options: Mapped[list] = mapped_column(
        JSONB, default=list, server_default="[]", nullable=False
    )

    # Network latency (client-reported)
    latency_ms: Mapped[Optional[int]] = mapped_column(Integer, nullable=True)
    # mobile | desktop | tablet
    device_type: Mapped[Optional[str]] = mapped_column(Text, nullable=True)

    # anti_cheat_flags, ab_group, session_id, etc.
    metadata_: Mapped[dict] = mapped_column(
        "metadata", JSONB, default=dict, server_default="{}", nullable=False
    )

    question: Mapped["Question"] = relationship(back_populates="attempts")

    __table_args__ = (
        Index("ix_attempts_match_id", "match_id"),
        Index("ix_attempts_player_id", "player_id"),
        Index("ix_attempts_question_id", "question_id"),
        Index("ix_attempts_created_at", "created_at"),
        # Composite index for per-match anti-cheat checks
        Index("ix_attempts_match_player", "match_id", "player_id"),
    )
