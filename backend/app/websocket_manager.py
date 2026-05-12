import asyncio
from fastapi import WebSocket


class WebSocketManager:
    def __init__(self):
        self.connections: list[WebSocket] = []

    async def connect(self, websocket: WebSocket):
        await websocket.accept()
        self.connections.append(websocket)

    def disconnect(self, websocket: WebSocket):
        if websocket in self.connections:
            self.connections.remove(websocket)

    async def send_personal(self, websocket: WebSocket, message: dict):
        await websocket.send_json(message)

    async def broadcast(self, message: dict):
        disconnected = []
        for connection in self.connections:
            try:
                await connection.send_json(message)
            except Exception:
                disconnected.append(connection)
        for d in disconnected:
            self.disconnect(d)

    async def start_keepalive(self):
        """Envía PING cada 20s para evitar que el proxy de Railway corte la conexión."""
        while True:
            await asyncio.sleep(20)
            await self.broadcast({"type": "PING"})
