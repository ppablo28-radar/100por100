import uuid
from typing import Optional, TYPE_CHECKING

from sqlalchemy import Boolean, ForeignKey, Index, Text, UniqueConstraint
from sqlalchemy.dialects.postgresql import JSONB, UUID
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.db.base import Base

if TYPE_CHECKING:
    from app.models.questions import Question


class Category(Base):
    __tablename__ = "categories"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    parent_id: Mapped[Optional[uuid.UUID]] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("categories.id", ondelete="SET NULL"),
        nullable=True,
    )
    name: Mapped[str] = mapped_column(Text, nullable=False)
    slug: Mapped[str] = mapped_column(Text, unique=True, nullable=False)
    enabled: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)
    # icon, color, description, display_order, education_grade, etc.
    metadata_: Mapped[dict] = mapped_column(
        "metadata", JSONB, default=dict, server_default="{}", nullable=False
    )

    parent: Mapped[Optional["Category"]] = relationship(
        "Category", remote_side="Category.id", back_populates="children"
    )
    children: Mapped[list["Category"]] = relationship(
        "Category", back_populates="parent"
    )
    question_categories: Mapped[list["QuestionCategory"]] = relationship(
        back_populates="category"
    )

    __table_args__ = (Index("ix_categories_slug", "slug"),)


class QuestionCategory(Base):
    __tablename__ = "question_categories"

    question_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("questions.id", ondelete="CASCADE"),
        primary_key=True,
    )
    category_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("categories.id", ondelete="CASCADE"),
        primary_key=True,
    )

    question: Mapped["Question"] = relationship(back_populates="question_categories")
    category: Mapped["Category"] = relationship(back_populates="question_categories")


class Tag(Base):
    __tablename__ = "tags"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    name: Mapped[str] = mapped_column(Text, nullable=False)
    slug: Mapped[str] = mapped_column(Text, unique=True, nullable=False)

    question_tags: Mapped[list["QuestionTag"]] = relationship(back_populates="tag")

    __table_args__ = (Index("ix_tags_slug", "slug"),)


class QuestionTag(Base):
    __tablename__ = "question_tags"

    question_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("questions.id", ondelete="CASCADE"),
        primary_key=True,
    )
    tag_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("tags.id", ondelete="CASCADE"),
        primary_key=True,
    )

    question: Mapped["Question"] = relationship(back_populates="question_tags")
    tag: Mapped["Tag"] = relationship(back_populates="question_tags")
