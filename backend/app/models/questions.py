import uuid
from datetime import datetime
from typing import Optional, TYPE_CHECKING

from sqlalchemy import Boolean, Float, ForeignKey, Index, Integer, Text
from sqlalchemy.dialects.postgresql import JSONB, UUID
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy.sql import func

from app.db.base import Base

if TYPE_CHECKING:
    from app.models.categories import QuestionCategory, QuestionTag
    from app.models.audiences import QuestionTargetAudience
    from app.models.analytics import QuestionAnalytics, QuestionFeedback, QuestionAttempt
    from app.models.ai import AIReviewResult
    from app.models.collections import QuestionEvent, QuestionCollectionItem


class Question(Base):
    __tablename__ = "questions"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    version: Mapped[int] = mapped_column(Integer, default=1, nullable=False)
    slug: Mapped[str] = mapped_column(Text, unique=True, nullable=False)

    # Lifecycle
    status: Mapped[str] = mapped_column(Text, default="draft", nullable=False)
    # draft | review | approved | rejected | archived
    enabled: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    archived: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)

    # answer_mode: multiple_choice | numeric | text | multi_select | multimedia
    answer_mode: Mapped[str] = mapped_column(
        Text, default="multiple_choice", nullable=False
    )

    # Timestamps
    created_at: Mapped[datetime] = mapped_column(
        default=None, server_default=func.now(), nullable=False
    )
    updated_at: Mapped[datetime] = mapped_column(
        default=None,
        server_default=func.now(),
        onupdate=func.now(),
        nullable=False,
    )
    published_at: Mapped[Optional[datetime]] = mapped_column(nullable=True)

    # Authorship — type: "human" | "ai" | "system"
    created_by_type: Mapped[str] = mapped_column(Text, default="human", nullable=False)
    created_by_id: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    reviewed_by_type: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    reviewed_by_id: Mapped[Optional[str]] = mapped_column(Text, nullable=True)

    default_duration_seconds: Mapped[int] = mapped_column(
        Integer, default=10, nullable=False
    )

    # Scoring signals — all nullable (populated progressively)
    difficulty_manual: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    difficulty_estimated: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    confidence_score: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    fun_score_estimated: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    engagement_score_estimated: Mapped[Optional[float]] = mapped_column(
        Float, nullable=True
    )
    learning_value_score: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    virality_score: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    reading_complexity_score: Mapped[Optional[float]] = mapped_column(
        Float, nullable=True
    )
    mainstream_score: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    sensitivity_score: Mapped[Optional[float]] = mapped_column(Float, nullable=True)

    # Extensible metadata — examples: meme_score, freshness_priority,
    # streamer_priority, seasonal, event, mobile_friendly, ab_test_group
    metadata_: Mapped[dict] = mapped_column(
        "metadata", JSONB, default=dict, server_default="{}", nullable=False
    )

    # Relationships
    translations: Mapped[list["QuestionTranslation"]] = relationship(
        back_populates="question", cascade="all, delete-orphan"
    )
    answer_options: Mapped[list["AnswerOption"]] = relationship(
        back_populates="question",
        cascade="all, delete-orphan",
        order_by="AnswerOption.display_order",
    )
    validation_rules: Mapped[list["AnswerValidationRule"]] = relationship(
        back_populates="question", cascade="all, delete-orphan"
    )
    analytics: Mapped[Optional["QuestionAnalytics"]] = relationship(
        back_populates="question", uselist=False
    )
    target_audiences: Mapped[list["QuestionTargetAudience"]] = relationship(
        back_populates="question", cascade="all, delete-orphan"
    )
    feedback: Mapped[list["QuestionFeedback"]] = relationship(
        back_populates="question"
    )
    attempts: Mapped[list["QuestionAttempt"]] = relationship(
        back_populates="question"
    )
    ai_review_results: Mapped[list["AIReviewResult"]] = relationship(
        back_populates="question"
    )
    events: Mapped[list["QuestionEvent"]] = relationship(back_populates="question")
    question_categories: Mapped[list["QuestionCategory"]] = relationship(
        back_populates="question", cascade="all, delete-orphan"
    )
    question_tags: Mapped[list["QuestionTag"]] = relationship(
        back_populates="question", cascade="all, delete-orphan"
    )
    collection_items: Mapped[list["QuestionCollectionItem"]] = relationship(
        back_populates="question"
    )

    __table_args__ = (
        Index("ix_questions_status", "status"),
        Index("ix_questions_enabled_archived", "enabled", "archived"),
        Index("ix_questions_answer_mode", "answer_mode"),
        Index("ix_questions_created_by_type", "created_by_type"),
    )


class QuestionTranslation(Base):
    __tablename__ = "question_translations"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    question_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("questions.id", ondelete="CASCADE"),
        nullable=False,
    )
    language: Mapped[str] = mapped_column(Text, nullable=False)  # "es", "en", "pt"
    title: Mapped[str] = mapped_column(Text, nullable=False)
    subtitle: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    explanation: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    short_version: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    # ["minecraft", "gaming", "youtube"]
    keywords: Mapped[list] = mapped_column(
        JSONB, default=list, server_default="[]", nullable=False
    )

    question: Mapped["Question"] = relationship(back_populates="translations")

    __table_args__ = (
        Index("ix_question_translations_question_lang", "question_id", "language"),
    )


class AnswerOption(Base):
    __tablename__ = "answer_options"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    question_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("questions.id", ondelete="CASCADE"),
        nullable=False,
    )
    version: Mapped[int] = mapped_column(Integer, default=1, nullable=False)
    display_order: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    text: Mapped[str] = mapped_column(Text, nullable=False)
    short_text: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    media_asset_id: Mapped[Optional[uuid.UUID]] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("media_assets.id", ondelete="SET NULL"),
        nullable=True,
    )
    is_correct: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    enabled: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)

    # ML scoring signals
    weight: Mapped[float] = mapped_column(Float, default=1.0, nullable=False)
    plausibility_score: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    confusion_score: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    humor_score: Mapped[Optional[float]] = mapped_column(Float, nullable=True)

    # Extra: distractor_type, language, ab_variant, etc.
    metadata_: Mapped[dict] = mapped_column(
        "metadata", JSONB, default=dict, server_default="{}", nullable=False
    )

    question: Mapped["Question"] = relationship(back_populates="answer_options")

    __table_args__ = (
        Index("ix_answer_options_question_id", "question_id"),
        Index("ix_answer_options_is_correct", "question_id", "is_correct"),
    )


class AnswerValidationRule(Base):
    """For non-multiple-choice questions: numeric, text, regex, multi_select."""

    __tablename__ = "answer_validation_rules"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    question_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("questions.id", ondelete="CASCADE"),
        nullable=False,
    )
    # multiple_choice | numeric | numeric_range | text | regex | multi_select
    validation_type: Mapped[str] = mapped_column(Text, nullable=False)

    # Examples:
    # numeric exact:    {"exact": 42}
    # numeric range:    {"min": 40, "max": 44}
    # text:             {"accepted_answers": ["messi", "lionel messi"]}
    # regex:            {"pattern": "^\\d{4}$"}
    # multi_select:     {"required": ["opt_a", "opt_c"], "min_correct": 2}
    validation_data: Mapped[dict] = mapped_column(JSONB, nullable=False)

    question: Mapped["Question"] = relationship(back_populates="validation_rules")

    __table_args__ = (
        Index("ix_validation_rules_question_id", "question_id"),
    )
