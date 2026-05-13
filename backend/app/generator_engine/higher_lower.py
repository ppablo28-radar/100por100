"""
Generator: higher_lower

Picks 2 entities and asks which one has more/less of a numeric attribute.
Payload:
{
  "question_type": "higher_lower",
  "question_text": "¿Cuál tiene más suscriptores?",
  "attribute_name": "Suscriptores",
  "unit": "millones",
  "direction": "higher",          # "higher" | "lower"
  "options": [
    {"id": "...", "name": "MrBeast", "image_url": "..."},
    {"id": "...", "name": "PewDiePie", "image_url": "..."}
  ],
  "correct_id": "uuid-of-winner",
  "values": {"uuid1": 400, "uuid2": 110}   # revealed after answer
}
"""
import random
from app.generator_engine.base import BaseGenerator


class HigherLowerGenerator(BaseGenerator):
    generator_type = "higher_lower"

    def generate(self, pool: dict) -> dict | None:
        entities: list[dict] = pool.get("entities_with_attribute", [])
        rng = random.SystemRandom()

        n = rng.randint(
            self.config.get("min_options", 2),
            self.config.get("max_options", 2),
        )
        candidates = self._pick(entities, n, rng)
        if not candidates:
            return None

        direction = self.config.get("direction", "higher")
        attr_name = self.config.get("attribute_name", "valor")
        unit = self.config.get("unit", "")

        if direction == "higher":
            correct = max(candidates, key=lambda e: e["value"])
            verb = "más"
        else:
            correct = min(candidates, key=lambda e: e["value"])
            verb = "menos"

        question_text = self.config.get(
            "question_text",
            f"¿Cuál tiene {verb} {attr_name.lower()}?"
        )

        options = candidates[:]
        rng.shuffle(options)

        return {
            "question_type": "higher_lower",
            "question_text": question_text,
            "attribute_name": attr_name,
            "unit": unit,
            "direction": direction,
            "options": [
                {
                    "id": e["id"],
                    "name": e["name"],
                    "image_url": e.get("image_url"),
                }
                for e in options
            ],
            "correct_id": correct["id"],
            "values": {e["id"]: e["value"] for e in candidates},
        }
