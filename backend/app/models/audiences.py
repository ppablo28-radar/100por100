import uuid
from typing import Optional, TYPE_CHECKING

from sqlalchemy import Boolean, ForeignKey, Index, Integer, Text
from sqlalchemy.dialects.postgresql import JSONB, UUID
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.db.base import Base

if TYPE_CHECKING:
    from app.models.questions import Question


class QuestionTargetAudience(Base):
    __tablename__ = "question_target_audiences"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    question_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("questions.id", ondelete="CASCADE"),
        nullable=False,
    )
    min_age: Mapped[Optional[int]] = mapped_column(Integer, nullable=True)
    max_age: Mapped[Optional[int]] = mapped_column(Integer, nullable=True)
    region: Mapped[Optional[str]] = mapped_column(Text, nullable=True)  # "AR", "US", "LATAM", "global"
    language: Mapped[Optional[str]] = mapped_column(Text, nullable=True)  # "es", "en"
    # general | kids | teens | adults | streamer | education
    audience_type: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    kid_friendly: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)
    # school_safe, reading_level_grade, streamer_safe, parental_guidance, etc.
    metadata_: Mapped[dict] = mapped_column(
        "metadata", JSONB, default=dict, server_default="{}", nullable=False
    )

    question: Mapped["Question"] = relationship(back_populates="target_audiences")

    __table_args__ = (
        Index("ix_target_audiences_question_id", "question_id"),
        Index("ix_target_audiences_kid_friendly", "kid_friendly"),
        Index("ix_target_audiences_age_range", "min_age", "max_age"),
    )
