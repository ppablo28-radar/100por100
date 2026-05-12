# 100×100 — Estado del Proyecto

## Qué es

Plataforma de trivia online competitiva. El nombre viene del formato objetivo: 100 jugadores respondiendo 100 preguntas simultáneamente en tiempo real.

**Concepto base:** mezcla entre Kahoot, ajedrez online (rating Elo) y Battle Royale. Todos responden al mismo tiempo, hay ranking en vivo, y el objetivo es hacer que la gente quiera jugar otra partida.

**Filosofía de desarrollo:** validar diversión antes que escalar. El MVP funciona. Primero se prueba con gente real, después se agrega complejidad.

---

## Estado actual (Mayo 2026)

### Lo que funciona en producción hoy

- Partidas multijugador en tiempo real (WebSockets)
- Lobby con countdown: cuando entran 2 jugadores, empieza un timer de 30 segundos para que se anoten más (máximo 10)
- 10 preguntas aleatorias por partida desde una base de 193 preguntas
- Timer de 10 segundos por pregunta con barra de progreso
- Sistema de puntos con bonus por velocidad de respuesta
- Ranking en vivo durante el juego (panel lateral)
- Tabla de posiciones con flechas de movimiento (▲▼) entre rondas
- Reveal de respuesta correcta con porcentaje de aciertos
- Scoreboard final con posición de cada jugador
- Nickname visible en todo momento
- Overlay de "conexión perdida" si se cae el WebSocket
- Preguntas cargadas desde Supabase (no desde archivo local)
- Si se agregan preguntas en Supabase, aparecen en el juego sin redeploy

### Lo que NO está implementado aún

- Login / cuentas de usuario
- Rating Elo persistente
- Analytics de partidas (la estructura de DB existe pero no se usa)
- Panel de administración de preguntas
- Múltiples salas simultáneas
- Modo streamer / códigos de sala
- Preguntas generadas por IA (la arquitectura está lista)
- Mobile optimizado (funciona pero no está pulido)

---

## Infraestructura

### Frontend
- **Plataforma:** Vercel (plan gratuito)
- **URL producción:** https://100por100.vercel.app
- **Framework:** Next.js 16 + React 19 + Tailwind CSS v4
- **Variable de entorno en Vercel:**
  ```
  NEXT_PUBLIC_WS_URL = wss://[URL-DE-RAILWAY]/ws
  ```

### Backend
- **Plataforma:** Railway (plan gratuito)
- **URL pública:** generada por Railway (formato: `algo.up.railway.app`)
- **Framework:** FastAPI + Python
- **Protocolo tiempo real:** WebSockets nativos
- **Variable de entorno en Railway:**
  ```
  DATABASE_URL = postgresql+asyncpg://postgres:[PASSWORD]@db.[REF].supabase.co:5432/postgres
  ```
- **Start command (Procfile):** `uvicorn app.main:app --host 0.0.0.0 --port $PORT`

### Base de datos
- **Plataforma:** Supabase (plan gratuito)
- **Motor:** PostgreSQL
- **Proyecto ref:** hfldkqfxtvhlnkgyjtil
- **Estado:** 18 tablas creadas, 193 preguntas cargadas

### Repositorio
- **GitHub:** https://github.com/ppablo28-radar/100por100
- **Rama principal:** master
- **Estructura:** monorepo con `/backend` y `/frontend`
- Railway deployea desde `/backend`
- Vercel deployea desde `/frontend`

---

## Stack técnico completo

### Backend (`/backend`)
```
FastAPI                  — API y WebSockets
uvicorn[standard]        — servidor ASGI
SQLAlchemy 2.0 async     — ORM
asyncpg                  — driver PostgreSQL async
psycopg2-binary          — driver PostgreSQL sync (Alembic)
Alembic                  — migraciones de base de datos
Pydantic v2              — validación de datos
python-dotenv            — variables de entorno
```

### Frontend (`/frontend`)
```
Next.js 16               — framework React
React 19                 — UI
Tailwind CSS v4          — estilos
TypeScript               — tipado
```

---

## Estructura de archivos clave

```
100x100/
├── backend/
│   ├── app/
│   │   ├── main.py              — FastAPI app, endpoint WebSocket /ws
│   │   ├── game_manager.py      — lógica del juego (estados, puntos, loop)
│   │   ├── websocket_manager.py — broadcast a todos los conectados
│   │   ├── questions.json       — 193 preguntas (fallback local)
│   │   ├── core/
│   │   │   └── config.py        — configuración (DATABASE_URL desde .env)
│   │   ├── db/
│   │   │   ├── base.py          — DeclarativeBase de SQLAlchemy
│   │   │   └── session.py       — AsyncSession y get_db()
│   │   ├── models/
│   │   │   ├── questions.py     — Question, Translation, AnswerOption, ValidationRule
│   │   │   ├── categories.py    — Category (jerárquica), Tag
│   │   │   ├── audiences.py     — QuestionTargetAudience (kids 10-13, región)
│   │   │   ├── media.py         — MediaAsset (imagen/audio/video/gif)
│   │   │   ├── analytics.py     — QuestionAnalytics, Attempt, Feedback
│   │   │   ├── ai.py            — AIGenerationJob, AIReviewResult
│   │   │   └── collections.py   — QuestionCollection, QuestionEvent (audit log)
│   │   ├── schemas/
│   │   │   └── questions.py     — esquemas Pydantic (Create/Read/Update)
│   │   ├── repositories/
│   │   │   └── question_repository.py
│   │   └── services/
│   │       └── question_service.py
│   ├── alembic/
│   │   ├── env.py               — configuración Alembic
│   │   └── versions/
│   │       └── 001_initial_schema.py  — migración inicial (18 tablas)
│   ├── alembic.ini
│   ├── Procfile                 — comando de inicio para Railway
│   ├── requirements.txt
│   ├── .env.example             — template de variables de entorno
│   ├── generate_seed_sql.py     — genera SQL con preguntas para Supabase
│   └── seed_data.sql            — SQL generado con las 193 preguntas
│
├── frontend/
│   └── app/
│       ├── page.tsx             — toda la UI del juego (una sola página)
│       ├── layout.tsx
│       └── globals.css
│
├── .gitignore
├── railway.toml                 — le dice a Railway que use /backend como root
└── ESTADO_PROYECTO.md           — este archivo
```

