"""
Generator: odd_one_out

Shows 4 items. 3 belong to a category, 1 is the intruder.
Payload:
{
  "question_type": "odd_one_out",
  "question_text": "¿Cuál NO es un videojuego de Minecraft?",
  "category_label": "Videojuegos de Minecraft",
  "options": [
    {"id": "...", "name": "Steve", "image_url": null},
    {"id": "...", "name": "Creeper", "image_url": null},
    {"id": "...", "name": "Naruto", "image_url": null},
    {"id": "...", "name": "Enderman", "image_url": null}
  ],
  "correct_id": "uuid-of-intruder",
  "explanation": "Naruto es de anime, no de Minecraft"
}
"""
import random
from app.generator_engine.base import BaseGenerator


class OddOneOutGenerator(BaseGenerator):
    generator_type = "odd_one_out"

    def generate(self, pool: dict) -> dict | None:
        # pool must provide:
        #   "group_members": list of 3 entities that belong together
        #   "intruder": a single entity that doesn't belong
        members: list[dict] = pool.get("group_members", [])
        intruder: dict | None = pool.get("intruder")
        rng = random.SystemRandom()

        if len(members) < 3 or intruder is None:
            return None

        chosen = self._pick(members, 3, rng)
        category_label = self.config.get("category_label", "el grupo")
        question_text = self.config.get(
            "question_text", f"¿Cuál NO pertenece a {category_label}?"
        )

        options = chosen + [intruder]
        rng.shuffle(options)

        return {
            "question_type": "odd_one_out",
            "question_text": question_text,
            "category_label": category_label,
            "options": [
                {
                    "id": e["id"],
                    "name": e["name"],
                    "image_url": e.get("image_url"),
                }
                for e in options
            ],
            "correct_id": intruder["id"],
            "explanation": intruder.get("odd_reason", ""),
        }
