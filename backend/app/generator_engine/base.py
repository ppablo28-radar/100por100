"""Base class for all procedural generators."""
from abc import ABC, abstractmethod
from typing import Any


class BaseGenerator(ABC):
    """
    Each generator takes a pool of pre-loaded data and produces
    a self-contained question payload dict ready to send to the client.

    The payload must always include:
      - question_type: str
      - question_text: str
      - Any answer / ordering data specific to the generator type
    """

    generator_type: str = ""

    def __init__(self, config: dict):
        self.config = config

    @abstractmethod
    def generate(self, pool: dict[str, Any]) -> dict | None:
        """
        pool  →  pre-loaded data (entities, events, attribute values, etc.)
        Returns a payload dict or None if the pool has insufficient data.
        """
        ...

    def _pick(self, items: list, n: int, rng) -> list:
        """Random sample without replacement, returns [] if not enough items."""
        if len(items) < n:
            return []
        return rng.sample(items, n)
