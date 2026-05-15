import asyncio
import json
import os
import random
import re
import time

MAX_PLAYERS = 10
START_DELAY = 30
QUESTIONS_PER_GAME = 10
PROCEDURAL_RATIO = 1.0

# ─── Filtro de entidades activas ─────────────────────────────────────────────
# Controlá qué tablas participan en el juego.
# Para agregar YouTubers: ["country", "youtuber"]
# Para juego general:    []  (sin filtro — todos los generadores)
ACTIVE_ENTITY_TYPES = ["country"]  # TEST MODE: solo países

# ── Keywords para inferir tags cuando la DB no los tiene ─────────────────────
TAG_KEYWORDS: dict[str, list[str]] = {
    "gaming": [
        "minecraft", "roblox", "fortnite", "pokemon", "videojuego", "nintendo",
        "playstation", "xbox", "valorant", "counter-strike", "gta", "zelda",
        "mario", "sonic", "gaming", "consola", "among us", "among-us",
        "mrbeast", "mr beast", "rubius", "vegetta", "ibai", "spreen", "dream smp",
        "v-bucks", "robux", "league of legends", "free fire", "overwatch", "apex",
        "call of duty", "kratos", "god of war", "master chief", "halo",
        "red dead", "animal crossing", "breath of the wild", "twitch",
        "streamer", "creeper", "enderman", "nether", "pikachu", "charmander",
        "bulbasaur", "squirtle", "eevee", "mewtwo", "pokédex", "pokémon",
        "saiyan", "duel monsters", "yu-gi", "hollow knight", "undertale",
        "mortal kombat", "street fighter", "super smash", "megaman", "kirby",
    ],
    "anime": [
        "anime", "manga", "naruto", "dragon ball", "one piece", "my hero academia",
        "demon slayer", "attack on titan", "sword art online", "goku", "vegeta",
        "one punch man", "bleach", "luffy", "sasuke", "sakura", "midoriya",
        "tanjiro", "shingeki", "kimetsu", "boku no hero", "fullmetal",
        "death note", "saint seiya", "caballeros del zodiaco", "yu-gi-oh",
        "tokyo revengers", "jujutsu kaisen", "spy x family", "re:zero",
        "hunter x hunter", "fairy tail", "dragon quest", "digimon", "hashira",
        "quirk", "kamehameha", "sharingan", "byakugan", "jutsu", "shinigami",
    ],
    "futbol": [
        "fútbol", "futbol", "mundial", "messi", "ronaldo", "cristiano",
        "champions league", "copa america", "copa del mundo", "selección",
        "gol", "penalti", "penal", "árbitro", "balón de oro", "fifa",
        "premier league", "mbappé", "neymar", "maradona", "liga",
        "albiceleste", "offside", "fuera de juego", "corner", "portero",
        "arquero", "delantero", "mediocampista", "defensor", "cancha",
    ],
    "deportes": [
        "nba", "básquet", "basquet", "tenis", "olímpico", "olimpiadas",
        "atletismo", "natación", "rugby", "voleibol", "béisbol",
        "fórmula 1", "f1", "michael jordan", "lebron", "federer",
        "djokovic", "nadal", "usain bolt", "set de tenis", "grand slam",
        "try", "touchdown", "home run", "slam dunk", "triple", "three-pointer",
    ],
    "musica": [
        "música", "musica", "cantante", "canción", "cancion", "álbum", "album",
        "bts", "taylor swift", "billie eilish", "bad bunny", "shakira",
        "bizarrap", "karol g", "j balvin", "maluma", "daddy yankee",
        "beatles", "michael jackson", "despacito", "one direction", "blackpink",
        "grammy", "spotify", "concierto", "banda", "reggaetón", "reggaeton",
        "trap", "pop", "rock", "nicki nicole", "rosalía", "rosalia",
        "olivia rodrigo", "the weeknd", "abel tesfaye", "harry styles",
        "justin bieber", "ariana grande", "dua lipa", "liam payne",
        "zayn", "peso pluma", "anitta", "ozuna",
    ],
    "ciencia": [
        "planeta", "sistema solar", "temperatura", "química", "quimica",
        "física", "fisica", "biología", "biologia", "hueso", "corazón",
        "cerebro", "velocidad de la luz", "elemento", "oxígeno", "oxigeno",
        "sangre", "músculo", "musculo", "célula", "celula", "átomo", "atomo",
        "tabla periódica", "tabla periodica", "newton", "einstein", "voltio",
        "neutron", "radiación", "fotosíntesis", "fotosintesis", "ecosistema",
        "gravedad", "relatividad", "evolución", "adn", "dna", "bacteria",
        "virus", "molécula", "molecula", "reacción química", "isótopo",
        "fémur", "femur", "costilla", "vértebra", "vertebra", "diente",
        "cromosoma", "litro", "kilómetro", "kilogramo", "hectárea",
    ],
    "series": [
        "harry potter", "hogwarts", "voldemort", "hermione", "dumbledore",
        "star wars", "darth vader", "jedi", "yoda", "mandalorian",
        "marvel", "avengers", "spider-man", "iron man", "captain america",
        "thor", "batman", "superman", "joker", "dc comics",
        "frozen", "arendelle", "toy story", "pixar", "disney",
        "stranger things", "squid game", "la casa de papel", "cobra kai",
        "friends", "the office", "breaking bad", "game of thrones",
        "el señor de los anillos", "lord of the rings", "hobbit",
        "piratas del caribe", "jack sparrow", "rey leon", "el rey leon",
        "gravity falls", "teen titans", "miraculous", "ladybug",
        "hunger games", "juegos del hambre", "black panther", "shrek",
        "los simpsons", "simpson",
    ],
    "internet": [
        "tiktok", "instagram", "twitter", "redes sociales", "meme",
        "emoji", "viral", "streaming", "discord", "hashtag", "influencer",
        "youtuber", "doge", "lol", "afk", "gg", "goat", "khaby lame",
        "charlie d'amelio", "renegade", "url", "http", "byte", "terabyte",
        "wi-fi", "whatsapp", "facebook", "snapchat", "linkedin",
        "navegador", "chrome", "safari", "firefox", "gmail",
    ],
}

