"""
RuntimeEngine — orquestador del motor procedural.

Carga todos los datos desde la DB UNA SOLA VEZ al arrancar y los mantiene
en memoria. Durante un match, genera preguntas sin tocar la DB.

Uso:
    engine = RuntimeEngine()
    await engine.load(db_session)

    # Generar una pregunta procedural:
    payload = engine.generate_question("timeline_order")
    # payload es None si no hay suficientes datos para ese tipo
"""
import logging
import random
from typing import Any

from app.generator_engine.timeline_order import TimelineOrderGenerator
from app.generator_engine.higher_lower import HigherLowerGenerator
from app.generator_engine.closest_number import ClosestNumberGenerator
from app.generator_engine.odd_one_out import OddOneOutGenerator
from app.generator_engine.ranking_order import RankingOrderGenerator

logger = logging.getLogger(__name__)

GENERATOR_CLASSES = {
    "timeline_order": TimelineOrderGenerator,
    "higher_lower": HigherLowerGenerator,
    "closest_number": ClosestNumberGenerator,
    "odd_one_out": OddOneOutGenerator,
    "ranking_order": RankingOrderGenerator,
}


class RuntimeEngine:
    """
    Motor procedural en memoria.

    Arquitectura:
      - _pools: datos pre-cargados (eventos, entidades+atributos, grupos odd-one-out)
      - _generators: instancias de generators configuradas desde procedural_generators
      - generate_question(): genera sin DB, O(1) por pregunta
    """

    def __init__(self):
        self._pools: dict[str, Any] = {}
        self._generators: list[dict] = []   # [{type, generator_instance, config}]
        self.loaded = False

    # ─── Carga inicial ─────────────────────────────────────────────────────

    async def load(self, db) -> None:
        """
        db: AsyncSession de SQLAlchemy.
        Carga timeline_events, knowledge_entities con sus atributos, y
        procedural_generators habilitados.
        """
        from sqlalchemy import select, text
        from app.models.procedural import (
            TimelineEvent, KnowledgeEntity, KnowledgeAttribute,
            KnowledgeEntityAttribute, ProceduralGenerator,
        )

        # — Timeline events —
        result = await db.execute(select(TimelineEvent))
        raw_events = result.scalars().all()
        self._pools["timeline_events"] = [
            {
                "id": str(e.id),
                "title": e.title,
                "short_title": e.short_title,
                "description": e.description,
                "event_date": e.event_date,
                "region": e.region,
                "kid_friendly": e.kid_friendly,
            }
            for e in raw_events
        ]

        # — Knowledge entities + attributes —
        result = await db.execute(select(KnowledgeEntity))
        entities = result.scalars().all()

        result = await db.execute(select(KnowledgeAttribute))
        attributes = {str(a.id): a for a in result.scalars().all()}

        result = await db.execute(select(KnowledgeEntityAttribute))
        entity_attr_rows = result.scalars().all()

        # Build entity dict keyed by id
        entity_map: dict[str, dict] = {
            str(e.id): {
                "id": str(e.id),
                "entity_type": e.entity_type,
                "name": e.name,
                "slug": e.slug,
                "description": e.description,
                "region": e.region,
                "kid_friendly": e.kid_friendly,
                "popularity_score": e.popularity_score,
                "mainstream_score": e.mainstream_score,
                "image_url": e.metadata_.get("image_url"),
                "attrs": {},      # attr_slug → value
            }
            for e in entities
        }

        for row in entity_attr_rows:
            eid = str(row.entity_id)
            aid = str(row.attribute_id)
            if eid not in entity_map or aid not in attributes:
                continue
            attr = attributes[aid]
            value = row.value_number if row.value_number is not None else row.value_text
            entity_map[eid]["attrs"][attr.slug] = {
                "value": value,
                "name": attr.name,
                "unit": attr.unit,
                "data_type": attr.data_type,
            }

        self._pools["entities"] = list(entity_map.values())

        # — Procedural generators —
        result = await db.execute(
            select(ProceduralGenerator).where(ProceduralGenerator.enabled == True)
        )
        generators = result.scalars().all()
        self._generators = [
            {
                "id": str(g.id),
                "slug": g.slug,
                "type": g.generator_type,
                "config": g.config,
                "instance": GENERATOR_CLASSES[g.generator_type](g.config)
                if g.generator_type in GENERATOR_CLASSES else None,
            }
            for g in generators
        ]

        self.loaded = True
        logger.info(
            "RuntimeEngine loaded: %d events, %d entities, %d generators",
            len(self._pools["timeline_events"]),
            len(self._pools["entities"]),
            len(self._generators),
        )

    # ─── Generación ────────────────────────────────────────────────────────

    def generate_question(
        self,
        generator_type: str | None = None,
        generator_slug: str | None = None,
    ) -> dict | None:
        """
        Genera una pregunta usando un generator aleatorio del tipo dado
        (o un slug específico).

        Devuelve None si no hay datos suficientes o el tipo no está disponible.
        """
        if not self.loaded:
            logger.warning("RuntimeEngine.generate_question called before load()")
            return None

        candidates = [
            g for g in self._generators
            if g["instance"] is not None
            and (generator_type is None or g["type"] == generator_type)
            and (generator_slug is None or g["slug"] == generator_slug)
        ]
        if not candidates:
            return None

        gen_config = random.choice(candidates)
        pool = self._build_pool(gen_config)
        result = gen_config["instance"].generate(pool)
        if result:
            result["generator_id"] = gen_config["id"]
        return result

    def generate_random(self) -> dict | None:
        """Genera una pregunta de cualquier tipo habilitado."""
        return self.generate_question(generator_type=None)

    # ─── Pool builder ──────────────────────────────────────────────────────

    def _build_pool(self, gen_config: dict) -> dict:
        """
        Prepara el pool de datos para un generator específico
        filtrando por los parámetros del config.
        """
        cfg = gen_config["config"]
        gtype = gen_config["type"]

        if gtype == "timeline_order":
            events = self._pools["timeline_events"]
            if region := cfg.get("region"):
                events = [e for e in events if e.get("region") == region]
            if cfg.get("kid_safe_only"):
                events = [e for e in events if e.get("kid_friendly")]
            return {"timeline_events": events}

        if gtype in ("higher_lower", "closest_number", "ranking_order"):
            attr_slug = cfg.get("attribute_slug", "")
            entity_types = cfg.get("allowed_entity_types", [])

            entities = self._pools["entities"]
            if entity_types:
                entities = [e for e in entities if e["entity_type"] in entity_types]
            if cfg.get("kid_safe_only"):
                entities = [e for e in entities if e.get("kid_friendly")]

            # Flatten to entities that have the required attribute
            flat = []
            for e in entities:
                if attr_slug and attr_slug not in e["attrs"]:
                    continue
                attr_data = e["attrs"].get(attr_slug, {})
                value = attr_data.get("value") if attr_slug else e.get("popularity_score")
                if value is None:
                    continue
                flat.append({
                    **e,
                    "value": value,
                    "attribute_name": attr_data.get("name", attr_slug),
                    "unit": attr_data.get("unit", ""),
                })
            return {"entities_with_attribute": flat}

        if gtype == "odd_one_out":
            # Expects pool to have pre-configured group_members + intruder
            # These are defined by config["group_entity_type"] vs config["intruder_entity_type"]
            group_type = cfg.get("group_entity_type", "")
            intruder_type = cfg.get("intruder_entity_type", "")

            all_entities = self._pools["entities"]
            group = [e for e in all_entities if e["entity_type"] == group_type]
            intruders = [e for e in all_entities if e["entity_type"] == intruder_type]

            intruder = random.choice(intruders) if intruders else None
            if intruder and cfg.get("intruder_reason"):
                intruder = {**intruder, "odd_reason": cfg["intruder_reason"]}

            return {"group_members": group, "intruder": intruder}

        return {}

    # ─── Estado ────────────────────────────────────────────────────────────

    def stats(self) -> dict:
        return {
            "loaded": self.loaded,
            "timeline_events": len(self._pools.get("timeline_events", [])),
            "entities": len(self._pools.get("entities", [])),
            "generators": [
                {"slug": g["slug"], "type": g["type"]}
                for g in self._generators
                if g["instance"] is not None
            ],
        }
