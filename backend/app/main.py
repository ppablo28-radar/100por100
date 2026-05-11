import uuid

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi import WebSocket
from fastapi import WebSocketDisconnect

from app.websocket_manager import WebSocketManager
from app.game_manager import GameManager


app = FastAPI()


@app.on_event("startup")
async def startup_event():
    await game_manager.load_questions()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

manager = WebSocketManager()
game_manager = GameManager(manager)


@app.get("/")
async def root():
    return {"message": "100x100 backend running"}


@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await manager.connect(websocket)

    player_id = str(uuid.uuid4())

    try:
        while True:
            data = await websocket.receive_json()

            message_type = data.get("type")

            if message_type == "JOIN_GAME":
                nickname = data.get("nickname", "").strip()
                if nickname:
                    await game_manager.add_player(player_id, nickname)

            elif message_type == "SUBMIT_ANSWER":
                answer = data.get("answer")
                if answer is not None:
                    await game_manager.submit_answer(player_id, answer)

    except WebSocketDisconnect:
        manager.disconnect(websocket)
        await game_manager.remove_player(player_id)
