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

        candidates = self._pick(entities, 2, rng)
        if not candidates:
            return None

        a, b = candidates
        direction = self.config.get("direction", "higher")
        attr_name = self.config.get("attribute_name", "valor")
        unit = self.config.get("unit", "")

        if direction == "higher":
            correct = a if a["value"] >= b["value"] else b
            verb = "más"
        else:
            correct = a if a["value"] <= b["value"] else b
            verb = "menos"

        question_text = self.config.get(
            "question_text",
            f"¿Cuál tiene {verb} {attr_name.lower()}?"
        )

        options = [a, b]
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
