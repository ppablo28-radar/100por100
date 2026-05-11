"""Initial schema — all 18 tables

Revision ID: 001
Revises:
Create Date: 2026-05-11
"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

revision = "001"
down_revision = None
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ── media_assets ──────────────────────────────────────────────────────
    op.create_table(
        "media_assets",
        sa.Column("id", postgresql.UUID(as_uuid=True), primary_key=True),
        sa.Column("media_type", sa.Text(), nullable=False),
        sa.Column("storage_provider", sa.Text(), nullable=False),
        sa.Column("url", sa.Text(), nullable=False),
        sa.Column("thumbnail_url", sa.Text(), nullable=True),
        sa.Column("duration_ms", sa.Integer(), nullable=True),
        sa.Column("width", sa.Integer(), nullable=True),
        sa.Column("height", sa.Integer(), nullable=True),
        sa.Column("metadata", postgresql.JSONB(), server_default="{}", nullable=False),
    )

    # ── questions ─────────────────────────────────────────────────────────
    op.create_table(
        "questions",
        sa.Column("id", postgresql.UUID(as_uuid=True), primary_key=True),
        sa.Column("version", sa.Integer(), nullable=False, server_default="1"),
        sa.Column("slug", sa.Text(), unique=True, nullable=False),
        sa.Column("status", sa.Text(), nullable=False, server_default="draft"),
        sa.Column("enabled", sa.Boolean(), nullable=False, server_default="false"),
        sa.Column("archived", sa.Boolean(), nullable=False, server_default="false"),
        sa.Column("answer_mode", sa.Text(), nullable=False, server_default="multiple_choice"),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("published_at", sa.DateTime(timezone=True), nullable=True),
        sa.Column("created_by_type", sa.Text(), nullable=False, server_default="human"),
        sa.Column("created_by_id", sa.Text(), nullable=True),
        sa.Column("reviewed_by_type", sa.Text(), nullable=True),
        sa.Column("reviewed_by_id", sa.Text(), nullable=True),
        sa.Column("default_duration_seconds", sa.Integer(), nullable=False, server_default="10"),
        sa.Column("difficulty_manual", sa.Float(), nullable=True),
        sa.Column("difficulty_estimated", sa.Float(), nullable=True),
        sa.Column("confidence_score", sa.Float(), nullable=True),
        sa.Column("fun_score_estimated", sa.Float(), nullable=True),
        sa.Column("engagement_score_estimated", sa.Float(), nullable=True),
        sa.Column("learning_value_score", sa.Float(), nullable=True),
        sa.Column("virality_score", sa.Float(), nullable=True),
        sa.Column("reading_complexity_score", sa.Float(), nullable=True),
        sa.Column("mainstream_score", sa.Float(), nullable=True),
        sa.Column("sensitivity_score", sa.Float(), nullable=True),
        sa.Column("metadata", postgresql.JSONB(), server_default="{}", nullable=False),
    )
    op.create_index("ix_questions_status", "questions", ["status"])
    op.create_index("ix_questions_enabled_archived", "questions", ["enabled", "archived"])
    op.create_index("ix_questions_answer_mode", "questions", ["answer_mode"])
    op.create_index("ix_questions_created_by_type", "questions", ["created_by_type"])

    # ── question_translations ─────────────────────────────────────────────
    op.create_table(
        "question_translations",
        sa.Column("id", postgresql.UUID(as_uuid=True), primary_key=True),
        sa.Column("question_id", postgresql.UUID(as_uuid=True), sa.ForeignKey("questions.id", ondelete="CASCADE"), nullable=False),
        sa.Column("language", sa.Text(), nullable=False),
        sa.Column("title", sa.Text(), nullable=False),
        sa.Column("subtitle", sa.Text(), nullable=True),
        sa.Column("explanation", sa.Text(), nullable=True),
        sa.Column("short_version", sa.Text(), nullable=True),
        sa.Column("keywords", postgresql.JSONB(), server_default="[]", nullable=False),
    )
    op.create_index("ix_question_translations_question_lang", "question_translations", ["question_id", "language"])

    # ── answer_options ────────────────────────────────────────────────────
    op.create_table(
        "answer_options",
        sa.Column("id", postgresql.UUID(as_uuid=True), primary_key=True),
        sa.Column("question_id", postgresql.UUID(as_uuid=True), sa.ForeignKey("questions.id", ondelete="CASCADE"), nullable=False),
        sa.Column("version", sa.Integer(), nullable=False, server_default="1"),
        sa.Column("display_order", sa.Integer(), nullable=False, server_default="0"),
        sa.Column("text", sa.Text(), nullable=False),
        sa.Column("short_text", sa.Text(), nullable=True),
        sa.Column("media_asset_id", postgresql.UUID(as_uuid=True), sa.ForeignKey("media_assets.id", ondelete="SET NULL"), nullable=True),
        sa.Column("is_correct", sa.Boolean(), nullable=False, server_default="false"),
        sa.Column("enabled", sa.Boolean(), nullable=False, server_default="true"),
        sa.Column("weight", sa.Float(), nullable=False, server_default="1.0"),
        sa.Column("plausibility_score", sa.Float(), nullable=True),
        sa.Column("confusion_score", sa.Float(), nullable=True),
        sa.Column("humor_score", sa.Float(), nullable=True),
        sa.Column("metadata", postgresql.JSONB(), server_default="{}", nullable=False),
    )
    op.create_index("ix_answer_options_question_id", "answer_options", ["question_id"])
    op.create_index("ix_answer_options_is_correct", "answer_options", ["question_id", "is_correct"])

    # ── answer_validation_rules ───────────────────────────────────────────
    op.create_table(
        "answer_validation_rules",
        sa.Column("id", postgresql.UUID(as_uuid=True), primary_key=True),
        sa.Column("question_id", postgresql.UUID(as_uuid=True), sa.ForeignKey("questions.id", ondelete="CASCADE"), nullable=False),
        sa.Column("validation_type", sa.Text(), nullable=False),
        sa.Column("validation_data", postgresql.JSONB(), nullable=False),
    )
    op.create_index("ix_validation_rules_question_id", "answer_validation_rules", ["question_id"])

    # ── categories ────────────────────────────────────────────────────────
    op.create_table(
        "categories",
        sa.Column("id", postgresql.UUID(as_uuid=True), primary_key=True),
        sa.Column("parent_id", postgresql.UUID(as_uuid=True), sa.ForeignKey("categories.id", ondelete="SET NULL"), nullable=True),
        sa.Column("name", sa.Text(), nullable=False),
        sa.Column("slug", sa.Text(), unique=True, nullable=False),
        sa.Column("enabled", sa.Boolean(), nullable=False, server_default="true"),
        sa.Column("metadata", postgresql.JSONB(), server_default="{}", nullable=False),
    )
    op.create_index("ix_categories_slug", "categories", ["slug"])

    # ── question_categories ───────────────────────────────────────────────
    op.create_table(
        "question_categories",
        sa.Column("question_id", postgresql.UUID(as_uuid=True), sa.ForeignKey("questions.id", ondelete="CASCADE"), primary_key=True),
        sa.Column("category_id", postgresql.UUID(as_uuid=True), sa.ForeignKey("categories.id", ondelete="CASCADE"), primary_key=True),
    )

    # ── tags ──────────────────────────────────────────────────────────────
    op.create_table(
        "tags",
        sa.Column("id", postgresql.UUID(as_uuid=True), primary_key=True),
        sa.Column("name", sa.Text(), nullable=False),
        sa.Column("slug", sa.Text(), unique=True, nullable=False),
    )
    op.create_index("ix_tags_slug", "tags", ["slug"])

    # ── question_tags ─────────────────────────────────────────────────────
    op.create_table(
        "question_tags",
        sa.Column("question_id", postgresql.UUID(as_uuid=True), sa.ForeignKey("questions.id", ondelete="CASCADE"), primary_key=True),
        sa.Column("tag_id", postgresql.UUID(as_uuid=True), sa.ForeignKey("tags.id", ondelete="CASCADE"), primary_key=True),
    )

    # ── question_target_audiences ─────────────────────────────────────────
    op.create_table(
        "question_target_audiences",
        sa.Column("id", postgresql.UUID(as_uuid=True), primary_key=True),
        sa.Column("question_id", postgresql.UUID(as_uuid=True), sa.ForeignKey("questions.id", ondelete="CASCADE"), nullable=False),
        sa.Column("min_age", sa.Integer(), nullable=True),
        sa.Column("max_age", sa.Integer(), nullable=True),
        sa.Column("region", sa.Text(), nullable=True),
        sa.Column("language", sa.Text(), nullable=True),
        sa.Column("audience_type", sa.Text(), nullable=True),
        sa.Column("kid_friendly", sa.Boolean(), nullable=False, server_default="true"),
        sa.Column("metadata", postgresql.JSONB(), server_default="{}", nullable=False),
    )
    op.create_index("ix_target_audiences_question_id", "question_target_audiences", ["question_id"])
    op.create_index("ix_target_audiences_kid_friendly", "question_target_audiences", ["kid_friendly"])
    op.create_index("ix_target_audiences_age_range", "question_target_audiences", ["min_age", "max_age"])

    # ── question_analytics ────────────────────────────────────────────────
    op.create_table(
        "question_analytics",
        sa.Column("question_id", postgresql.UUID(as_uuid=True), sa.ForeignKey("questions.id", ondelete="CASCADE"), primary_key=True),
        sa.Column("times_shown", sa.BigInteger(), nullable=False, server_default="0"),
        sa.Column("times_answered", sa.BigInteger(), nullable=False, server_default="0"),
        sa.Column("times_skipped", sa.BigInteger(), nullable=False, server_default="0"),
        sa.Column("correct_rate", sa.Float(), nullable=True),
        sa.Column("average_response_time_ms", sa.Float(), nullable=True),
        sa.Column("median_response_time_ms", sa.Float(), nullable=True),
        sa.Column("abandonment_rate", sa.Float(), nullable=True),
        sa.Column("report_rate", sa.Float(), nullable=True),
        sa.Column("engagement_score", sa.Float(), nullable=True),
        sa.Column("fun_score", sa.Float(), nullable=True),
        sa.Column("frustration_score", sa.Float(), nullable=True),
        sa.Column("virality_score", sa.Float(), nullable=True),
        sa.Column("learning_score", sa.Float(), nullable=True),
        sa.Column("difficulty_real", sa.Float(), nullable=True),
        sa.Column("freshness_score", sa.Float(), nullable=True),
        sa.Column("replayability_score", sa.Float(), nullable=True),
        sa.Column("option_pick_rates", postgresql.JSONB(), server_default="{}", nullable=False),
        sa.Column("audience_difficulty_profiles", postgresql.JSONB(), server_default="{}", nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
    )

    # ── question_feedback ─────────────────────────────────────────────────
    op.create_table(
        "question_feedback",
        sa.Column("id", postgresql.UUID(as_uuid=True), primary_key=True),
        sa.Column("player_id", postgresql.UUID(as_uuid=True), nullable=False),
        sa.Column("question_id", postgresql.UUID(as_uuid=True), sa.ForeignKey("questions.id", ondelete="CASCADE"), nullable=False),
        sa.Column("match_id", postgresql.UUID(as_uuid=True), nullable=True),
        sa.Column("feedback_type", sa.Text(), nullable=False),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("metadata", postgresql.JSONB(), server_default="{}", nullable=False),
    )
    op.create_index("ix_question_feedback_question_id", "question_feedback", ["question_id"])
    op.create_index("ix_question_feedback_player_id", "question_feedback", ["player_id"])
    op.create_index("ix_question_feedback_type", "question_feedback", ["feedback_type"])

    # ── question_attempts ─────────────────────────────────────────────────
    op.create_table(
        "question_attempts",
        sa.Column("id", postgresql.UUID(as_uuid=True), primary_key=True),
        sa.Column("match_id", postgresql.UUID(as_uuid=True), nullable=False),
        sa.Column("player_id", postgresql.UUID(as_uuid=True), nullable=False),
        sa.Column("question_id", postgresql.UUID(as_uuid=True), sa.ForeignKey("questions.id", ondelete="CASCADE"), nullable=False),
        sa.Column("question_version", sa.Integer(), nullable=False, server_default="1"),
        sa.Column("response_time_ms", sa.Integer(), nullable=True),
        sa.Column("correct", sa.Boolean(), nullable=False),
        sa.Column("points_earned", sa.Integer(), nullable=False, server_default="0"),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("selected_answers", postgresql.JSONB(), nullable=False),
        sa.Column("displayed_options", postgresql.JSONB(), server_default="[]", nullable=False),
        sa.Column("latency_ms", sa.Integer(), nullable=True),
        sa.Column("device_type", sa.Text(), nullable=True),
        sa.Column("metadata", postgresql.JSONB(), server_default="{}", nullable=False),
    )
    op.create_index("ix_attempts_match_id", "question_attempts", ["match_id"])
    op.create_index("ix_attempts_player_id", "question_attempts", ["player_id"])
    op.create_index("ix_attempts_question_id", "question_attempts", ["question_id"])
    op.create_index("ix_attempts_created_at", "question_attempts", ["created_at"])
    op.create_index("ix_attempts_match_player", "question_attempts", ["match_id", "player_id"])

    # ── ai_generation_jobs ────────────────────────────────────────────────
    op.create_table(
        "ai_generation_jobs",
        sa.Column("id", postgresql.UUID(as_uuid=True), primary_key=True),
        sa.Column("provider", sa.Text(), nullable=False),
        sa.Column("model", sa.Text(), nullable=False),
        sa.Column("prompt", sa.Text(), nullable=False),
        sa.Column("generated_count", sa.Integer(), nullable=False, server_default="0"),
        sa.Column("accepted_count", sa.Integer(), nullable=False, server_default="0"),
        sa.Column("rejected_count", sa.Integer(), nullable=False, server_default="0"),
        sa.Column("hallucination_score", sa.Float(), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("metadata", postgresql.JSONB(), server_default="{}", nullable=False),
    )
    op.create_index("ix_ai_generation_jobs_created_at", "ai_generation_jobs", ["created_at"])

    # ── ai_review_results ─────────────────────────────────────────────────
    op.create_table(
        "ai_review_results",
        sa.Column("id", postgresql.UUID(as_uuid=True), primary_key=True),
        sa.Column("question_id", postgresql.UUID(as_uuid=True), sa.ForeignKey("questions.id", ondelete="CASCADE"), nullable=False),
        sa.Column("model", sa.Text(), nullable=False),
        sa.Column("clarity_score", sa.Float(), nullable=True),
        sa.Column("ambiguity_score", sa.Float(), nullable=True),
        sa.Column("kid_safety_score", sa.Float(), nullable=True),
        sa.Column("factual_confidence_score", sa.Float(), nullable=True),
        sa.Column("duplicate_probability", sa.Float(), nullable=True),
        sa.Column("recommendation", sa.Text(), nullable=False),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("metadata", postgresql.JSONB(), server_default="{}", nullable=False),
    )
    op.create_index("ix_ai_review_results_question_id", "ai_review_results", ["question_id"])
    op.create_index("ix_ai_review_results_recommendation", "ai_review_results", ["recommendation"])

    # ── question_collections ──────────────────────────────────────────────
    op.create_table(
        "question_collections",
        sa.Column("id", postgresql.UUID(as_uuid=True), primary_key=True),
        sa.Column("name", sa.Text(), nullable=False),
        sa.Column("collection_type", sa.Text(), nullable=False),
        sa.Column("metadata", postgresql.JSONB(), server_default="{}", nullable=False),
    )

    # ── question_collection_items ─────────────────────────────────────────
    op.create_table(
        "question_collection_items",
        sa.Column("collection_id", postgresql.UUID(as_uuid=True), sa.ForeignKey("question_collections.id", ondelete="CASCADE"), primary_key=True),
        sa.Column("question_id", postgresql.UUID(as_uuid=True), sa.ForeignKey("questions.id", ondelete="CASCADE"), primary_key=True),
    )

    # ── question_events ───────────────────────────────────────────────────
    op.create_table(
        "question_events",
        sa.Column("id", postgresql.UUID(as_uuid=True), primary_key=True),
        sa.Column("question_id", postgresql.UUID(as_uuid=True), sa.ForeignKey("questions.id", ondelete="CASCADE"), nullable=False),
        sa.Column("event_type", sa.Text(), nullable=False),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("payload", postgresql.JSONB(), server_default="{}", nullable=False),
    )
    op.create_index("ix_question_events_question_id", "question_events", ["question_id"])
    op.create_index("ix_question_events_event_type", "question_events", ["event_type"])
    op.create_index("ix_question_events_created_at", "question_events", ["created_at"])


def downgrade() -> None:
    op.drop_table("question_events")
    op.drop_table("question_collection_items")
    op.drop_table("question_collections")
    op.drop_table("ai_review_results")
    op.drop_table("ai_generation_jobs")
    op.drop_table("question_attempts")
    op.drop_table("question_feedback")
    op.drop_table("question_analytics")
    op.drop_table("question_target_audiences")
    op.drop_table("question_tags")
    op.drop_table("tags")
    op.drop_table("question_categories")
    op.drop_table("categories")
    op.drop_table("answer_validation_rules")
    op.drop_table("answer_options")
    op.drop_table("question_translations")
    op.drop_table("questions")
    op.drop_table("media_assets")
