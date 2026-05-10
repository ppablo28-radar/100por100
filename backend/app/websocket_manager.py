from fastapi import WebSocket


class WebSocketManager:
    def __init__(self):
        self.connections = []

    async def connect(self, websocket: WebSocket):
        await websocket.accept()
        self.connections.append(websocket)

    def disconnect(self, websocket: WebSocket):
        self.connections.remove(websocket)

    async def send_personal(self, websocket: WebSocket, message: dict):
        await websocket.send_json(message)

    async def broadcast(self, message: dict):
        disconnected = []

        for connection in self.connections:
            try:
                await connection.send_json(message)
            except:
                disconnected.append(connection)

        for d in disconnected:
            self.disconnect(d)