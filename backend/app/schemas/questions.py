import uuid
from datetime import datetime
from typing import Any, Optional

from pydantic import BaseModel, Field


# ─── Answer Options ───────────────────────────────────────────────────────────

class AnswerOptionBase(BaseModel):
    text: str
    short_text: Optional[str] = None
    display_order: int = 0
    is_correct: bool = False
    enabled: bool = True
    weight: float = 1.0
    plausibility_score: Optional[float] = None
    confusion_score: Optional[float] = None
    humor_score: Optional[float] = None
    metadata: dict[str, Any] = Field(default_factory=dict)


class AnswerOptionCreate(AnswerOptionBase):
    pass


class AnswerOptionRead(AnswerOptionBase):
    id: uuid.UUID
    question_id: uuid.UUID
    version: int

    model_config = {"from_attributes": True}


# ─── Validation Rules ─────────────────────────────────────────────────────────

class AnswerValidationRuleBase(BaseModel):
    validation_type: str
    validation_data: dict[str, Any]


class AnswerValidationRuleCreate(AnswerValidationRuleBase):
    pass


class AnswerValidationRuleRead(AnswerValidationRuleBase):
    id: uuid.UUID
    question_id: uuid.UUID

    model_config = {"from_attributes": True}


# ─── Translations ─────────────────────────────────────────────────────────────

class QuestionTranslationBase(BaseModel):
    language: str
    title: str
    subtitle: Optional[str] = None
    explanation: Optional[str] = None
    short_version: Optional[str] = None
    keywords: list[str] = Field(default_factory=list)


class QuestionTranslationCreate(QuestionTranslationBase):
    pass


class QuestionTranslationRead(QuestionTranslationBase):
    id: uuid.UUID
    question_id: uuid.UUID

    model_config = {"from_attributes": True}


# ─── Question ─────────────────────────────────────────────────────────────────

class QuestionBase(BaseModel):
    slug: str
    answer_mode: str = "multiple_choice"
    status: str = "draft"
    enabled: bool = False
    default_duration_seconds: int = 10
    created_by_type: str = "human"
    created_by_id: Optional[str] = None
    difficulty_manual: Optional[float] = None
    metadata: dict[str, Any] = Field(default_factory=dict)


class QuestionCreate(QuestionBase):
    translations: list[QuestionTranslationCreate] = Field(default_factory=list)
    answer_options: list[AnswerOptionCreate] = Field(default_factory=list)
    validation_rules: list[AnswerValidationRuleCreate] = Field(default_factory=list)


class QuestionUpdate(BaseModel):
    status: Optional[str] = None
    enabled: Optional[bool] = None
    archived: Optional[bool] = None
    default_duration_seconds: Optional[int] = None
    difficulty_manual: Optional[float] = None
    reviewed_by_type: Optional[str] = None
    reviewed_by_id: Optional[str] = None
    metadata: Optional[dict[str, Any]] = None


class QuestionRead(QuestionBase):
    id: uuid.UUID
    version: int
    archived: bool
    created_at: datetime
    updated_at: datetime
    published_at: Optional[datetime] = None
    difficulty_estimated: Optional[float] = None
    confidence_score: Optional[float] = None
    fun_score_estimated: Optional[float] = None
    translations: list[QuestionTranslationRead] = Field(default_factory=list)
    answer_options: list[AnswerOptionRead] = Field(default_factory=list)

    model_config = {"from_attributes": True}


# ─── Attempt ──────────────────────────────────────────────────────────────────

class QuestionAttemptCreate(BaseModel):
    match_id: uuid.UUID
    player_id: uuid.UUID
    question_id: uuid.UUID
    question_version: int = 1
    response_time_ms: Optional[int] = None
    correct: bool
    points_earned: int = 0
    selected_answers: dict[str, Any] | list[Any]
    displayed_options: list[Any] = Field(default_factory=list)
    latency_ms: Optional[int] = None
    device_type: Optional[str] = None
    metadata: dict[str, Any] = Field(default_factory=dict)


class QuestionAttemptRead(QuestionAttemptCreate):
    id: uuid.UUID
    created_at: datetime

    model_config = {"from_attributes": True}


# ─── Feedback ─────────────────────────────────────────────────────────────────

class QuestionFeedbackCreate(BaseModel):
    player_id: uuid.UUID
    question_id: uuid.UUID
    match_id: Optional[uuid.UUID] = None
    feedback_type: str
    metadata: dict[str, Any] = Field(default_factory=dict)


# ─── Analytics ────────────────────────────────────────────────────────────────

class QuestionAnalyticsRead(BaseModel):
    question_id: uuid.UUID
    times_shown: int
    times_answered: int
    correct_rate: Optional[float]
    average_response_time_ms: Optional[float]
    difficulty_real: Optional[float]
    fun_score: Optional[float]
    engagement_score: Optional[float]
    option_pick_rates: dict[str, Any]
    updated_at: datetime

    model_config = {"from_attributes": True}


# ─── AI Review ────────────────────────────────────────────────────────────────

class AIReviewResultRead(BaseModel):
    id: uuid.UUID
    question_id: uuid.UUID
    model: str
    clarity_score: Optional[float]
    ambiguity_score: Optional[float]
    kid_safety_score: Optional[float]
    factual_confidence_score: Optional[float]
    duplicate_probability: Optional[float]
    recommendation: str
    created_at: datetime

    model_config = {"from_attributes": True}
