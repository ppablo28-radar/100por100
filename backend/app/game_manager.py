import asyncio
import json
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

        with open("app/questions.json", "r", encoding="utf-8") as f:
            self.questions = json.load(f)

    async def add_player(self, player_id, nickname):
        if self.state not in ("WAITING", "STARTING"):
            return
        if len(self.players) >= MAX_PLAYERS:
            return

        self.players[player_id] = {"nickname": nickname, "score": 0}

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
            for pid, answer_data in self.answers.items():
                if pid not in self.players:
                    continue
                if answer_data["answer"] == correct_index:
                    correct_count += 1
                    t = answer_data["response_time"]
                    points = int(100 + 50 * (1 - t / 10))
                    self.players[pid]["score"] += points

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
            })

            scoreboard = sorted(
                [
                    {"nickname": p["nickname"], "score": p["score"]}
                    for p in self.players.values()
                ],
                key=lambda x: x["score"],
                reverse=True,
            )

            await self.websocket_manager.broadcast({
                "type": "SCOREBOARD",
                "players": scoreboard,
            })

            await asyncio.sleep(3)

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
