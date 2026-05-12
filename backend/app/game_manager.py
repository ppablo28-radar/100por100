import asyncio
import json
import os
import random
import time

MAX_PLAYERS = 10
START_DELAY = 30
QUESTIONS_PER_GAME = 10


class GameManager:
    def __init__(self, websocket_manager):
        self.websocket_manager = websocket_manager
        self.players = {}
        self.state = "WAITING"
        self.current_question = None
        self.question_start_time = None
        self.answers = {}
        self.start_task = None
        self.start_time = None
        self.questions: list[dict] = []
        self._load_from_json()  # fallback síncrono inicial

    def _load_from_json(self) -> None:
        try:
            with open("app/questions.json", "r", encoding="utf-8") as f:
                self.questions = json.load(f)
        except FileNotFoundError:
            pass

    async def load_questions(self) -> None:
        """Carga preguntas desde Supabase si DATABASE_URL está configurado."""
        if not os.getenv("DATABASE_URL"):
            self._load_from_json()
            return
        try:
            from sqlalchemy import select
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
                    )
                )
                db_questions = result.scalars().all()

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
                })

            if question_list:
                self.questions = question_list
                print(f"[DB] {len(question_list)} preguntas cargadas desde Supabase")
        except Exception as e:
            print(f"[DB] Error cargando preguntas, usando JSON: {e}")
            if not self.questions:
                self._load_from_json()

    async def add_player(self, player_id, nickname):
        if self.state not in ("WAITING", "STARTING"):
            return
        if len(self.players) >= MAX_PLAYERS:
            return

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

        await self.websocket_manager.broadcast({
            "type": "PLAYER_JOINED",
            "count": len(self.players),
            "nickname": nickname,
            "starts_in": starts_in,
        })

        if len(self.players) == 2 and self.state == "WAITING":
            self.state = "STARTING"
            self.start_time = time.time()
            self.start_task = asyncio.create_task(self.wait_and_start())
            await self.websocket_manager.broadcast({
                "type": "STARTING_SOON",
                "seconds": START_DELAY,
            })

        elif len(self.players) >= MAX_PLAYERS and self.state == "STARTING":
            if self.start_task and not self.start_task.done():
                self.start_task.cancel()
            self.start_task = None
            asyncio.create_task(self.start_game())

    async def wait_and_start(self):
        try:
            await asyncio.sleep(START_DELAY)
        except asyncio.CancelledError:
            return
        self.start_task = None
        await self.start_game()

    async def remove_player(self, player_id):
        if player_id not in self.players:
            return
        self.players.pop(player_id)

        if self.state == "STARTING" and len(self.players) < 2:
            if self.start_task and not self.start_task.done():
                self.start_task.cancel()
            self.start_task = None
            self.start_time = None
            self.state = "WAITING"
            await self.websocket_manager.broadcast({
                "type": "START_CANCELLED",
                "count": len(self.players),
            })
        elif self.state in ("WAITING", "STARTING"):
            await self.websocket_manager.broadcast({
                "type": "PLAYER_LEFT",
                "count": len(self.players),
            })

    async def submit_answer(self, player_id, answer):
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

    async def start_game(self):
        if self.state not in ("STARTING", "WAITING"):
            return
        self.state = "COUNTDOWN"

        for i in [3, 2, 1]:
            await self.websocket_manager.broadcast({
                "type": "COUNTDOWN",
                "value": i,
            })
            await asyncio.sleep(1)

        await self.game_loop()

    async def game_loop(self):
        self.state = "QUESTION"
        await self.load_questions()  # refresca para incluir preguntas nuevas

        selected_questions = random.sample(
            self.questions,
            min(QUESTIONS_PER_GAME, len(self.questions)),
        )
        total = len(selected_questions)

        for i, question in enumerate(selected_questions):
            self.current_question = question
            self.answers = {}
            self.question_start_time = time.time()

            await self.websocket_manager.broadcast({
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

            # Jugadores que no respondieron
            answered_ids = set(self.answers.keys())
            for pid, player_data in self.players.items():
                if pid not in answered_ids:
                    question_results.append({
                        "nickname": player_data["nickname"],
                        "correct": None,
                        "response_time_ms": None,
                        "points_earned": 0,
                    })

            # Orden: correctos por velocidad, luego incorrectos, luego sin respuesta
            question_results.sort(key=lambda x: (
                0 if x["correct"] is True else (1 if x["correct"] is False else 2),
                x["response_time_ms"] if x["response_time_ms"] is not None else 99999,
            ))

            total_players = len(self.players)
            correct_pct = (
                int(correct_count * 100 / total_players)
                if total_players > 0 else 0
            )

            await self.websocket_manager.broadcast({
                "type": "ANSWER_REVEAL",
                "correct": correct_text,
                "correct_index": correct_index,
                "correct_pct": correct_pct,
                "question_results": question_results,
            })

            scoreboard = sorted(
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

            await self.websocket_manager.broadcast({
                "type": "SCOREBOARD",
                "players": scoreboard,
            })

            await asyncio.sleep(5)

        self.state = "FINISHED"

        final_scoreboard = sorted(
            [
                {"nickname": p["nickname"], "score": p["score"]}
                for p in self.players.values()
            ],
            key=lambda x: x["score"],
            reverse=True,
        )

        await self.websocket_manager.broadcast({
            "type": "GAME_FINISHED",
            "players": final_scoreboard,
        })

        self.players = {}
        self.state = "WAITING"
        self.current_question = None
        self.question_start_time = None
        self.answers = {}
        self.start_task = None
        self.start_time = None
