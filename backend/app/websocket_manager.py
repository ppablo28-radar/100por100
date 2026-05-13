import asyncio
from fastapi import WebSocket


class WebSocketManager:
    def __init__(self):
        self.connections: list[WebSocket] = []
        # player_id → WebSocket para broadcasts dirigidos por sala
        self.player_sockets: dict[str, WebSocket] = {}

    async def connect(self, websocket: WebSocket, player_id: str):
        await websocket.accept()
        self.connections.append(websocket)
        self.player_sockets[player_id] = websocket

    def disconnect(self, websocket: WebSocket, player_id: str | None = None):
        if websocket in self.connections:
            self.connections.remove(websocket)
        if player_id and player_id in self.player_sockets:
            del self.player_sockets[player_id]

    async def send_personal(self, websocket: WebSocket, message: dict):
        await websocket.send_json(message)

    async def broadcast_to(self, player_ids: set[str], message: dict):
        """Envía solo a los jugadores de una sala específica."""
        dead: list[str] = []
        for pid in player_ids:
            ws = self.player_sockets.get(pid)
            if not ws:
                continue
            try:
                await ws.send_json(message)
            except Exception:
                dead.append(pid)
        for pid in dead:
            ws = self.player_sockets.pop(pid, None)
            if ws and ws in self.connections:
                self.connections.remove(ws)

    async def broadcast(self, message: dict):
        """Broadcast global (usado solo para PING keepalive)."""
        dead: list[WebSocket] = []
        for connection in self.connections:
            try:
                await connection.send_json(message)
            except Exception:
                dead.append(connection)
        for d in dead:
            if d in self.connections:
                self.connections.remove(d)

    async def start_keepalive(self):
        """Envía PING cada 20s para evitar que el proxy corte la conexión."""
        while True:
            await asyncio.sleep(20)
            await self.broadcast({"type": "PING"})
