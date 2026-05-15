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

    async def load_from_asyncpg(self, db_url: str) -> None:
        """
        Carga todos los datos usando asyncpg directo (sin SQLAlchemy).
        db_url debe ser formato postgresql:// (no postgresql+asyncpg://).
        """
        import asyncpg

        conn = await asyncpg.connect(db_url, timeout=10)
        try:
            # — Timeline events —
            rows = await conn.fetch(
                "SELECT id, title, short_title, description, event_date, region, kid_friendly "
                "FROM timeline_events"
            )
            self._pools["timeline_events"] = [
                {
                    "id": str(r["id"]),
                    "title": r["title"],
                    "short_title": r["short_title"],
                    "description": r["description"],
                    "event_date": r["event_date"],
                    "region": r["region"],
                    "kid_friendly": r["kid_friendly"],
                }
                for r in rows
            ]

            # — Knowledge attributes (slug → metadata) —
            attr_rows = await conn.fetch(
                "SELECT id, slug, name, data_type, unit FROM knowledge_attributes"
            )
            attributes = {str(r["id"]): dict(r) for r in attr_rows}

            # — Knowledge entities —
            entity_rows = await conn.fetch(
                "SELECT id, entity_type, name, slug, description, region, "
                "kid_friendly, popularity_score, mainstream_score, metadata "
                "FROM knowledge_entities"
            )
            import json
            entity_map: dict[str, dict] = {}
            for r in entity_rows:
                meta = r["metadata"] if isinstance(r["metadata"], dict) else json.loads(r["metadata"] or "{}")
                entity_map[str(r["id"])] = {
                    "id": str(r["id"]),
                    "entity_type": r["entity_type"],
                    "name": r["name"],
                    "slug": r["slug"],
                    "description": r["description"],
                    "region": r["region"],
                    "kid_friendly": r["kid_friendly"],
                    "popularity_score": r["popularity_score"],
                    "mainstream_score": r["mainstream_score"],
                    "image_url": meta.get("image_url"),
                    "attrs": {},
                }

            # — Entity attribute values —
            val_rows = await conn.fetch(
                "SELECT entity_id, attribute_id, value_number, value_text "
                "FROM knowledge_entity_attributes"
            )
            for r in val_rows:
                eid = str(r["entity_id"])
                aid = str(r["attribute_id"])
                if eid not in entity_map or aid not in attributes:
                    continue
                attr = attributes[aid]
                value = r["value_number"] if r["value_number"] is not None else r["value_text"]
                entity_map[eid]["attrs"][attr["slug"]] = {
                    "value": value,
                    "name": attr["name"],
                    "unit": attr["unit"],
                    "data_type": attr["data_type"],
                }

            self._pools["entities"] = list(entity_map.values())

            # — Procedural generators —
            gen_rows = await conn.fetch(
                "SELECT id, slug, generator_type, config "
                "FROM procedural_generators WHERE enabled = true"
            )
            self._generators = []
            for r in gen_rows:
                cfg = r["config"] if isinstance(r["config"], dict) else json.loads(r["config"] or "{}")
                gtype = r["generator_type"]
                self._generators.append({
                    "id": str(r["id"]),
                    "slug": r["slug"],
                    "type": gtype,
                    "config": cfg,
                    "instance": GENERATOR_CLASSES[gtype](cfg) if gtype in GENERATOR_CLASSES else None,
                })

        finally:
            await conn.close()

        self.loaded = True
        logger.info(
            "RuntimeEngine loaded: %d events, %d entities, %d generators",
            len(self._pools["timeline_events"]),
            len(self._pools["entities"]),
            len(self._generators),
        )

    async def load(self, db) -> None:
        """Compatibilidad: acepta AsyncSession de SQLAlchemy (delega a load_from_asyncpg)."""
        raise NotImplementedError("Usar load_from_asyncpg(db_url) directamente.")

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
            result["generator_slug"] = gen_config["slug"]
            result["generator_type"] = gen_config["type"]
            result["entity_types"] = gen_config["config"].get("allowed_entity_types", [])
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
