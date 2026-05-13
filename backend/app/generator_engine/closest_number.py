"""
Generator: closest_number

4 players guess a real numeric value (e.g. world population, year, subscriber count).
The player who guesses closest wins. No pre-determined correct answer to reveal —
the system scores based on proximity to the real value.

Payload:
{
  "question_type": "closest_number",
  "question_text": "¿Cuántos suscriptores tiene MrBeast? (en millones)",
  "entity_name": "MrBeast",
  "attribute_name": "Suscriptores",
  "unit": "millones",
  "hint": "Es el canal más grande de YouTube",
  "real_value": 400,              # revealed after all answers
  "input_type": "number",
  "min_value": 0,
  "max_value": 1000
}
"""
import random
from app.generator_engine.base import BaseGenerator


class ClosestNumberGenerator(BaseGenerator):
    generator_type = "closest_number"

    def generate(self, pool: dict) -> dict | None:
        entities: list[dict] = pool.get("entities_with_attribute", [])
        rng = random.SystemRandom()

        candidates = self._pick(entities, 1, rng)
        if not candidates:
            return None

        entity = candidates[0]
        attr_name = self.config.get("attribute_name", "valor")
        unit = self.config.get("unit", "")
        real_value = entity["value"]

        question_text = self.config.get(
            "question_text",
            f"¿Cuánto {attr_name.lower()} tiene {entity['name']}?"
        )
        if unit:
            question_text += f" (en {unit})"

        # Suggest a sane input range based on the real value magnitude
        magnitude = max(1, int(real_value))
        max_value = magnitude * 3

        return {
            "question_type": "closest_number",
            "question_text": question_text,
            "entity_name": entity["name"],
            "attribute_name": attr_name,
            "unit": unit,
            "hint": entity.get("description", ""),
            "real_value": real_value,
            "input_type": "number",
            "min_value": 0,
            "max_value": max_value,
        }
