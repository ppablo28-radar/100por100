BEGIN;

CREATE TABLE alembic_version (
    version_num VARCHAR(32) NOT NULL, 
    CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num)
);

-- Running upgrade  -> 001

CREATE TABLE media_assets (
    id UUID NOT NULL, 
    media_type TEXT NOT NULL, 
    storage_provider TEXT NOT NULL, 
    url TEXT NOT NULL, 
    thumbnail_url TEXT, 
    duration_ms INTEGER, 
    width INTEGER, 
    height INTEGER, 
    metadata JSONB DEFAULT '{}' NOT NULL, 
    PRIMARY KEY (id)
);

CREATE TABLE questions (
    id UUID NOT NULL, 
    version INTEGER DEFAULT '1' NOT NULL, 
    slug TEXT NOT NULL, 
    status TEXT DEFAULT 'draft' NOT NULL, 
    enabled BOOLEAN DEFAULT 'false' NOT NULL, 
    archived BOOLEAN DEFAULT 'false' NOT NULL, 
    answer_mode TEXT DEFAULT 'multiple_choice' NOT NULL, 
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL, 
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL, 
    published_at TIMESTAMP WITH TIME ZONE, 
    created_by_type TEXT DEFAULT 'human' NOT NULL, 
    created_by_id TEXT, 
    reviewed_by_type TEXT, 
    reviewed_by_id TEXT, 
    default_duration_seconds INTEGER DEFAULT '10' NOT NULL, 
    difficulty_manual FLOAT, 
    difficulty_estimated FLOAT, 
    confidence_score FLOAT, 
    fun_score_estimated FLOAT, 
    engagement_score_estimated FLOAT, 
    learning_value_score FLOAT, 
    virality_score FLOAT, 
    reading_complexity_score FLOAT, 
    mainstream_score FLOAT, 
    sensitivity_score FLOAT, 
    metadata JSONB DEFAULT '{}' NOT NULL, 
    PRIMARY KEY (id), 
    UNIQUE (slug)
);

CREATE INDEX ix_questions_status ON questions (status);

CREATE INDEX ix_questions_enabled_archived ON questions (enabled, archived);

CREATE INDEX ix_questions_answer_mode ON questions (answer_mode);

CREATE INDEX ix_questions_created_by_type ON questions (created_by_type);

CREATE TABLE question_translations (
    id UUID NOT NULL, 
    question_id UUID NOT NULL, 
    language TEXT NOT NULL, 
    title TEXT NOT NULL, 
    subtitle TEXT, 
    explanation TEXT, 
    short_version TEXT, 
    keywords JSONB DEFAULT '[]' NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY(question_id) REFERENCES questions (id) ON DELETE CASCADE
);

CREATE INDEX ix_question_translations_question_lang ON question_translations (question_id, language);

CREATE TABLE answer_options (
    id UUID NOT NULL, 
    question_id UUID NOT NULL, 
    version INTEGER DEFAULT '1' NOT NULL, 
    display_order INTEGER DEFAULT '0' NOT NULL, 
    text TEXT NOT NULL, 
    short_text TEXT, 
    media_asset_id UUID, 
    is_correct BOOLEAN DEFAULT 'false' NOT NULL, 
    enabled BOOLEAN DEFAULT 'true' NOT NULL, 
    weight FLOAT DEFAULT '1.0' NOT NULL, 
    plausibility_score FLOAT, 
    confusion_score FLOAT, 
    humor_score FLOAT, 
    metadata JSONB DEFAULT '{}' NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY(question_id) REFERENCES questions (id) ON DELETE CASCADE, 
    FOREIGN KEY(media_asset_id) REFERENCES media_assets (id) ON DELETE SET NULL
);

CREATE INDEX ix_answer_options_question_id ON answer_options (question_id);

CREATE INDEX ix_answer_options_is_correct ON answer_options (question_id, is_correct);

CREATE TABLE answer_validation_rules (
    id UUID NOT NULL, 
    question_id UUID NOT NULL, 
    validation_type TEXT NOT NULL, 
    validation_data JSONB NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY(question_id) REFERENCES questions (id) ON DELETE CASCADE
);

