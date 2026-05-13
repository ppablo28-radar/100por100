"""
GeneratorService — interfaz de alto nivel para el motor procedural.

Orquesta el RuntimeEngine (en memoria) con persistencia asíncrona en DB.
Se usa desde main.py o game_manager.py cuando se necesita una pregunta procedural.

Ejemplo de uso:
    service = GeneratorService(engine=runtime_engine, db=session)
    question = await service.get_question_for_match(
        match_id=some_uuid,
        generator_type="timeline_order",
    )
    # question es un dict payload listo para enviar al cliente
"""
import logging
import uuid
from typing import Optional

from sqlalchemy.ext.asyncio import AsyncSession

from app.generator_engine.engine import RuntimeEngine
from app.repositories.procedural_repository import ProceduralRepository

logger = logging.getLogger(__name__)


class GeneratorService:

    def __init__(self, engine: RuntimeEngine, db: AsyncSession):
        self.engine = engine
        self.repo = ProceduralRepository(db)
        self.db = db

    async def get_question_for_match(
        self,
        match_id: uuid.UUID,
        generator_type: str | None = None,
        generator_slug: str | None = None,
        persist: bool = True,
    ) -> dict | None:
        """
        Genera una pregunta procedural y la persiste como snapshot.

        Si engine no está cargado o no hay datos suficientes, devuelve None.
        El caller debe entonces caer back a una pregunta handcrafted.
        """
        if not self.engine.loaded:
            logger.warning("GeneratorService: engine not loaded, skipping procedural question")
            return None

        payload = self.engine.generate_question(
            generator_type=generator_type,
            generator_slug=generator_slug,
        )
        if payload is None:
            return None

        if persist:
            try:
                gen_id_str = payload.get("generator_id")
                gen_id = uuid.UUID(gen_id_str) if gen_id_str else None
                await self.repo.persist_generated_question(
                    match_id=match_id,
                    question_type=payload["question_type"],
                    generated_payload=payload,
                    generator_id=gen_id,
                )
                await self.db.commit()
            except Exception as e:
                logger.error("Failed to persist generated question: %s", e)
                await self.db.rollback()

        return payload

    async def get_random_question(self, match_id: uuid.UUID, persist: bool = True) -> dict | None:
        """Genera una pregunta de cualquier tipo habilitado."""
        return await self.get_question_for_match(
            match_id=match_id,
            generator_type=None,
            persist=persist,
        )

    def engine_stats(self) -> dict:
        return self.engine.stats()
