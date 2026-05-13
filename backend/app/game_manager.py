import asyncio
import json
import os
import random
import time

MAX_PLAYERS = 10
START_DELAY = 30
QUESTIONS_PER_GAME = 10


class GameRoom:
    """Una sala de juego independiente para un modo específico."""

    def __init__(self, mode: str, ws_manager):
        self.mode = mode
        self.ws = ws_manager
        self.player_ids: set[str] = set()
        self.players: dict[str, dict] = {}
        self.state = "WAITING"
        self.current_question = None
        self.question_start_time: float | None = None
        self.answers: dict[str, dict] = {}
        self.start_task: asyncio.Task | None = None
        self.start_time: float | None = None

    async def _broadcast(self, message: dict):
        await self.ws.broadcast_to(self.player_ids, message)

    def _get_questions(self, all_questions: list[dict]) -> list[dict]:
        """Filtra preguntas por el modo de la sala."""
        if self.mode == "general":
            filtered = [q for q in all_questions if "general" in q.get("tags", [])]
            return filtered if filtered else all_questions
        filtered = [q for q in all_questions if self.mode in q.get("tags", [])]
        return filtered if filtered else all_questions

    async def add_player(self, player_id: str, nickname: str, all_questions: list[dict]):
        if self.state not in ("WAITING", "STARTING"):
            return
        if len(self.players) >= MAX_PLAYERS:
            return

        self.player_ids.add(player_id)
        self.players[player_id] = {
            "nickname": nickname,
            "score": 0,
            "correct_count": 0,
            "answered_count": 0,
            "total_time_ms": 0,
        }

        starts_in = None
        if self.state == "STARTING" and self.start_time is not None:
            starts_in = max(0, int(self.start_time + START_DELAY - time.time()))

        await self._broadcast({
            "type": "PLAYER_JOINED",
            "count": len(self.players),
            "nickname": nickname,
            "starts_in": starts_in,
            "mode": self.mode,
        })

        if len(self.players) == 2 and self.state == "WAITING":
            self.state = "STARTING"
            self.start_time = time.time()
            self.start_task = asyncio.create_task(
                self.wait_and_start(all_questions)
            )
            await self._broadcast({
                "type": "STARTING_SOON",
                "seconds": START_DELAY,
            })
        elif len(self.players) >= MAX_PLAYERS and self.state == "STARTING":
            if self.start_task and not self.start_task.done():
                self.start_task.cancel()
            self.start_task = None
            asyncio.create_task(self.start_game(all_questions))

    async def remove_player(self, player_id: str):
        if player_id not in self.players:
            return
        self.player_ids.discard(player_id)
        self.players.pop(player_id)

        if self.state == "STARTING" and len(self.players) < 2:
            if self.start_task and not self.start_task.done():
                self.start_task.cancel()
            self.start_task = None
            self.start_time = None
            self.state = "WAITING"
            await self._broadcast({
                "type": "START_CANCELLED",
                "count": len(self.players),
            })
        elif self.state in ("WAITING", "STARTING"):
            await self._broadcast({
                "type": "PLAYER_LEFT",
                "count": len(self.players),
            })

    async def submit_answer(self, player_id: str, answer: int):
        if (
            self.state == "QUESTION"
            and player_id in self.players
            and player_id not in self.answers
            and self.question_start_time is not None
        ):
            response_time = min(time.time() - self.question_start_time, 10.0)
            self.answers[player_id] = {
                "answer": answer,
                "response_time": response_time,
            }

    async def wait_and_start(self, all_questions: list[dict]):
        try:
            await asyncio.sleep(START_DELAY)
        except asyncio.CancelledError:
            return
        self.start_task = None
        await self.start_game(all_questions)

    async def start_game(self, all_questions: list[dict]):
        if self.state not in ("STARTING", "WAITING"):
            return
        self.state = "COUNTDOWN"
        for i in [3, 2, 1]:
            await self._broadcast({"type": "COUNTDOWN", "value": i})
            await asyncio.sleep(1)
        await self.game_loop(all_questions)

    async def game_loop(self, all_questions: list[dict]):
        self.state = "QUESTION"
        pool = self._get_questions(all_questions)
        selected = random.sample(pool, min(QUESTIONS_PER_GAME, len(pool)))
        total = len(selected)

        for i, question in enumerate(selected):
            self.current_question = question
            self.answers = {}
            self.question_start_time = time.time()

            await self._broadcast({
                "type": "NEW_QUESTION",
                "question": question["question"],
                "options": question["options"],
                "duration": 10,
                "question_number": i + 1,
                "total_questions": total,
            })
            await asyncio.sleep(10)

            correct_index = question["correct"]
            correct_text = question["options"][correct_index]
            correct_count = 0
            question_results = []

            for pid, answer_data in self.answers.items():
                if pid not in self.players:
                    continue
                is_correct = answer_data["answer"] == correct_index
                t = answer_data["response_time"]
                pts = int(100 + 50 * (1 - t / 10)) if is_correct else 0
                if is_correct:
                    correct_count += 1
                    self.players[pid]["score"] += pts
                    self.players[pid]["correct_count"] += 1
                self.players[pid]["answered_count"] += 1
                self.players[pid]["total_time_ms"] += int(t * 1000)
                question_results.append({
                    "nickname": self.players[pid]["nickname"],
                    "correct": is_correct,
                    "response_time_ms": int(t * 1000),
                    "points_earned": pts,
                })

            for pid, player_data in self.players.items():
                if pid not in self.answers:
                    question_results.append({
                        "nickname": player_data["nickname"],
                        "correct": None,
                        "response_time_ms": None,
                        "points_earned": 0,
                    })

            question_results.sort(key=lambda x: (
                0 if x["correct"] is True else (1 if x["correct"] is False else 2),
                x["response_time_ms"] if x["response_time_ms"] is not None else 99999,
            ))

            total_players = len(self.players)
            correct_pct = int(correct_count * 100 / total_players) if total_players else 0

            await self._broadcast({
                "type": "ANSWER_REVEAL",
                "correct": correct_text,
                "correct_index": correct_index,
                "correct_pct": correct_pct,
                "question_results": question_results,
            })

            scoreboard = self._build_scoreboard()
            await self._broadcast({"type": "SCOREBOARD", "players": scoreboard})
            await asyncio.sleep(5)

        self.state = "FINISHED"
        await self._broadcast({
            "type": "GAME_FINISHED",
            "players": self._build_scoreboard(),
        })

        # Reset para la próxima partida
        self.players = {}
        self.player_ids = set()
        self.state = "WAITING"
        self.current_question = None
        self.question_start_time = None
        self.answers = {}
        self.start_task = None
        self.start_time = None

    def _build_scoreboard(self) -> list[dict]:
        return sorted(
            [
                {
                    "nickname": p["nickname"],
                    "score": p["score"],
                    "correct_count": p["correct_count"],
                    "answered_count": p["answered_count"],
                    "avg_time_ms": (
                        p["total_time_ms"] // p["answered_count"]
                        if p["answered_count"] > 0 else None
                    ),
                }
                for p in self.players.values()
            ],
            key=lambda x: x["score"],
            reverse=True,
        )