CREATE INDEX ix_validation_rules_question_id ON answer_validation_rules (question_id);

CREATE TABLE categories (
    id UUID NOT NULL, 
    parent_id UUID, 
    name TEXT NOT NULL, 
    slug TEXT NOT NULL, 
    enabled BOOLEAN DEFAULT 'true' NOT NULL, 
    metadata JSONB DEFAULT '{}' NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY(parent_id) REFERENCES categories (id) ON DELETE SET NULL, 
    UNIQUE (slug)
);

CREATE INDEX ix_categories_slug ON categories (slug);

CREATE TABLE question_categories (
    question_id UUID NOT NULL, 
    category_id UUID NOT NULL, 
    PRIMARY KEY (question_id, category_id), 
    FOREIGN KEY(question_id) REFERENCES questions (id) ON DELETE CASCADE, 
    FOREIGN KEY(category_id) REFERENCES categories (id) ON DELETE CASCADE
);

CREATE TABLE tags (
    id UUID NOT NULL, 
    name TEXT NOT NULL, 
    slug TEXT NOT NULL, 
    PRIMARY KEY (id), 
    UNIQUE (slug)
);

CREATE INDEX ix_tags_slug ON tags (slug);

CREATE TABLE question_tags (
    question_id UUID NOT NULL, 
    tag_id UUID NOT NULL, 
    PRIMARY KEY (question_id, tag_id), 
    FOREIGN KEY(question_id) REFERENCES questions (id) ON DELETE CASCADE, 
    FOREIGN KEY(tag_id) REFERENCES tags (id) ON DELETE CASCADE
);

CREATE TABLE question_target_audiences (
    id UUID NOT NULL, 
    question_id UUID NOT NULL, 
    min_age INTEGER, 
    max_age INTEGER, 
    region TEXT, 
    language TEXT, 
    audience_type TEXT, 
    kid_friendly BOOLEAN DEFAULT 'true' NOT NULL, 
    metadata JSONB DEFAULT '{}' NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY(question_id) REFERENCES questions (id) ON DELETE CASCADE
);

CREATE INDEX ix_target_audiences_question_id ON question_target_audiences (question_id);

CREATE INDEX ix_target_audiences_kid_friendly ON question_target_audiences (kid_friendly);

CREATE INDEX ix_target_audiences_age_range ON question_target_audiences (min_age, max_age);

CREATE TABLE question_analytics (
    question_id UUID NOT NULL, 
    times_shown BIGINT DEFAULT '0' NOT NULL, 
    times_answered BIGINT DEFAULT '0' NOT NULL, 
    times_skipped BIGINT DEFAULT '0' NOT NULL, 
    correct_rate FLOAT, 
    average_response_time_ms FLOAT, 
    median_response_time_ms FLOAT, 
    abandonment_rate FLOAT, 
    report_rate FLOAT, 
    engagement_score FLOAT, 
    fun_score FLOAT, 
    frustration_score FLOAT, 
    virality_score FLOAT, 
    learning_score FLOAT, 
    difficulty_real FLOAT, 
    freshness_score FLOAT, 
    replayability_score FLOAT, 
    option_pick_rates JSONB DEFAULT '{}' NOT NULL, 
    audience_difficulty_profiles JSONB DEFAULT '{}' NOT NULL, 
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL, 
    PRIMARY KEY (question_id), 
    FOREIGN KEY(question_id) REFERENCES questions (id) ON DELETE CASCADE
);

CREATE TABLE question_feedback (
    id UUID NOT NULL, 
    player_id UUID NOT NULL, 
    question_id UUID NOT NULL, 
    match_id UUID, 
    feedback_type TEXT NOT NULL, 
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL, 
    metadata JSONB DEFAULT '{}' NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY(question_id) REFERENCES questions (id) ON DELETE CASCADE
);

CREATE INDEX ix_question_feedback_question_id ON question_feedback (question_id);

