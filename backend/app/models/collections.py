import uuid
from datetime import datetime
from typing import TYPE_CHECKING

from sqlalchemy import ForeignKey, Index, Text
from sqlalchemy.dialects.postgresql import JSONB, UUID
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy.sql import func

from app.db.base import Base

if TYPE_CHECKING:
    from app.models.questions import Question


class QuestionCollection(Base):
    """Thematic packs: seasonal, kids, education, streamer_pack, world_news, etc."""

    __tablename__ = "question_collections"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    name: Mapped[str] = mapped_column(Text, nullable=False)
    # seasonal | kids | education | streamer_pack | world_news | custom
    collection_type: Mapped[str] = mapped_column(Text, nullable=False)
    # description, valid_from, valid_until, thumbnail_url, language, etc.
    metadata_: Mapped[dict] = mapped_column(
        "metadata", JSONB, default=dict, server_default="{}", nullable=False
    )

    items: Mapped[list["QuestionCollectionItem"]] = relationship(
        back_populates="collection", cascade="all, delete-orphan"
    )


class QuestionCollectionItem(Base):
    __tablename__ = "question_collection_items"

    collection_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("question_collections.id", ondelete="CASCADE"),
        primary_key=True,
    )
    question_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("questions.id", ondelete="CASCADE"),
        primary_key=True,
    )

    collection: Mapped["QuestionCollection"] = relationship(back_populates="items")
    question: Mapped["Question"] = relationship(back_populates="collection_items")


class QuestionEvent(Base):
    """Immutable audit log of everything that happens to a question."""

    __tablename__ = "question_events"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    question_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("questions.id", ondelete="CASCADE"),
        nullable=False,
    )
    # QUESTION_CREATED | QUESTION_APPROVED | QUESTION_REJECTED |
    # QUESTION_DISABLED | QUESTION_ARCHIVED | QUESTION_REPORTED |
    # QUESTION_UPDATED | QUESTION_PUBLISHED | AI_REVIEWED
    event_type: Mapped[str] = mapped_column(Text, nullable=False)
    created_at: Mapped[datetime] = mapped_column(
        default=None, server_default=func.now(), nullable=False
    )
    # actor_id, actor_type, diff, reason, etc.
    payload: Mapped[dict] = mapped_column(
        JSONB, default=dict, server_default="{}", nullable=False
    )

    question: Mapped["Question"] = relationship(back_populates="events")

    __table_args__ = (
        Index("ix_question_events_question_id", "question_id"),
        Index("ix_question_events_event_type", "event_type"),
        Index("ix_question_events_created_at", "created_at"),
    )
