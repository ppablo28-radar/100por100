import uuid
from typing import Optional

from sqlalchemy import Integer, Text
from sqlalchemy.dialects.postgresql import JSONB, UUID
from sqlalchemy.orm import Mapped, mapped_column

from app.db.base import Base


class MediaAsset(Base):
    __tablename__ = "media_assets"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    # image | audio | video | gif
    media_type: Mapped[str] = mapped_column(Text, nullable=False)
    # supabase_storage | s3 | cloudinary | url
    storage_provider: Mapped[str] = mapped_column(Text, nullable=False)
    url: Mapped[str] = mapped_column(Text, nullable=False)
    thumbnail_url: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    duration_ms: Mapped[Optional[int]] = mapped_column(Integer, nullable=True)
    width: Mapped[Optional[int]] = mapped_column(Integer, nullable=True)
    height: Mapped[Optional[int]] = mapped_column(Integer, nullable=True)
    # mime_type, alt_text, caption, size_bytes, language, etc.
    metadata_: Mapped[dict] = mapped_column(
        "metadata", JSONB, default=dict, server_default="{}", nullable=False
    )