CREATE INDEX ix_question_feedback_player_id ON question_feedback (player_id);

CREATE INDEX ix_question_feedback_type ON question_feedback (feedback_type);

CREATE TABLE question_attempts (
    id UUID NOT NULL, 
    match_id UUID NOT NULL, 
    player_id UUID NOT NULL, 
    question_id UUID NOT NULL, 
    question_version INTEGER DEFAULT '1' NOT NULL, 
    response_time_ms INTEGER, 
    correct BOOLEAN NOT NULL, 
    points_earned INTEGER DEFAULT '0' NOT NULL, 
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL, 
    selected_answers JSONB NOT NULL, 
    displayed_options JSONB DEFAULT '[]' NOT NULL, 
    latency_ms INTEGER, 
    device_type TEXT, 
    metadata JSONB DEFAULT '{}' NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY(question_id) REFERENCES questions (id) ON DELETE CASCADE
);

CREATE INDEX ix_attempts_match_id ON question_attempts (match_id);

CREATE INDEX ix_attempts_player_id ON question_attempts (player_id);

CREATE INDEX ix_attempts_question_id ON question_attempts (question_id);

CREATE INDEX ix_attempts_created_at ON question_attempts (created_at);

CREATE INDEX ix_attempts_match_player ON question_attempts (match_id, player_id);

CREATE TABLE ai_generation_jobs (
    id UUID NOT NULL, 
    provider TEXT NOT NULL, 
    model TEXT NOT NULL, 
    prompt TEXT NOT NULL, 
    generated_count INTEGER DEFAULT '0' NOT NULL, 
    accepted_count INTEGER DEFAULT '0' NOT NULL, 
    rejected_count INTEGER DEFAULT '0' NOT NULL, 
    hallucination_score FLOAT, 
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL, 
    metadata JSONB DEFAULT '{}' NOT NULL, 
    PRIMARY KEY (id)
);

CREATE INDEX ix_ai_generation_jobs_created_at ON ai_generation_jobs (created_at);

CREATE TABLE ai_review_results (
    id UUID NOT NULL, 
    question_id UUID NOT NULL, 
    model TEXT NOT NULL, 
    clarity_score FLOAT, 
    ambiguity_score FLOAT, 
    kid_safety_score FLOAT, 
    factual_confidence_score FLOAT, 
    duplicate_probability FLOAT, 
    recommendation TEXT NOT NULL, 
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL, 
    metadata JSONB DEFAULT '{}' NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY(question_id) REFERENCES questions (id) ON DELETE CASCADE
);

CREATE INDEX ix_ai_review_results_question_id ON ai_review_results (question_id);

CREATE INDEX ix_ai_review_results_recommendation ON ai_review_results (recommendation);

CREATE TABLE question_collections (
    id UUID NOT NULL, 
    name TEXT NOT NULL, 
    collection_type TEXT NOT NULL, 
    metadata JSONB DEFAULT '{}' NOT NULL, 
    PRIMARY KEY (id)
);

CREATE TABLE question_collection_items (
    collection_id UUID NOT NULL, 
    question_id UUID NOT NULL, 
    PRIMARY KEY (collection_id, question_id), 
    FOREIGN KEY(collection_id) REFERENCES question_collections (id) ON DELETE CASCADE, 
    FOREIGN KEY(question_id) REFERENCES questions (id) ON DELETE CASCADE
);

CREATE TABLE question_events (
    id UUID NOT NULL, 
    question_id UUID NOT NULL, 
    event_type TEXT NOT NULL, 
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL, 
    payload JSONB DEFAULT '{}' NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY(question_id) REFERENCES questions (id) ON DELETE CASCADE
);

CREATE INDEX ix_question_events_question_id ON question_events (question_id);

CREATE INDEX ix_question_events_event_type ON question_events (event_type);

CREATE INDEX ix_question_events_created_at ON question_events (created_at);

INSERT INTO alembic_version (version_num) VALUES ('001') RETURNING alembic_version.version_num;

COMMIT;

