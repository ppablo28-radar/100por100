"""
Generator: closest_number (multiple choice)

Picks 1 target entity and N-1 distractors (same type, real values).
The player picks which value belongs to the target entity.

Payload:
{
  "question_type": "closest_number",
  "question_text": "¿Cuántos millones de habitantes tiene Argentina?",
  "entity_name": "Argentina",
  "attribute_name": "Población",
  "unit": "millones de personas",
  "correct_id": "uuid-argentina",
  "options": [
    {"id": "uuid-argentina", "label": "46"},
    {"id": "uuid-brasil",    "label": "215"},
    {"id": "uuid-mexico",    "label": "128"},
    {"id": "uuid-uruguay",   "label": "3"}
  ],
  "real_value": 46
}
"""
import random
from app.generator_engine.base import BaseGenerator


def _fmt(v: float) -> str:
    if v == int(v):
        return f"{int(v):,}".replace(",", ".")
    return f"{v:.1f}"


class ClosestNumberGenerator(BaseGenerator):
    generator_type = "closest_number"

    def generate(self, pool: dict) -> dict | None:
        entities: list[dict] = pool.get("entities_with_attribute", [])
        rng = random.SystemRandom()

        n = rng.randint(
            self.config.get("min_options", 4),
            self.config.get("max_options", 4),
        )
        candidates = self._pick(entities, n, rng)
        if not candidates:
            return None

        target = candidates[0]
        attr_name = self.config.get("attribute_name", "valor")
        unit = self.config.get("unit", "")

        base = self.config.get(
            "question_text",
            f"¿Cuánto {attr_name.lower()} tiene",
        )
        # Siempre inyectar el nombre de la entidad al final
        question_text = f"{base.rstrip('?').rstrip()} {target['name']}?"

        shuffled = candidates[:]
        rng.shuffle(shuffled)

        return {
            "question_type": "closest_number",
            "question_text": question_text,
            "entity_name": target["name"],
            "attribute_name": attr_name,
            "unit": unit,
            "correct_id": target["id"],
            "options": [{"id": e["id"], "label": _fmt(e["value"])} for e in shuffled],
            "real_value": target["value"],
        }