---

## Cómo correr localmente

### Backend
```bash
cd backend
pip install -r requirements.txt
# Sin DB (usa questions.json):
uvicorn app.main:app --reload
# Con DB (crear .env desde .env.example y llenar DATABASE_URL):
cp .env.example .env
uvicorn app.main:app --reload
```

### Frontend
```bash
cd frontend
npm install
npm run dev
# Abre http://localhost:3000
# El WebSocket apunta a ws://127.0.0.1:8000/ws por defecto
```

Para cambiar el backend en desarrollo, crear `frontend/.env.local`:
```
NEXT_PUBLIC_WS_URL=ws://127.0.0.1:8000/ws
```

---

## Cómo funciona el juego (flujo técnico)

1. Cliente abre WebSocket a `/ws`
2. Jugador envía `JOIN_GAME` con nickname
3. Backend responde con `PLAYER_JOINED` (broadcast a todos)
4. Al llegar el 2do jugador: backend envía `STARTING_SOON` (30 segundos)
5. Al terminar el countdown: backend envía `COUNTDOWN` (3, 2, 1)
6. Para cada pregunta: backend envía `NEW_QUESTION` con opciones y duración
7. Cliente envía `SUBMIT_ANSWER` con índice de opción
8. Después de 10 segundos: backend envía `ANSWER_REVEAL` y `SCOREBOARD`
9. Al terminar todas las preguntas: backend envía `GAME_FINISHED`
10. El juego se resetea automáticamente para la siguiente partida

### Sistema de puntos
```
Puntos = 100 + 50 × (1 - tiempo_respuesta / 10)
```
Respuesta en 1s ≈ 145 pts | en 5s ≈ 125 pts | en 9s ≈ 105 pts | incorrecta = 0 pts

---

## Base de datos — tablas en Supabase

| Tabla | Propósito |
|-------|-----------|
| questions | Definición de cada pregunta |
| question_translations | Texto por idioma (multiidioma) |
| answer_options | Opciones de respuesta (sin límite de 4) |
| answer_validation_rules | Para preguntas numéricas/texto |
| categories | Categorías jerárquicas dinámicas |
| question_categories | Relación pregunta ↔ categoría |
| tags | Tags libres |
| question_tags | Relación pregunta ↔ tag |
| question_target_audiences | Audiencia objetivo (edad, región, kids) |
| media_assets | Imágenes/audio/video para preguntas |
| question_analytics | Métricas agregadas por pregunta |
| question_feedback | Feedback individual de jugadores |
| question_attempts | Cada respuesta de cada jugador (crítica) |
| ai_generation_jobs | Tracking de generación por IA |
| ai_review_results | Resultado de revisión por IA |
| question_collections | Packs temáticos (seasonal, kids, etc.) |
| question_collection_items | Relación colección ↔ pregunta |
| question_events | Log inmutable de eventos (auditoría) |

La DB está diseñada para escalar. Los campos JSONB (`metadata`) permiten agregar datos sin migraciones destructivas.

---

## Preguntas

- **193 preguntas** activas en Supabase
- Categorías: gaming, fútbol/deportes, series/películas, música, internet/tech, ciencia, historia/geografía, cultura general
- **10 preguntas aleatorias** por partida (de los 193 disponibles)
- Formato actual: multiple choice (4 opciones)
- Para agregar preguntas: SQL Editor en Supabase (ver ejemplo en el README)
- La base de datos soporta: múltiple choice, numérico, texto libre, multi-select, multimedia

---

## Roadmap según documentación original

| Fase | Estado |
|------|--------|
| Fase 1: Prototipo local | ✅ Completa |
| Fase 2: MVP Online | ✅ Completa |
| Fase 3: Testing real con usuarios | ← Estamos aquí |
| Fase 4: Sistema persistente (login, historial, rating) | Pendiente |
| Fase 5: Mejorar gameplay (animaciones, sonidos) | Pendiente |
| Fase 6: Mobile optimizado | Pendiente |
| Fase 7: Rating real (rangos, badges) | Pendiente |
| Fase 8: Contenido (IA generando preguntas) | Pendiente |
| Fase 9: Streamer mode (códigos de sala, overlays) | Pendiente |
| Fase 10: Escalabilidad (Redis, múltiples servidores) | Pendiente |

**Métrica clave de la Fase 3:** replay rate — ¿cuántos jugadores quieren jugar otra partida?

---

## Archivos de diseño

En la raíz del proyecto hay archivos `.txt` con la evolución del diseño:
- `0 ideas generales.txt` — concepto inicial y visión
- `1 definir reglas exactas.txt` — reglas del MVP
- `1.1 a 1.9` — flujo, pantallas, backend, DB, rating, preguntas
- `2.0 a 2.3` — matchmaking, psicología del juego, crecimiento, roadmap
- `filosofia.txt` — principio fundamental del proyecto
