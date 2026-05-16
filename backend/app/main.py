import asyncio
import logging
import uuid

from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.middleware.cors import CORSMiddleware

from app.websocket_manager import WebSocketManager
from app.game_manager import GameManager
from app.generator_engine.engine import RuntimeEngine

logger = logging.getLogger(__name__)

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

manager = WebSocketManager()
runtime_engine = RuntimeEngine()
game_manager = GameManager(manager, runtime_engine)

# player_id → modo actual (para saber a qué sala pertenece al responder)
player_modes: dict[str, str] = {}


@app.on_event("startup")
async def startup_event():
    await game_manager.load_questions()
    asyncio.create_task(manager.start_keepalive())
    # Intentar cargar el motor procedural (falla silenciosamente si no hay DB)
    asyncio.create_task(_load_procedural_engine())


async def _load_procedural_engine():
    import os
    db_url = os.getenv("DATABASE_URL", "").replace("postgresql+asyncpg://", "postgresql://")
    if not db_url:
        logger.info("RuntimeEngine: DATABASE_URL no configurada, saltando carga procedural.")
        return
    try:
        await runtime_engine.load_from_asyncpg(db_url)
    except Exception as e:
        logger.warning("RuntimeEngine: no se pudo cargar: %s", e)


@app.get("/")
async def root():
    return {"message": "100x100 backend running"}


@app.get("/test-db")
async def test_db():
    """Diagnóstico completo de conexión a Supabase."""
    import os
    db_url = os.getenv("DATABASE_URL", "")
    env_keys = [k for k in os.environ if "DATA" in k or "DB" in k or "SQL" in k or "SUPA" in k]

    if not db_url:
        return {
            "status": "ERROR",
            "problem": "DATABASE_URL no está seteada",
            "env_keys_relacionadas": env_keys,
            "fix": "Railway → tu servicio backend → Variables → agregar DATABASE_URL",
        }

    try:
        import asyncpg
        url = db_url.replace("postgresql+asyncpg://", "postgresql://")
        conn = await asyncpg.connect(url, timeout=10)
        q_count = await conn.fetchval("SELECT COUNT(*) FROM questions")
        t_count = await conn.fetchval("SELECT COUNT(*) FROM tags")
        await conn.close()
        return {
            "status": "OK",
            "db_url_preview": db_url[:50] + "...",
            "preguntas_en_supabase": q_count,
            "tags_en_supabase": t_count,
            "preguntas_en_memoria": len(game_manager.questions),
        }
    except Exception as e:
        return {
            "status": "ERROR",
            "db_url_preview": db_url[:50] + "...",
            "error": str(e),
        }


@app.get("/rooms")
async def rooms():
    """Lista de salas activas (para debug)."""
    return {
        mode: {"state": room.state, "players": len(room.players)}
        for mode, room in game_manager.rooms.items()
    }


@app.get("/reload")
async def reload_questions():
    """Recarga las preguntas desde Supabase sin reiniciar el servidor."""
    import os
    db_url = os.getenv("DATABASE_URL", "")
    before = len(game_manager.questions)

    error = None
    if not db_url:
        error = "DATABASE_URL no está configurada en Railway"
    else:
        try:
            await game_manager.load_questions()
        except Exception as e:
            error = str(e)

    after = len(game_manager.questions)
    return {
        "before": before,
        "after": after,
        "new": after - before,
        "db_url_set": bool(db_url),
        "db_url_preview": db_url[:40] + "..." if len(db_url) > 40 else db_url,
        "error": error,
    }


@app.get("/counts")
async def question_counts():
    """Cuántas preguntas hay por modo — usado por el frontend en el selector."""
    from app.game_manager import count_per_mode
    return count_per_mode(game_manager.questions)


@app.get("/modes")
async def available_modes():
    """Todos los modos secundarios que tienen al menos 1 pregunta."""
    from app.game_manager import infer_tags

    PRESET_KEYS = {"general", "gaming", "futbol", "anime", "ciencia", "musica"}

    tag_counts: dict[str, int] = {}
    for q in game_manager.questions:
        db_tags = set(q.get("tags") or [])
        inferred = set(infer_tags(q.get("question", "")))
        for tag in db_tags | inferred:
            if tag not in PRESET_KEYS:
                tag_counts[tag] = tag_counts.get(tag, 0) + 1

    return sorted(
        [{"mode": k, "count": v} for k, v in tag_counts.items() if v >= 1],
        key=lambda x: -x["count"],
    )


@app.get("/admin/seed")
async def admin_seed():
    """Corre el seeder completo desde Railway. Idempotente — se puede correr múltiples veces."""
    import os
    db_url = os.getenv("DATABASE_URL", "").replace("postgresql+asyncpg://", "postgresql://")
    if not db_url:
        return {"error": "DATABASE_URL no configurada"}
    try:
        from app.seeder import seed_all
        result = await seed_all(db_url)
        # Recargar el engine automáticamente
        await runtime_engine.load_from_asyncpg(db_url)
        result["engine"] = runtime_engine.stats()
        return result
    except Exception as e:
        import traceback
        return {"error": str(e), "detail": traceback.format_exc()}


@app.get("/procedural/stats")
async def procedural_stats():
    """Estado del motor procedural en memoria."""
    return runtime_engine.stats()


@app.get("/procedural/generate")
async def procedural_generate(type: str | None = None):
    """
    Genera una pregunta procedural de muestra (sin persistir).
    Parámetro opcional: ?type=timeline_order | higher_lower | closest_number | ranking_order
    """
    if not runtime_engine.loaded:
        return {"error": "Motor procedural no cargado. Verificá DATABASE_URL y ejecutá seed_knowledge.py"}
    payload = runtime_engine.generate_question(generator_type=type)
    if payload is None:
        return {"error": f"No hay datos suficientes para generar preguntas de tipo '{type}'"}
    return payload


@app.get("/procedural/reload")
async def procedural_reload():
    """Recarga los datos del motor procedural desde la DB."""
    import os
    db_url = os.getenv("DATABASE_URL", "").replace("postgresql+asyncpg://", "postgresql://")
    if not db_url:
        return {"error": "DATABASE_URL no configurada"}
    try:
        await runtime_engine.load_from_asyncpg(db_url)
        return {"ok": True, **runtime_engine.stats()}
    except Exception as e:
        return {"error": str(e)}


@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    player_id = str(uuid.uuid4())
    await manager.connect(websocket, player_id)

    try:
        while True:
            data = await websocket.receive_json()
            message_type = data.get("type")

            if message_type == "JOIN_GAME":
                nickname = data.get("nickname", "").strip()
                mode = data.get("mode", "general").strip().lower() or "general"
                selected_slugs = data.get("selected_slugs") or None
                if nickname:
                    player_modes[player_id] = mode
                    await game_manager.add_player(player_id, nickname, mode, selected_slugs)

            elif message_type == "SUBMIT_ANSWER":
                answer = data.get("answer")
                mode = player_modes.get(player_id, "general")
                if answer is not None:
                    await game_manager.submit_answer(player_id, answer, mode)

            elif message_type == "PONG":
                pass

    except WebSocketDisconnect:
        mode = player_modes.pop(player_id, "general")
        manager.disconnect(websocket, player_id)
        await game_manager.remove_player(player_id, mode)
