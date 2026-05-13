"""
Motor procedural de conocimiento competitivo.

Arquitectura:
  knowledge_entities + knowledge_entity_attributes  →  facts estructurados
  timeline_events                                   →  historia cronológica
  procedural_generators                             →  definición de generadores
  generated_match_questions                         →  snapshots runtime persistidos
"""
import uuid
from datetime import datetime
from typing import Optional, TYPE_CHECKING

from sqlalchemy import Boolean, Float, ForeignKey, Index, Text
from sqlalchemy.dialects.postgresql import JSONB, UUID
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy.sql import func

from app.db.base import Base

if TYPE_CHECKING:
    from app.models.categories import Category


# ─── Eventos temporales ───────────────────────────────────────────────────────

class TimelineEvent(Base):
    """
    Evento temporal canónico reutilizable.

    Permite preguntas de tipo:
      - ¿Qué sucedió primero?
      - Ordenar cronológicamente
      - ¿En qué año ocurrió X?

    Cubre: historia, gaming, internet, cultura pop, YouTube, deportes, memes.
    """
    __tablename__ = "timeline_events"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    title: Mapped[str] = mapped_column(Text, nullable=False)
    short_title: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    description: Mapped[Optional[str]] = mapped_column(Text, nullable=True)

    event_date: Mapped[datetime] = mapped_column(nullable=False)
    # year | month | day | exact
    precision: Mapped[str] = mapped_column(Text, default="year", nullable=False)

    region: Mapped[Optional[str]] = mapped_column(Text, nullable=True)   # "AR", "global", "LATAM"
    language: Mapped[str] = mapped_column(Text, default="es", nullable=False)

    category_id: Mapped[Optional[uuid.UUID]] = mapped_column(
        UUID(as_uuid=True), ForeignKey("categories.id", ondelete="SET NULL"), nullable=True
    )

    difficulty_score: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    mainstream_score: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    kid_friendly: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)

    source_url: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    verified: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)

    created_at: Mapped[datetime] = mapped_column(server_default=func.now(), nullable=False)
    updated_at: Mapped[datetime] = mapped_column(server_default=func.now(), onupdate=func.now(), nullable=False)

    # gaming_related, meme_score, streamer_relevant, viral_score, tags, etc.
    metadata_: Mapped[dict] = mapped_column("metadata", JSONB, default=dict, server_default="{}", nullable=False)

    __table_args__ = (
        Index("ix_timeline_events_date", "event_date"),
        Index("ix_timeline_events_region", "region"),
        Index("ix_timeline_events_kid_friendly", "kid_friendly"),
        Index("ix_timeline_events_category", "category_id"),
    )


# ─── Entidades de conocimiento ────────────────────────────────────────────────

class KnowledgeEntity(Base):
    """
    Entidad estructurada reutilizable.

    Tipos: país, youtuber, streamer, videojuego, futbolista, animal, película,
           marca, app, celebridad, banda, serie, etc.

    La misma entidad puede usarse en N generadores distintos.
    """
    __tablename__ = "knowledge_entities"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    entity_type: Mapped[str] = mapped_column(Text, nullable=False)   # "youtuber", "country", "game", ...
    name: Mapped[str] = mapped_column(Text, nullable=False)
    slug: Mapped[str] = mapped_column(Text, unique=True, nullable=False)
    description: Mapped[Optional[str]] = mapped_column(Text, nullable=True)

    region: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    language: Mapped[str] = mapped_column(Text, default="es", nullable=False)

    kid_friendly: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)
    popularity_score: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    mainstream_score: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    verified: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)

    created_at: Mapped[datetime] = mapped_column(server_default=func.now(), nullable=False)
    updated_at: Mapped[datetime] = mapped_column(server_default=func.now(), onupdate=func.now(), nullable=False)

    # youtube_channel, gaming_related, tiktok_related, image_url, etc.
    metadata_: Mapped[dict] = mapped_column("metadata", JSONB, default=dict, server_default="{}", nullable=False)

    attributes: Mapped[list["KnowledgeEntityAttribute"]] = relationship(
        back_populates="entity", cascade="all, delete-orphan"
    )

    __table_args__ = (
        Index("ix_knowledge_entities_type", "entity_type"),
        Index("ix_knowledge_entities_slug", "slug"),
        Index("ix_knowledge_entities_kid_friendly", "kid_friendly"),
        Index("ix_knowledge_entities_type_popularity", "entity_type", "popularity_score"),
    )


class KnowledgeAttribute(Base):
    """
    Define un atributo reutilizable con su tipo y unidad.

    Ejemplos:
      subscribers  →  integer  →  unidad: ""
      population   →  integer  →  unidad: "personas"
      area         →  float    →  unidad: "km²"
      release_year →  integer  →  unidad: "año"
      speed_kmh    →  float    →  unidad: "km/h"
      height_cm    →  integer  →  unidad: "cm"
      weight_kg    →  float    →  unidad: "kg"
    """
    __tablename__ = "knowledge_attributes"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    slug: Mapped[str] = mapped_column(Text, unique=True, nullable=False)
    name: Mapped[str] = mapped_column(Text, nullable=False)            # nombre legible
    # integer | float | date | string | boolean
    data_type: Mapped[str] = mapped_column(Text, nullable=False)
    unit: Mapped[Optional[str]] = mapped_column(Text, nullable=True)   # "millones", "km²", "kg"

    # display_format, comparison_direction (higher_is_better), icon, etc.
    metadata_: Mapped[dict] = mapped_column("metadata", JSONB, default=dict, server_default="{}", nullable=False)

    entity_values: Mapped[list["KnowledgeEntityAttribute"]] = relationship(
        back_populates="attribute", cascade="all, delete-orphan"
    )

    __table_args__ = (
        Index("ix_knowledge_attributes_slug", "slug"),
    )