# ─────────────────────────────────────────────────────────────────────────────

class GameManager:
    """Administra múltiples salas simultáneas (una por modo)."""

    def __init__(self, ws_manager):
        self.ws = ws_manager
        self.rooms: dict[str, GameRoom] = {}
        self.questions: list[dict] = []
        self._load_from_json()

    def _load_from_json(self) -> None:
        try:
            with open("app/questions.json", "r", encoding="utf-8") as f:
                self.questions = json.load(f)
        except FileNotFoundError:
            pass

    def get_room(self, mode: str) -> GameRoom:
        if mode not in self.rooms:
            self.rooms[mode] = GameRoom(mode, self.ws)
        return self.rooms[mode]

    async def load_questions(self) -> None:
        if not os.getenv("DATABASE_URL"):
            self._load_from_json()
            return
        try:
            from sqlalchemy import select, text
            from sqlalchemy.orm import selectinload
            from app.db.session import AsyncSessionLocal
            from app.models.questions import Question

            async with AsyncSessionLocal() as db:
                result = await db.execute(
                    select(Question)
                    .where(
                        Question.status == "approved",
                        Question.enabled == True,
                        Question.archived == False,
                        Question.answer_mode == "multiple_choice",
                    )
                    .options(
                        selectinload(Question.translations),
                        selectinload(Question.answer_options),
                        selectinload(Question.question_tags),
                    )
                )
                db_questions = result.scalars().all()

                # Tags por pregunta
                tag_result = await db.execute(text("""
                    SELECT qt.question_id::text, t.slug
                    FROM question_tags qt
                    JOIN tags t ON t.id = qt.tag_id
                """))
                tags_by_q: dict[str, list[str]] = {}
                for row in tag_result:
                    tags_by_q.setdefault(row[0], []).append(row[1])

            question_list = []
            for q in db_questions:
                title = q.slug
                for t in q.translations:
                    if t.language == "es":
                        title = t.title
                        break
                options = sorted(
                    [o for o in q.answer_options if o.enabled],
                    key=lambda o: o.display_order,
                )
                if not options:
                    continue
                correct_index = next(
                    (i for i, o in enumerate(options) if o.is_correct), 0
                )
                question_list.append({
                    "question": title,
                    "options": [o.text for o in options],
                    "correct": correct_index,
                    "tags": tags_by_q.get(str(q.id), []),
                })

            if question_list:
                self.questions = question_list
                print(f"[DB] {len(question_list)} preguntas cargadas")
        except Exception as e:
            print(f"[DB] Error: {e}, usando JSON fallback")
            if not self.questions:
                self._load_from_json()

    async def add_player(self, player_id: str, nickname: str, mode: str):
        room = self.get_room(mode)
        await room.add_player(player_id, nickname, self.questions)

    async def remove_player(self, player_id: str, mode: str):
        room = self.rooms.get(mode)
        if room:
            await room.remove_player(player_id)

    async def submit_answer(self, player_id: str, answer: int, mode: str):
        room = self.rooms.get(mode)
        if room:
            await room.submit_answer(player_id, answer)