_SLUG_RE = re.compile(r"[^a-z0-9]")


def _text_to_slug(text: str) -> str:
    t = text.lower()
    for a, b in [("á","a"),("é","e"),("í","i"),("ó","o"),("ú","u"),("ñ","n")]:
        t = t.replace(a, b)
    return t


def infer_tags(question_text: str) -> list[str]:
    """Infiere los tags de una pregunta por coincidencia de keywords."""
    slug = _text_to_slug(question_text)
    found = [tag for tag, kws in TAG_KEYWORDS.items()
             if any(kw in slug for kw in kws)]
    return found or ["general"]


def _filter_by_mode(mode: str, all_questions: list[dict]) -> list[dict]:
    """Filtra preguntas por modo SIN fallback. Puede devolver lista vacía."""
    if mode == "general":
        return all_questions
    result = []
    for q in all_questions:
        db_tags = set(q.get("tags") or [])
        inferred = set(infer_tags(q.get("question", "")))
        if mode in (db_tags | inferred):
            result.append(q)
    return result


def get_questions_for_mode(mode: str, all_questions: list[dict]) -> list[dict]:
    """Retorna preguntas para un modo; cae a 'general' si el modo tiene < 5."""
    filtered = _filter_by_mode(mode, all_questions)
    return filtered if len(filtered) >= 5 else all_questions


def count_per_mode(all_questions: list[dict]) -> dict[str, int]:
    """Cuenta preguntas REALES por modo (sin fallback)."""
    modes = ["general"] + list(TAG_KEYWORDS.keys())
    return {m: len(_filter_by_mode(m, all_questions)) for m in modes}


