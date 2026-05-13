"""
Generator: ranking_order

Player must sort N entities by a numeric attribute (ascending or descending).
Payload:
{
  "question_type": "ranking_order",
  "question_text": "Ordená estos países de menor a mayor población",
  "attribute_name": "Población",
  "unit": "millones de personas",
  "direction": "asc",            # "asc" | "desc"
  "options": [
    {"id": "...", "name": "Argentina"},
    {"id": "...", "name": "Brasil"},
    {"id": "...", "name": "Uruguay"},
    {"id": "...", "name": "Paraguay"}
  ],
  "correct_order": ["id-uruguay", "id-paraguay", "id-argentina", "id-brasil"],
  "values": {"id-brasil": 215, "id-argentina": 46, ...}
}
"""
import random
from app.generator_engine.base import BaseGenerator


class RankingOrderGenerator(BaseGenerator):
    generator_type = "ranking_order"

    def generate(self, pool: dict) -> dict | None:
        entities: list[dict] = pool.get("entities_with_attribute", [])
        rng = random.SystemRandom()
        n_min = self.config.get("min_items", self.config.get("n_items", 4))
        n_max = self.config.get("max_items", self.config.get("n_items", 4))
        n = rng.randint(n_min, n_max)

        candidates = self._pick(entities, n, rng)
        if not candidates:
            return None

        direction = self.config.get("direction", "asc")
        attr_name = self.config.get("attribute_name", "valor")
        unit = self.config.get("unit", "")

        sorted_entities = sorted(
            candidates,
            key=lambda e: e["value"],
            reverse=(direction == "desc"),
        )

        direction_label = "mayor a menor" if direction == "desc" else "menor a mayor"
        question_text = self.config.get(
            "question_text",
            f"Ordená de {direction_label} según {attr_name.lower()}"
        )

        options = candidates[:]
        rng.shuffle(options)

        return {
            "question_type": "ranking_order",
            "question_text": question_text,
            "attribute_name": attr_name,
            "unit": unit,
            "direction": direction,
            "options": [{"id": e["id"], "name": e["name"]} for e in options],
            "correct_order": [e["id"] for e in sorted_entities],
            "values": {e["id"]: e["value"] for e in candidates},
        }
