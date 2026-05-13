"""Repository layer para el motor procedural."""
import uuid
from typing import Optional

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.procedural import (
    TimelineEvent,
    KnowledgeEntity,
    KnowledgeAttribute,
    KnowledgeEntityAttribute,
    ProceduralGenerator,
    GeneratedMatchQuestion,
)


class ProceduralRepository:

    def __init__(self, db: AsyncSession):
        self.db = db

    # ─── Timeline events ───────────────────────────────────────────────────

    async def get_all_events(self, kid_friendly: bool | None = None) -> list[TimelineEvent]:
        q = select(TimelineEvent)
        if kid_friendly is not None:
            q = q.where(TimelineEvent.kid_friendly == kid_friendly)
        result = await self.db.execute(q)
        return list(result.scalars().all())

    async def create_event(self, data: dict) -> TimelineEvent:
        event = TimelineEvent(**data)
        self.db.add(event)
        await self.db.flush()
        return event

    # ─── Knowledge entities ────────────────────────────────────────────────

    async def get_entities(
        self,
        entity_type: str | None = None,
        kid_friendly: bool | None = None,
        min_popularity: float | None = None,
    ) -> list[KnowledgeEntity]:
        q = select(KnowledgeEntity)
        if entity_type:
            q = q.where(KnowledgeEntity.entity_type == entity_type)
        if kid_friendly is not None:
            q = q.where(KnowledgeEntity.kid_friendly == kid_friendly)
        if min_popularity is not None:
            q = q.where(KnowledgeEntity.popularity_score >= min_popularity)
        result = await self.db.execute(q)
        return list(result.scalars().all())

    async def get_entity_by_slug(self, slug: str) -> KnowledgeEntity | None:
        result = await self.db.execute(
            select(KnowledgeEntity).where(KnowledgeEntity.slug == slug)
        )
        return result.scalar_one_or_none()

    async def create_entity(self, data: dict) -> KnowledgeEntity:
        entity = KnowledgeEntity(**data)
        self.db.add(entity)
        await self.db.flush()
        return entity

    # ─── Knowledge attributes ──────────────────────────────────────────────

    async def get_attribute_by_slug(self, slug: str) -> KnowledgeAttribute | None:
        result = await self.db.execute(
            select(KnowledgeAttribute).where(KnowledgeAttribute.slug == slug)
        )
        return result.scalar_one_or_none()

    async def upsert_attribute(self, slug: str, name: str, data_type: str, unit: str | None) -> KnowledgeAttribute:
        attr = await self.get_attribute_by_slug(slug)
        if attr is None:
            attr = KnowledgeAttribute(slug=slug, name=name, data_type=data_type, unit=unit)
            self.db.add(attr)
            await self.db.flush()
        return attr

    async def set_entity_attribute(
        self,
        entity_id: uuid.UUID,
        attribute_id: uuid.UUID,
        value_number: float | None = None,
        value_text: str | None = None,
        source_url: str | None = None,
        verified: bool = False,
    ) -> KnowledgeEntityAttribute:
        result = await self.db.execute(
            select(KnowledgeEntityAttribute).where(
                KnowledgeEntityAttribute.entity_id == entity_id,
                KnowledgeEntityAttribute.attribute_id == attribute_id,
            )
        )
        row = result.scalar_one_or_none()
        if row is None:
            row = KnowledgeEntityAttribute(
                entity_id=entity_id,
                attribute_id=attribute_id,
            )
            self.db.add(row)
        row.value_number = value_number
        row.value_text = value_text
        row.source_url = source_url
        row.verified = verified
        await self.db.flush()
        return row

    # ─── Procedural generators ─────────────────────────────────────────────

    async def get_enabled_generators(self) -> list[ProceduralGenerator]:
        result = await self.db.execute(
            select(ProceduralGenerator).where(ProceduralGenerator.enabled == True)
        )
        return list(result.scalars().all())

    async def get_generator_by_slug(self, slug: str) -> ProceduralGenerator | None:
        result = await self.db.execute(
            select(ProceduralGenerator).where(ProceduralGenerator.slug == slug)
        )
        return result.scalar_one_or_none()

    async def upsert_generator(self, slug: str, generator_type: str, config: dict, metadata: dict | None = None) -> ProceduralGenerator:
        gen = await self.get_generator_by_slug(slug)
        if gen is None:
            gen = ProceduralGenerator(slug=slug, generator_type=generator_type, config=config)
            self.db.add(gen)
        else:
            gen.config = config
            gen.generator_type = generator_type
        if metadata:
            gen.metadata_ = metadata
        await self.db.flush()
        return gen

    # ─── Generated match questions ─────────────────────────────────────────

    async def persist_generated_question(
        self,
        match_id: uuid.UUID,
        question_type: str,
        generated_payload: dict,
        generator_id: uuid.UUID | None = None,
        difficulty_score: float | None = None,
    ) -> GeneratedMatchQuestion:
        q = GeneratedMatchQuestion(
            match_id=match_id,
            generator_id=generator_id,
            question_type=question_type,
            generated_payload=generated_payload,
            difficulty_score=difficulty_score,
        )
        self.db.add(q)
        await self.db.flush()
        return q

    async def get_match_questions(self, match_id: uuid.UUID) -> list[GeneratedMatchQuestion]:
        result = await self.db.execute(
            select(GeneratedMatchQuestion).where(
                GeneratedMatchQuestion.match_id == match_id
            )
        )
        return list(result.scalars().all())
