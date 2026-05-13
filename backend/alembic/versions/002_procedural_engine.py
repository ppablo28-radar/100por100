"""Procedural knowledge engine — 6 new tables

Revision ID: 002
Revises: 001
Create Date: 2026-05-13
"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

revision = "002"
down_revision = "001"
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ── timeline_events ───────────────────────────────────────────────────
    op.create_table(
        "timeline_events",
        sa.Column("id", postgresql.UUID(as_uuid=True), primary_key=True),
        sa.Column("title", sa.Text(), nullable=False),
        sa.Column("short_title", sa.Text(), nullable=True),
        sa.Column("description", sa.Text(), nullable=True),
        sa.Column("event_date", sa.DateTime(timezone=True), nullable=False),
        sa.Column("precision", sa.Text(), nullable=False, server_default="year"),
        sa.Column("region", sa.Text(), nullable=True),
        sa.Column("language", sa.Text(), nullable=False, server_default="es"),
        sa.Column("category_id", postgresql.UUID(as_uuid=True),
                  sa.ForeignKey("categories.id", ondelete="SET NULL"), nullable=True),
        sa.Column("difficulty_score", sa.Float(), nullable=True),
        sa.Column("mainstream_score", sa.Float(), nullable=True),
        sa.Column("kid_friendly", sa.Boolean(), nullable=False, server_default="true"),
        sa.Column("source_url", sa.Text(), nullable=True),
        sa.Column("verified", sa.Boolean(), nullable=False, server_default="false"),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("metadata", postgresql.JSONB(), server_default="{}", nullable=False),
    )
    op.create_index("ix_timeline_events_date", "timeline_events", ["event_date"])
    op.create_index("ix_timeline_events_region", "timeline_events", ["region"])
    op.create_index("ix_timeline_events_kid_friendly", "timeline_events", ["kid_friendly"])
    op.create_index("ix_timeline_events_category", "timeline_events", ["category_id"])

    # ── knowledge_entities ────────────────────────────────────────────────
    op.create_table(
        "knowledge_entities",
        sa.Column("id", postgresql.UUID(as_uuid=True), primary_key=True),
        sa.Column("entity_type", sa.Text(), nullable=False),
        sa.Column("name", sa.Text(), nullable=False),
        sa.Column("slug", sa.Text(), unique=True, nullable=False),
        sa.Column("description", sa.Text(), nullable=True),
        sa.Column("region", sa.Text(), nullable=True),
        sa.Column("language", sa.Text(), nullable=False, server_default="es"),
        sa.Column("kid_friendly", sa.Boolean(), nullable=False, server_default="true"),
        sa.Column("popularity_score", sa.Float(), nullable=True),
        sa.Column("mainstream_score", sa.Float(), nullable=True),
        sa.Column("verified", sa.Boolean(), nullable=False, server_default="false"),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("metadata", postgresql.JSONB(), server_default="{}", nullable=False),
    )
    op.create_index("ix_knowledge_entities_type", "knowledge_entities", ["entity_type"])
    op.create_index("ix_knowledge_entities_slug", "knowledge_entities", ["slug"])
    op.create_index("ix_knowledge_entities_kid_friendly", "knowledge_entities", ["kid_friendly"])
    op.create_index("ix_knowledge_entities_type_popularity", "knowledge_entities", ["entity_type", "popularity_score"])

    # ── knowledge_attributes ──────────────────────────────────────────────
    op.create_table(
        "knowledge_attributes",
        sa.Column("id", postgresql.UUID(as_uuid=True), primary_key=True),
        sa.Column("slug", sa.Text(), unique=True, nullable=False),
        sa.Column("name", sa.Text(), nullable=False),
        sa.Column("data_type", sa.Text(), nullable=False),
        sa.Column("unit", sa.Text(), nullable=True),
        sa.Column("metadata", postgresql.JSONB(), server_default="{}", nullable=False),
    )
    op.create_index("ix_knowledge_attributes_slug", "knowledge_attributes", ["slug"])

    # ── knowledge_entity_attributes ───────────────────────────────────────
    op.create_table(
        "knowledge_entity_attributes",
        sa.Column("id", postgresql.UUID(as_uuid=True), primary_key=True),
        sa.Column("entity_id", postgresql.UUID(as_uuid=True),
                  sa.ForeignKey("knowledge_entities.id", ondelete="CASCADE"), nullable=False),
        sa.Column("attribute_id", postgresql.UUID(as_uuid=True),
                  sa.ForeignKey("knowledge_attributes.id", ondelete="CASCADE"), nullable=False),
        sa.Column("value_number", sa.Float(), nullable=True),
        sa.Column("value_text", sa.Text(), nullable=True),
        sa.Column("value_date", sa.DateTime(timezone=True), nullable=True),
        sa.Column("source_url", sa.Text(), nullable=True),
        sa.Column("verified", sa.Boolean(), nullable=False, server_default="false"),
        sa.Column("updated_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("metadata", postgresql.JSONB(), server_default="{}", nullable=False),
    )
    op.create_index("ix_entity_attributes_entity", "knowledge_entity_attributes", ["entity_id"])
    op.create_index("ix_entity_attributes_attribute", "knowledge_entity_attributes", ["attribute_id"])
    op.create_index("ix_entity_attributes_entity_attr", "knowledge_entity_attributes", ["entity_id", "attribute_id"])
    op.create_index("ix_entity_attributes_value_number", "knowledge_entity_attributes", ["value_number"])

    # ── procedural_generators ─────────────────────────────────────────────
    op.create_table(
        "procedural_generators",
        sa.Column("id", postgresql.UUID(as_uuid=True), primary_key=True),
        sa.Column("slug", sa.Text(), unique=True, nullable=False),
        sa.Column("generator_type", sa.Text(), nullable=False),
        sa.Column("enabled", sa.Boolean(), nullable=False, server_default="true"),
        sa.Column("config", postgresql.JSONB(), nullable=False, server_default="{}"),
        sa.Column("metadata", postgresql.JSONB(), server_default="{}", nullable=False),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
    )
    op.create_index("ix_procedural_generators_type", "procedural_generators", ["generator_type"])
    op.create_index("ix_procedural_generators_enabled", "procedural_generators", ["enabled"])

    # ── generated_match_questions ─────────────────────────────────────────
    op.create_table(
        "generated_match_questions",
        sa.Column("id", postgresql.UUID(as_uuid=True), primary_key=True),
        sa.Column("match_id", postgresql.UUID(as_uuid=True), nullable=False),
        sa.Column("generator_id", postgresql.UUID(as_uuid=True),
                  sa.ForeignKey("procedural_generators.id", ondelete="SET NULL"), nullable=True),
        sa.Column("question_type", sa.Text(), nullable=False),
        sa.Column("generated_payload", postgresql.JSONB(), nullable=False),
        sa.Column("difficulty_score", sa.Float(), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
    )
    op.create_index("ix_generated_match_questions_match", "generated_match_questions", ["match_id"])
    op.create_index("ix_generated_match_questions_type", "generated_match_questions", ["question_type"])
    op.create_index("ix_generated_match_questions_generator", "generated_match_questions", ["generator_id"])


def downgrade() -> None:
    op.drop_table("generated_match_questions")
    op.drop_table("procedural_generators")
    op.drop_table("knowledge_entity_attributes")
    op.drop_table("knowledge_attributes")
    op.drop_table("knowledge_entities")
    op.drop_table("timeline_events")
