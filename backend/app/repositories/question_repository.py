import uuid
from typing import Optional

from sqlalchemy import select, update
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.models.questions import Question, QuestionTranslation, AnswerOption
from app.models.analytics import QuestionAnalytics, QuestionAttempt, QuestionFeedback
from app.schemas.questions import (
    QuestionCreate,
    QuestionUpdate,
    QuestionAttemptCreate,
    QuestionFeedbackCreate,
)


class QuestionRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    # ─── Read ──────────────────────────────────────────────────────────────

    async def get_by_id(self, question_id: uuid.UUID) -> Optional[Question]:
        result = await self.db.execute(
            select(Question)
            .where(Question.id == question_id)
            .options(
                selectinload(Question.translations),
                selectinload(Question.answer_options),
                selectinload(Question.validation_rules),
                selectinload(Question.target_audiences),
            )
        )
        return result.scalar_one_or_none()

    async def get_by_slug(self, slug: str) -> Optional[Question]:
        result = await self.db.execute(
            select(Question)
            .where(Question.slug == slug)
            .options(
                selectinload(Question.translations),
                selectinload(Question.answer_options),
            )
        )
        return result.scalar_one_or_none()

    async def list_approved(
        self,
        language: str = "es",
        limit: int = 100,
        offset: int = 0,
        answer_mode: Optional[str] = None,
        max_difficulty: Optional[float] = None,
    ) -> list[Question]:
        stmt = (
            select(Question)
            .where(
                Question.status == "approved",
                Question.enabled == True,
                Question.archived == False,
            )
            .options(
                selectinload(Question.translations),
                selectinload(Question.answer_options),
            )
            .limit(limit)
            .offset(offset)
        )
        if answer_mode:
            stmt = stmt.where(Question.answer_mode == answer_mode)
        if max_difficulty is not None:
            stmt = stmt.where(
                (Question.difficulty_estimated <= max_difficulty)
                | (Question.difficulty_estimated.is_(None))
            )
        result = await self.db.execute(stmt)
        return list(result.scalars().all())

    async def sample_for_match(
        self,
        count: int = 10,
        language: str = "es",
        answer_mode: str = "multiple_choice",
    ) -> list[Question]:
        """Random sample of approved questions for a match."""
        result = await self.db.execute(
            select(Question)
            .where(
                Question.status == "approved",
                Question.enabled == True,
                Question.archived == False,
                Question.answer_mode == answer_mode,
            )
            .options(
                selectinload(Question.translations),
                selectinload(Question.answer_options),
            )
            # TABLESAMPLE SYSTEM is faster but less random for small tables
            .order_by(
                # PostgreSQL random() — works fine for MVP scale
                # Replace with smarter selection (weighted by engagement/freshness) later
                Question.id  # placeholder; see service layer for random
            )
            .limit(count * 3)  # over-fetch then shuffle in Python
        )
        import random
        rows = list(result.scalars().all())
        random.shuffle(rows)
        return rows[:count]

    # ─── Write ─────────────────────────────────────────────────────────────

    async def create(self, data: QuestionCreate) -> Question:
        question = Question(
            slug=data.slug,
            answer_mode=data.answer_mode,
            status=data.status,
            enabled=data.enabled,
            default_duration_seconds=data.default_duration_seconds,
            created_by_type=data.created_by_type,
            created_by_id=data.created_by_id,
            difficulty_manual=data.difficulty_manual,
            metadata_=data.metadata,
        )
        for t in data.translations:
            question.translations.append(
                QuestionTranslation(
                    language=t.language,
                    title=t.title,
                    subtitle=t.subtitle,
                    explanation=t.explanation,
                    short_version=t.short_version,
                    keywords=t.keywords,
                )
            )
        for i, opt in enumerate(data.answer_options):
            question.answer_options.append(
                AnswerOption(
                    text=opt.text,
                    short_text=opt.short_text,
                    display_order=opt.display_order if opt.display_order else i,
                    is_correct=opt.is_correct,
                    enabled=opt.enabled,
                    weight=opt.weight,
                    metadata_=opt.metadata,
                )
            )
        self.db.add(question)
        await self.db.flush()
        return question

    async def update(
        self, question_id: uuid.UUID, data: QuestionUpdate
    ) -> Optional[Question]:
        values = {k: v for k, v in data.model_dump(exclude_none=True).items()}
        if not values:
            return await self.get_by_id(question_id)
        await self.db.execute(
            update(Question).where(Question.id == question_id).values(**values)
        )
        await self.db.flush()
        return await self.get_by_id(question_id)

    async def soft_delete(self, question_id: uuid.UUID) -> None:
        await self.db.execute(
            update(Question)
            .where(Question.id == question_id)
            .values(archived=True, enabled=False)
        )

    # ─── Analytics ─────────────────────────────────────────────────────────

    async def record_attempt(self, data: QuestionAttemptCreate) -> QuestionAttempt:
        attempt = QuestionAttempt(
            match_id=data.match_id,
            player_id=data.player_id,
            question_id=data.question_id,
            question_version=data.question_version,
            response_time_ms=data.response_time_ms,
            correct=data.correct,
            points_earned=data.points_earned,
            selected_answers=data.selected_answers
            if isinstance(data.selected_answers, dict)
            else {"values": data.selected_answers},
            displayed_options=data.displayed_options,
            latency_ms=data.latency_ms,
            device_type=data.device_type,
            metadata_=data.metadata,
        )
        self.db.add(attempt)
        await self.db.flush()
        return attempt

    async def record_feedback(
        self, data: QuestionFeedbackCreate
    ) -> QuestionFeedback:
        feedback = QuestionFeedback(
            player_id=data.player_id,
            question_id=data.question_id,
            match_id=data.match_id,
            feedback_type=data.feedback_type,
            metadata_=data.metadata,
        )
        self.db.add(feedback)
        await self.db.flush()
        return feedback

    async def get_analytics(
        self, question_id: uuid.UUID
    ) -> Optional[QuestionAnalytics]:
        result = await self.db.execute(
            select(QuestionAnalytics).where(
                QuestionAnalytics.question_id == question_id
            )
        )
        return result.scalar_one_or_none()