class GameRoom:
    """Una sala de juego independiente para un modo específico."""

    def __init__(self, mode: str, ws_manager, runtime_engine=None):
        self.mode = mode
        self.ws = ws_manager
        self.runtime_engine = runtime_engine
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
        return get_questions_for_mode(self.mode, all_questions)

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

    async def submit_answer(self, player_id: str, answer):
        if (
            self.state == "QUESTION"
            and player_id in self.players
            and player_id not in self.answers
            and self.question_start_time is not None
        ):
            duration = self.current_question.get("_duration", 10) if self.current_question else 10
            response_time = min(time.time() - self.question_start_time, float(duration))
            self.answers[player_id] = {
                "answer": answer,
                "response_time": response_time,
            }

    # ─── Helpers procedurales ─────────────────────────────────────────────────

    def _available_slugs(self) -> list[str]:
        """
        Devuelve todos los slugs del engine que coincidan con ACTIVE_ENTITY_TYPES.
        Si ACTIVE_ENTITY_TYPES está vacío, devuelve todos los generadores.
        """
        engine = self.runtime_engine
        if not engine or not engine.loaded:
            return []
        result = []
        for g in engine._generators:
            if g["instance"] is None:
                continue
            if not ACTIVE_ENTITY_TYPES:
                result.append(g["slug"])
                continue
            entity_types = g["config"].get("allowed_entity_types", [])
            if any(t in entity_types for t in ACTIVE_ENTITY_TYPES):
                result.append(g["slug"])
        return result

    def _build_slug_queue(self):
        """
        Cola para una partida completa:
        - Cada generador disponible aparece al menos 1 vez
        - Los slots restantes se rellenan al azar entre los disponibles
        - Todo mezclado — orden impredecible cada partida

        Escala automáticamente: agregar generadores al DB + reload
        los incorpora sin tocar código.
        """
        available = self._available_slugs()
        if not available:
            self._slug_queue = []
            return
        base = available[:]
        random.shuffle(base)
        extra_n = max(0, QUESTIONS_PER_GAME - len(base))
        extra = [random.choice(available) for _ in range(extra_n)]
        queue = base + extra
        random.shuffle(queue)
        self._slug_queue = queue
        print(f"[queue] {len(queue)} preguntas de {len(available)} generadores: {available}")

    def _next_slug(self) -> str:
        if not getattr(self, "_slug_queue", None):
            self._build_slug_queue()
        return self._slug_queue.pop(0)

    def _pick_next_question(self, pool: list[dict]) -> dict:
        """Selecciona handcrafted o procedural según PROCEDURAL_RATIO."""
        engine = self.runtime_engine
        if engine and engine.loaded:
            available = self._available_slugs()
            slug = self._next_slug()
            tried = {slug}
            payload = engine.generate_question(generator_slug=slug)
            while payload is None:
                remaining = [s for s in available if s not in tried]
                if not remaining:
                    break
                alt = random.choice(remaining)
                tried.add(alt)
                payload = engine.generate_question(generator_slug=alt)
            if payload:
                print(f"[procedural] {payload['question_type']} via {slug}")
                return {"_type": payload["question_type"], **payload}
        raise RuntimeError(
            "Ningún generador pudo producir una pregunta. "
            "Verificá que el SQL fue ejecutado y llamá a /procedural/reload"
        )

    def _check_answer(self, question: dict, answer) -> bool:
        qtype = question.get("_type", "multiple_choice")
        if qtype == "multiple_choice":
            return answer == question.get("correct")
        if qtype in ("higher_lower", "closest_number"):
            return str(answer) == str(question.get("correct_id", ""))
        if qtype in ("timeline_order", "ranking_order"):
            return list(answer) == list(question.get("correct_order", []))
        return False

    def _score_closest_number(self, question: dict, answers: dict, players: dict) -> list[dict]:
        """Puntaje por proximidad al valor real. El más cercano gana."""
        real = float(question.get("real_value", 0))
        if real == 0:
            return []
        results = []
        distances: list[tuple[str, float, float]] = []  # (pid, answer, dist)
        for pid, ad in answers.items():
            if pid not in players:
                continue
            try:
                val = float(ad["answer"])
            except (TypeError, ValueError):
                continue
            dist = abs(val - real)
            distances.append((pid, val, dist))
        if not distances:
            return []
        min_dist = min(d for _, _, d in distances)
        duration = question.get("_duration", 10)
        for pid, val, dist in distances:
            t = answers[pid]["response_time"]
            # Puntos: 100 base si es el más cercano, proporcional si no
            is_closest = dist == min_dist
            proximity = max(0.0, 1.0 - dist / max(real, 1))
            pts = int((100 * proximity + 30 * (1 - t / duration)) * (1.5 if is_closest else 1))
            players[pid]["score"] += pts
            players[pid]["answered_count"] += 1
            players[pid]["total_time_ms"] += int(t * 1000)
            if is_closest:
                players[pid]["correct_count"] += 1
            results.append({
                "nickname": players[pid]["nickname"],
                "correct": is_closest,
                "response_time_ms": int(t * 1000),
                "points_earned": pts,
                "answer_value": val,
            })
        results.sort(key=lambda x: -x["points_earned"])
        return results

    async def _broadcast_question(self, question: dict, num: int, total: int, duration: int):
        qtype = question.get("_type", "multiple_choice")
        base = {
            "type": "NEW_QUESTION",
            "question_type": qtype,
            "question_number": num,
            "total_questions": total,
            "duration": duration,
            "debug": {
                "generator_slug": question.get("generator_slug", "handcrafted"),
                "generator_type": question.get("generator_type", qtype),
                "entity_types": question.get("entity_types", []),
            },
        }
        if qtype == "multiple_choice":
            await self._broadcast({
                **base,
                "question": question["question"],
                "options": question["options"],
            })
        elif qtype == "higher_lower":
            await self._broadcast({
                **base,
                "question": question.get("question_text", "¿Cuál tiene más?"),
                "options": question.get("options", []),
                "attribute_name": question.get("attribute_name", ""),
                "unit": question.get("unit", ""),
            })
        elif qtype == "ranking_order":
            await self._broadcast({
                **base,
                "question": question.get("question_text", "Ordená según el valor"),
                "options": question.get("options", []),
                "attribute_name": question.get("attribute_name", ""),
                "unit": question.get("unit", ""),
            })
        elif qtype == "closest_number":
            await self._broadcast({
                **base,
                "question": question.get("question_text", "¿Cuánto vale?"),
                "entity_name": question.get("entity_name", ""),
                "attribute_name": question.get("attribute_name", ""),
                "unit": question.get("unit", ""),
                "options": question.get("options", []),
            })
        elif qtype == "timeline_order":
            await self._broadcast({
                **base,
                "question": question.get("question_text", "Ordená de más antiguo a más reciente"),
                "events": question.get("events", []),
            })

    async def _broadcast_reveal(self, question: dict, correct_pct: int, question_results: list):
        qtype = question.get("_type", "multiple_choice")
        base = {
            "type": "ANSWER_REVEAL",
            "question_type": qtype,
            "correct_pct": correct_pct,
            "question_results": question_results,
        }
        if qtype == "multiple_choice":
            correct_index = question.get("correct", 0)
            await self._broadcast({
                **base,
                "correct": question["options"][correct_index],
                "correct_index": correct_index,
            })
        elif qtype == "higher_lower":
            correct_id = question.get("correct_id", "")
            correct_name = next(
                (o["name"] for o in question.get("options", []) if o["id"] == correct_id), "?"
            )
            await self._broadcast({
                **base,
                "correct_id": correct_id,
                "correct_name": correct_name,
                "values": question.get("values", {}),
                "attribute_name": question.get("attribute_name", ""),
                "unit": question.get("unit", ""),
                "options": question.get("options", []),
            })
        elif qtype == "ranking_order":
            correct_order = question.get("correct_order", [])
            opts_by_id = {o["id"]: o["name"] for o in question.get("options", [])}
            await self._broadcast({
                **base,
                "correct_order": correct_order,
                "correct_order_titles": [opts_by_id.get(eid, eid) for eid in correct_order],
                "values": question.get("values", {}),
                "attribute_name": question.get("attribute_name", ""),
                "unit": question.get("unit", ""),
                "options": question.get("options", []),
            })
        elif qtype == "closest_number":
            await self._broadcast({
                **base,
                "correct_id": question.get("correct_id", ""),
                "real_value": question.get("real_value"),
                "entity_name": question.get("entity_name", ""),
                "attribute_name": question.get("attribute_name", ""),
                "unit": question.get("unit", ""),
                "options": question.get("options", []),
            })
        elif qtype == "timeline_order":
            correct_order = question.get("correct_order", [])
            events_by_id = {e["id"]: e["title"] for e in question.get("events", [])}
            await self._broadcast({
                **base,
                "correct_order": correct_order,
                "correct_order_titles": [events_by_id.get(eid, eid) for eid in correct_order],
                "events": question.get("events", []),
            })

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
        try:
            await self._game_loop(all_questions)
        except Exception as e:
            import traceback
            print(f"[game_loop CRASH] {e}")
            traceback.print_exc()
            await self._broadcast({"type": "ERROR", "message": str(e)})
            self.state = "WAITING"
            self.players = {}
            self.player_ids = set()
            self.current_question = None
            self.answers = {}

    async def _game_loop(self, all_questions: list[dict]):
        self.state = "QUESTION"
        self._build_slug_queue()   # siempre fresca al inicio de cada partida
        pool = self._get_questions(all_questions)
        if not pool and not (self.runtime_engine and self.runtime_engine.loaded):
            raise RuntimeError("Sin preguntas disponibles y motor procedural no cargado")
        total = QUESTIONS_PER_GAME

        for i in range(total):
            question = self._pick_next_question(pool)
            qtype = question.get("_type", "multiple_choice")
            if qtype == "ranking_order":
                n_opts = len(question.get("options", []))
                duration = max(8, n_opts * 4)   # 2→8s  3→12s  4→16s  5→20s  6→24s
            elif qtype == "timeline_order":
                duration = 15
            else:
                duration = 10
            question["_duration"] = duration

            self.current_question = question
            self.answers = {}
            self.question_start_time = time.time()

            await self._broadcast_question(question, i + 1, total, duration)
            await asyncio.sleep(duration)

            correct_count = 0
            question_results = []

            for pid, answer_data in self.answers.items():
                    if pid not in self.players:
                        continue
                    is_correct = self._check_answer(question, answer_data["answer"])
                    t = answer_data["response_time"]
                    pts = int(100 + 50 * (1 - t / duration)) if is_correct else 0
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

            await self._broadcast_reveal(question, correct_pct, question_results)
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

    def __init__(self, ws_manager, runtime_engine=None):
        self.ws = ws_manager
        self.runtime_engine = runtime_engine
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
            self.rooms[mode] = GameRoom(mode, self.ws, self.runtime_engine)
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