class KnowledgeEntityAttribute(Base):
    """
    Valor concreto de un atributo para una entidad.

    Ejemplo:  MrBeast → subscribers → 400_000_000
    Ejemplo:  Argentina → population → 46_000_000
    Ejemplo:  Minecraft → release_year → 2011.0
    """
    __tablename__ = "knowledge_entity_attributes"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)

    entity_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), ForeignKey("knowledge_entities.id", ondelete="CASCADE"), nullable=False
    )
    attribute_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), ForeignKey("knowledge_attributes.id", ondelete="CASCADE"), nullable=False
    )

    value_number: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    value_text: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    value_date: Mapped[Optional[datetime]] = mapped_column(nullable=True)

    source_url: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    verified: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    updated_at: Mapped[datetime] = mapped_column(server_default=func.now(), onupdate=func.now(), nullable=False)

    # rank_in_category, approximate, last_verified_at, etc.
    metadata_: Mapped[dict] = mapped_column("metadata", JSONB, default=dict, server_default="{}", nullable=False)

    entity: Mapped["KnowledgeEntity"] = relationship(back_populates="attributes")
    attribute: Mapped["KnowledgeAttribute"] = relationship(back_populates="entity_values")

    __table_args__ = (
        Index("ix_entity_attributes_entity", "entity_id"),
        Index("ix_entity_attributes_attribute", "attribute_id"),
        Index("ix_entity_attributes_entity_attr", "entity_id", "attribute_id"),
        Index("ix_entity_attributes_value_number", "value_number"),
    )


# ─── Generadores procedurales ─────────────────────────────────────────────────

class ProceduralGenerator(Base):
    """
    Definición de un generador dinámico de preguntas.

    Cada generador tiene:
      - generator_type: el algoritmo a usar
      - config: parámetros configurables (sin hardcodear nada)
      - metadata: hints para la IA y el motor

    Tipos de generador:
      timeline_order    → ordenar eventos cronológicamente
      higher_lower      → cuál tiene más/menos de un atributo
      closest_number    → cuánto más cerca del valor real
      most_followed     → cuál es el más popular
      odd_one_out       → cuál no pertenece al grupo
      ranking_order     → ordenar N entidades por un atributo
      numeric_guess     → adivinar un número (apertura/cierre)
    """
    __tablename__ = "procedural_generators"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    slug: Mapped[str] = mapped_column(Text, unique=True, nullable=False)
    generator_type: Mapped[str] = mapped_column(Text, nullable=False)
    enabled: Mapped[bool] = mapped_column(Boolean, default=True, nullable=False)

    # Configuración extensible:
    # {
    #   "min_options": 4, "max_options": 4, "shuffle": true,
    #   "allowed_entity_types": ["youtuber", "country"],
    #   "allowed_attributes": ["subscribers", "population"],
    #   "min_events": 4, "max_events": 4,
    #   "kid_safe_only": true, "region": null,
    #   "difficulty_range": [0.3, 0.8]
    # }
    config: Mapped[dict] = mapped_column(JSONB, nullable=False, default=dict)

    # difficulty_range, age_target, language, etc.
    metadata_: Mapped[dict] = mapped_column("metadata", JSONB, default=dict, server_default="{}", nullable=False)

    created_at: Mapped[datetime] = mapped_column(server_default=func.now(), nullable=False)

    generated_questions: Mapped[list["GeneratedMatchQuestion"]] = relationship(
        back_populates="generator"
    )

    __table_args__ = (
        Index("ix_procedural_generators_type", "generator_type"),
        Index("ix_procedural_generators_enabled", "enabled"),
    )


class GeneratedMatchQuestion(Base):
    """
    Snapshot persistido de una pregunta generada en runtime.

    MUY IMPORTANTE:
    Las preguntas procedurales generadas durante un match se persisten aquí.
    Esto permite:
      - Analytics sobre preguntas generadas
      - Replay del match
      - Anti-cheat (auditoría)
      - Aprendizaje del sistema de IA

    El payload es el objeto completo enviado al cliente:
    {
      "question_text": "¿Qué sucedió primero?",
      "events": [...],
      "correct_order": [...]
    }
    """
    __tablename__ = "generated_match_questions"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    match_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), nullable=False)

    generator_id: Mapped[Optional[uuid.UUID]] = mapped_column(
        UUID(as_uuid=True), ForeignKey("procedural_generators.id", ondelete="SET NULL"), nullable=True
    )

    # timeline_order | higher_lower | closest_number | odd_one_out | handcrafted
    question_type: Mapped[str] = mapped_column(Text, nullable=False)

    # El payload completo generado (lo que recibe el cliente)
    generated_payload: Mapped[dict] = mapped_column(JSONB, nullable=False)

    difficulty_score: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    created_at: Mapped[datetime] = mapped_column(server_default=func.now(), nullable=False)

    generator: Mapped[Optional["ProceduralGenerator"]] = relationship(
        back_populates="generated_questions"
    )

    __table_args__ = (
        Index("ix_generated_match_questions_match", "match_id"),
        Index("ix_generated_match_questions_type", "question_type"),
        Index("ix_generated_match_questions_generator", "generator_id"),
    )
