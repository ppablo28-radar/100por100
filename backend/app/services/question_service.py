import uuid
from typing import Optional

from sqlalchemy.ext.asyncio import AsyncSession

from app.models.collections import QuestionEvent
from app.models.questions import Question
from app.repositories.question_repository import QuestionRepository
from app.schemas.questions import (
    QuestionAttemptCreate,
    QuestionCreate,
    QuestionFeedbackCreate,
    QuestionRead,
    QuestionUpdate,
)


class QuestionService:
    def __init__(self, db: AsyncSession):
        self.repo = QuestionRepository(db)
        self.db = db

    async def create_question(self, data: QuestionCreate) -> Question:
        question = await self.repo.create(data)
        await self._emit_event(question.id, "QUESTION_CREATED", {"slug": data.slug})
        return question

    async def approve_question(
        self, question_id: uuid.UUID, reviewer_id: str, reviewer_type: str = "human"
    ) -> Optional[Question]:
        question = await self.repo.update(
            question_id,
            QuestionUpdate(
                status="approved",
                enabled=True,
                reviewed_by_id=reviewer_id,
                reviewed_by_type=reviewer_type,
            ),
        )
        if question:
            await self._emit_event(
                question_id,
                "QUESTION_APPROVED",
                {"reviewer_id": reviewer_id, "reviewer_type": reviewer_type},
            )
        return question

    async def reject_question(
        self,
        question_id: uuid.UUID,
        reviewer_id: str,
        reason: str,
        reviewer_type: str = "human",
    ) -> Optional[Question]:
        question = await self.repo.update(
            question_id,
            QuestionUpdate(
                status="rejected",
                enabled=False,
                reviewed_by_id=reviewer_id,
                reviewed_by_type=reviewer_type,
            ),
        )
        if question:
            await self._emit_event(
                question_id,
                "QUESTION_REJECTED",
                {"reviewer_id": reviewer_id, "reason": reason},
            )
        return question

    async def disable_question(self, question_id: uuid.UUID, reason: str = "") -> None:
        await self.repo.update(
            question_id, QuestionUpdate(enabled=False, status="approved")
        )
        await self._emit_event(
            question_id, "QUESTION_DISABLED", {"reason": reason}
        )

    async def archive_question(
        self, question_id: uuid.UUID, reason: str = ""
    ) -> None:
        await self.repo.soft_delete(question_id)
        await self._emit_event(
            question_id, "QUESTION_ARCHIVED", {"reason": reason}
        )

    async def get_questions_for_match(
        self,
        count: int = 10,
        language: str = "es",
        answer_mode: str = "multiple_choice",
    ) -> list[Question]:
        """Returns a random selection of approved questions ready for a match."""
        return await self.repo.sample_for_match(
            count=count, language=language, answer_mode=answer_mode
        )

    async def record_attempt(self, data: QuestionAttemptCreate):
        return await self.repo.record_attempt(data)

    async def record_feedback(self, data: QuestionFeedbackCreate):
        feedback = await self.repo.record_feedback(data)
        if data.feedback_type in ("offensive", "ambiguous"):
            await self._emit_event(
                data.question_id,
                "QUESTION_REPORTED",
                {
                    "player_id": str(data.player_id),
                    "feedback_type": data.feedback_type,
                },
            )
        return feedback

    async def get_question(self, question_id: uuid.UUID) -> Optional[Question]:
        return await self.repo.get_by_id(question_id)

    async def list_approved(
        self,
        language: str = "es",
        limit: int = 50,
        offset: int = 0,
    ) -> list[Question]:
        return await self.repo.list_approved(
            language=language, limit=limit, offset=offset
        )

    # ─── Internal ──────────────────────────────────────────────────────────

    async def _emit_event(
        self, question_id: uuid.UUID, event_type: str, payload: dict
    ) -> None:
        event = QuestionEvent(
            question_id=question_id,
            event_type=event_type,
            payload=payload,
        )
        self.db.add(event)
        await self.db.flush()
