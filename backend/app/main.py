import asyncio
import uuid

from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.middleware.cors import CORSMiddleware

from app.websocket_manager import WebSocketManager
from app.game_manager import GameManager

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

manager = WebSocketManager()
game_manager = GameManager(manager)

# player_id → modo actual (para saber a qué sala pertenece al responder)
player_modes: dict[str, str] = {}


@app.on_event("startup")
async def startup_event():
    await game_manager.load_questions()
    asyncio.create_task(manager.start_keepalive())


@app.get("/")
async def root():
    return {"message": "100x100 backend running"}


@app.get("/rooms")
async def rooms():
    """Lista de salas activas (para debug)."""
    return {
        mode: {"state": room.state, "players": len(room.players)}
        for mode, room in game_manager.rooms.items()
    }


@app.get("/counts")
async def question_counts():
    """Cuántas preguntas hay por modo — usado por el frontend en el selector."""
    from app.game_manager import count_per_mode
    return count_per_mode(game_manager.questions)


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
                if nickname:
                    player_modes[player_id] = mode
                    await game_manager.add_player(player_id, nickname, mode)

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
