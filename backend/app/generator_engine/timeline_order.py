"""
Generator: timeline_order

Picks N timeline events and asks the player to put them in chronological order.
Payload sent to client:
{
  "question_type": "timeline_order",
  "question_text": "Ordená estos eventos de más antiguo a más reciente",
  "events": [
    {"id": "...", "title": "...", "hint": "..."},
    ...
  ],
  "correct_order": ["id1", "id2", "id3", "id4"]   # oldest → newest
}
"""
import random
from app.generator_engine.base import BaseGenerator


class TimelineOrderGenerator(BaseGenerator):
    generator_type = "timeline_order"

    def generate(self, pool: dict) -> dict | None:
        events: list[dict] = pool.get("timeline_events", [])
        n = self.config.get("n_events", 4)
        rng = random.SystemRandom()

        candidates = self._pick(events, n, rng)
        if not candidates:
            return None

        sorted_events = sorted(candidates, key=lambda e: e["event_date"])
        shuffled = sorted_events[:]
        rng.shuffle(shuffled)

        return {
            "question_type": "timeline_order",
            "question_text": self.config.get(
                "question_text", "Ordená estos eventos de más antiguo a más reciente"
            ),
            "events": [
                {
                    "id": e["id"],
                    "title": e["short_title"] or e["title"],
                    "hint": e.get("description", ""),
                }
                for e in shuffled
            ],
            "correct_order": [e["id"] for e in sorted_events],
        }
