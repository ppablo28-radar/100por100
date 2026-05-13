"""
Seed del motor procedural de conocimiento.

Inserta:
  - Atributos (subscribers, population, release_year, goals, etc.)
  - Entidades (YouTubers, países, videojuegos, futbolistas, etc.)
  - Valores de atributos por entidad
  - Eventos de timeline (historia, gaming, cultura pop)
  - Generadores procedurales habilitados

Uso:
    cd backend
    python seed_knowledge.py
"""
import asyncio
import os
import uuid
from datetime import datetime

import asyncpg
from dotenv import load_dotenv

load_dotenv()

DB_URL = os.getenv("DATABASE_URL", "").replace("postgresql+asyncpg://", "postgresql://")

# ─── Datos ────────────────────────────────────────────────────────────────────

ATTRIBUTES = [
    {"slug": "subscribers",    "name": "Suscriptores",   "data_type": "integer", "unit": "millones"},
    {"slug": "population",     "name": "Población",      "data_type": "integer", "unit": "millones de personas"},
    {"slug": "area_km2",       "name": "Superficie",     "data_type": "float",   "unit": "km²"},
    {"slug": "release_year",   "name": "Año de lanzamiento", "data_type": "integer", "unit": "año"},
    {"slug": "goals_career",   "name": "Goles en carrera", "data_type": "integer", "unit": "goles"},
    {"slug": "speed_kmh",      "name": "Velocidad máxima", "data_type": "float",  "unit": "km/h"},
    {"slug": "height_cm",      "name": "Altura",         "data_type": "integer", "unit": "cm"},
    {"slug": "units_sold_m",   "name": "Unidades vendidas", "data_type": "float", "unit": "millones"},
    {"slug": "metacritic",     "name": "Metacritic",     "data_type": "integer", "unit": "puntos"},
    {"slug": "founded_year",   "name": "Año de fundación", "data_type": "integer", "unit": "año"},
]

YOUTUBERS = [
    {"name": "MrBeast",        "slug": "mrbeast",        "subscribers": 400},
    {"name": "T-Series",       "slug": "t-series",       "subscribers": 280},
    {"name": "Cocomelon",      "slug": "cocomelon",       "subscribers": 185},
    {"name": "SET India",      "slug": "set-india",      "subscribers": 175},
    {"name": "PewDiePie",      "slug": "pewdiepie",      "subscribers": 111},
    {"name": "Like Nastya",    "slug": "like-nastya",    "subscribers": 120},
    {"name": "Vlad y Niki",    "slug": "vlad-y-niki",   "subscribers": 115},
    {"name": "Kids Diana Show","slug": "kids-diana-show","subscribers": 125},
    {"name": "Ibai",           "slug": "ibai",           "subscribers": 12},
    {"name": "ElRubius",       "slug": "elrubius",       "subscribers": 40},
    {"name": "Luisito Comunica","slug": "luisito-comunica","subscribers": 40},
    {"name": "Auronplay",      "slug": "auronplay",      "subscribers": 30},
    {"name": "Vegetta777",     "slug": "vegetta777",     "subscribers": 33},
    {"name": "Willyrex",       "slug": "willyrex",       "subscribers": 17},
    {"name": "TheGrefg",       "slug": "thegrefg",       "subscribers": 18},
]

COUNTRIES = [
    {"name": "China",          "slug": "china",          "population": 1411, "area_km2": 9596960},
    {"name": "India",          "slug": "india",          "population": 1428, "area_km2": 3287263},
    {"name": "Estados Unidos", "slug": "eeuu",           "population": 335,  "area_km2": 9833517},
    {"name": "Brasil",         "slug": "brasil",         "population": 215,  "area_km2": 8515767},
    {"name": "Argentina",      "slug": "argentina",      "population": 46,   "area_km2": 2780400},
    {"name": "México",         "slug": "mexico",         "population": 128,  "area_km2": 1964375},
    {"name": "Colombia",       "slug": "colombia",       "population": 52,   "area_km2": 1141748},
    {"name": "España",         "slug": "espana",         "population": 47,   "area_km2": 505990},
    {"name": "Uruguay",        "slug": "uruguay",        "population": 3,    "area_km2": 176215},
    {"name": "Chile",          "slug": "chile",          "population": 19,   "area_km2": 756102},
    {"name": "Rusia",          "slug": "rusia",          "population": 144,  "area_km2": 17098242},
    {"name": "Canadá",         "slug": "canada",         "population": 38,   "area_km2": 9984670},
    {"name": "Australia",      "slug": "australia",      "population": 26,   "area_km2": 7692024},
    {"name": "Japón",          "slug": "japon",          "population": 124,  "area_km2": 377915},
    {"name": "Alemania",       "slug": "alemania",       "population": 84,   "area_km2": 357114},
]

GAMES = [
    {"name": "Minecraft",      "slug": "minecraft",      "release_year": 2011, "units_sold_m": 300,  "metacritic": 93},
    {"name": "GTA V",          "slug": "gta-v",          "release_year": 2013, "units_sold_m": 200,  "metacritic": 97},
    {"name": "Tetris",         "slug": "tetris",         "release_year": 1984, "units_sold_m": 520,  "metacritic": 92},
    {"name": "Fortnite",       "slug": "fortnite",       "release_year": 2017, "units_sold_m": 0,    "metacritic": 81},
    {"name": "Roblox",         "slug": "roblox",         "release_year": 2006, "units_sold_m": 0,    "metacritic": 0},
    {"name": "Among Us",       "slug": "among-us",       "release_year": 2018, "units_sold_m": 0,    "metacritic": 85},
    {"name": "The Last of Us", "slug": "the-last-of-us", "release_year": 2013, "units_sold_m": 20,   "metacritic": 95},
    {"name": "Zelda: Breath of the Wild", "slug": "zelda-botw", "release_year": 2017, "units_sold_m": 32, "metacritic": 97},
    {"name": "Super Mario Bros", "slug": "super-mario-bros", "release_year": 1985, "units_sold_m": 58, "metacritic": 0},
    {"name": "Pokémon Rojo/Azul", "slug": "pokemon-rojo-azul", "release_year": 1996, "units_sold_m": 31, "metacritic": 0},
    {"name": "Call of Duty: MW", "slug": "cod-mw",       "release_year": 2007, "units_sold_m": 30,   "metacritic": 94},
    {"name": "FIFA 24",        "slug": "fifa-24",        "release_year": 2023, "units_sold_m": 10,   "metacritic": 73},
]

FOOTBALLERS = [
    {"name": "Lionel Messi",   "slug": "messi",          "goals_career": 820, "height_cm": 169},
    {"name": "Cristiano Ronaldo","slug": "cristiano",    "goals_career": 890, "height_cm": 187},
    {"name": "Pelé",           "slug": "pele",           "goals_career": 767, "height_cm": 173},
    {"name": "Ronaldo Nazário","slug": "ronaldo-r9",     "goals_career": 414, "height_cm": 183},
    {"name": "Neymar Jr",      "slug": "neymar",         "goals_career": 400, "height_cm": 175},
    {"name": "Kylian Mbappé",  "slug": "mbappe",         "goals_career": 280, "height_cm": 178},
    {"name": "Erling Haaland", "slug": "haaland",        "goals_career": 290, "height_cm": 194},
    {"name": "Robert Lewandowski","slug": "lewandowski", "goals_career": 620, "height_cm": 185},
    {"name": "Lamine Yamal",   "slug": "yamal",          "goals_career": 40,  "height_cm": 180},
    {"name": "Vinicius Jr",    "slug": "vinicius",       "goals_career": 130, "height_cm": 176},
]

ANIMALS = [
    {"name": "Guepardo",       "slug": "guepardo",       "speed_kmh": 112},
    {"name": "Pronghorn",      "slug": "pronghorn",      "speed_kmh": 98},
    {"name": "Ñu",             "slug": "gnu",            "speed_kmh": 80},
    {"name": "León",           "slug": "leon",           "speed_kmh": 80},
    {"name": "Caballo",        "slug": "caballo",        "speed_kmh": 88},
    {"name": "Tigre",          "slug": "tigre",          "speed_kmh": 65},
    {"name": "Oso pardo",      "slug": "oso-pardo",      "speed_kmh": 56},
    {"name": "Elefante",       "slug": "elefante",       "speed_kmh": 40},
    {"name": "Cocodrilo",      "slug": "cocodrilo",      "speed_kmh": 30},
    {"name": "Pingüino",       "slug": "pinguino",       "speed_kmh": 36},
]

TIMELINE_EVENTS = [
    # Historia global
    {"title": "Llegada de Cristóbal Colón a América",   "short_title": "Colón llega a América",     "event_date": "1492-10-12", "region": "global"},
    {"title": "Inicio de la Revolución Francesa",       "short_title": "Revolución Francesa",       "event_date": "1789-07-14", "region": "global"},
    {"title": "Fin de la Segunda Guerra Mundial",        "short_title": "Fin de la 2da Guerra Mundial","event_date": "1945-09-02", "region": "global"},
    {"title": "Llegada del hombre a la Luna",            "short_title": "Hombre en la Luna",         "event_date": "1969-07-20", "region": "global"},
    {"title": "Caída del Muro de Berlín",                "short_title": "Caída del Muro de Berlín",  "event_date": "1989-11-09", "region": "global"},
    {"title": "Primer vuelo de los hermanos Wright",     "short_title": "Primer vuelo en avión",     "event_date": "1903-12-17", "region": "global"},
    {"title": "Nacimiento de Internet (ARPANET)",        "short_title": "Nace Internet (ARPANET)",   "event_date": "1969-10-29", "region": "global"},
    {"title": "Se lanza el primer iPhone",               "short_title": "Nace el iPhone",            "event_date": "2007-06-29", "region": "global"},
    {"title": "Fundación de Google",                     "short_title": "Nace Google",               "event_date": "1998-09-04", "region": "global"},
    {"title": "Fundación de Facebook",                   "short_title": "Nace Facebook",             "event_date": "2004-02-04", "region": "global"},
    {"title": "Lanzamiento de YouTube",                  "short_title": "Nace YouTube",              "event_date": "2005-04-23", "region": "global"},
    {"title": "Fundación de Twitter (ahora X)",          "short_title": "Nace Twitter",              "event_date": "2006-03-21", "region": "global"},
    {"title": "Lanzamiento de TikTok",                   "short_title": "Nace TikTok",               "event_date": "2016-09-01", "region": "global"},
    {"title": "Inicio de la pandemia de COVID-19",       "short_title": "Inicio del COVID-19",       "event_date": "2020-03-11", "region": "global"},
    # Gaming
    {"title": "Lanzamiento de Minecraft",                "short_title": "Sale Minecraft",            "event_date": "2011-11-18", "region": "global"},
    {"title": "Lanzamiento de Fortnite (Battle Royale)", "short_title": "Sale Fortnite BR",          "event_date": "2017-09-26", "region": "global"},
    {"title": "Lanzamiento de Among Us",                 "short_title": "Sale Among Us",             "event_date": "2018-06-15", "region": "global"},
    {"title": "Se funda Roblox Corporation",             "short_title": "Nace Roblox",               "event_date": "2006-09-01", "region": "global"},
    {"title": "Sale Grand Theft Auto V",                 "short_title": "Sale GTA V",                "event_date": "2013-09-17", "region": "global"},
    {"title": "Primer campeonato mundial de Fortnite",   "short_title": "World Cup de Fortnite",     "event_date": "2019-07-28", "region": "global"},
    # Fútbol
    {"title": "Argentina gana el Mundial de Qatar 2022", "short_title": "Argentina campeón 2022",    "event_date": "2022-12-18", "region": "AR"},
    {"title": "Messi gana su 8vo Balón de Oro",         "short_title": "Messi: 8vo Balón de Oro",  "event_date": "2023-10-30", "region": "global"},
    {"title": "Brasil gana el Mundial de Corea-Japón",   "short_title": "Brasil campeón 2002",       "event_date": "2002-06-30", "region": "global"},
    {"title": "Diego Maradona: gol de la mano de dios", "short_title": "Gol de la mano de Dios",    "event_date": "1986-06-22", "region": "AR"},
    # Cultura pop / YouTube
    {"title": "Gangnam Style rompe récord en YouTube",   "short_title": "Gangnam Style viral",       "event_date": "2012-11-24", "region": "global"},
    {"title": "MrBeast supera los 100M de suscriptores", "short_title": "MrBeast: 100M subs",       "event_date": "2022-06-01", "region": "global"},
    {"title": "Se estrena Avengers: Endgame",            "short_title": "Sale Avengers: Endgame",   "event_date": "2019-04-26", "region": "global"},
    {"title": "Lanzamiento de Netflix en LATAM",         "short_title": "Netflix llega a LATAM",    "event_date": "2011-09-12", "region": "LATAM"},
]

GENERATORS = [
    {
        "slug": "timeline-gaming-global",
        "generator_type": "timeline_order",
        "config": {
            "n_events": 4,
            "question_text": "¿En qué orden ocurrieron estos eventos del mundo gaming?",
            "kid_safe_only": False,
        },
    },
    {
        "slug": "timeline-historia-global",
        "generator_type": "timeline_order",
        "config": {
            "n_events": 4,
            "question_text": "Ordená estos eventos históricos de más antiguo a más reciente",
            "kid_safe_only": False,
        },
    },
    {
        "slug": "higher-lower-youtubers-subs",
        "generator_type": "higher_lower",
        "config": {
            "allowed_entity_types": ["youtuber"],
            "attribute_slug": "subscribers",
            "attribute_name": "Suscriptores",
            "unit": "millones",
            "direction": "higher",
            "question_text": "¿Quién tiene más suscriptores en YouTube?",
        },
    },
    {
        "slug": "higher-lower-paises-poblacion",
        "generator_type": "higher_lower",
        "config": {
            "allowed_entity_types": ["country"],
            "attribute_slug": "population",
            "attribute_name": "Población",
            "unit": "millones de personas",
            "direction": "higher",
            "question_text": "¿Cuál de estos países tiene más población?",
        },
    },
    {
        "slug": "higher-lower-futbolistas-goles",
        "generator_type": "higher_lower",
        "config": {
            "allowed_entity_types": ["footballer"],
            "attribute_slug": "goals_career",
            "attribute_name": "Goles en carrera",
            "unit": "goles",
            "direction": "higher",
            "question_text": "¿Quién tiene más goles en su carrera?",
        },
    },
    {
        "slug": "higher-lower-animales-velocidad",
        "generator_type": "higher_lower",
        "config": {
            "allowed_entity_types": ["animal"],
            "attribute_slug": "speed_kmh",
            "attribute_name": "Velocidad máxima",
            "unit": "km/h",
            "direction": "higher",
            "question_text": "¿Cuál de estos animales es más rápido?",
        },
    },
    {
        "slug": "closest-number-youtubers-subs",
        "generator_type": "closest_number",
        "config": {
            "allowed_entity_types": ["youtuber"],
            "attribute_slug": "subscribers",
            "attribute_name": "Suscriptores",
            "unit": "millones",
        },
    },
    {
        "slug": "closest-number-paises-poblacion",
        "generator_type": "closest_number",
        "config": {
            "allowed_entity_types": ["country"],
            "attribute_slug": "population",
            "attribute_name": "Población",
            "unit": "millones de personas",
        },
    },
    {
        "slug": "ranking-paises-area",
        "generator_type": "ranking_order",
        "config": {
            "allowed_entity_types": ["country"],
            "attribute_slug": "area_km2",
            "attribute_name": "Superficie",
            "unit": "km²",
            "direction": "desc",
            "n_items": 4,
            "question_text": "Ordená estos países de mayor a menor superficie",
        },
    },
    {
        "slug": "ranking-juegos-ventas",
        "generator_type": "ranking_order",
        "config": {
            "allowed_entity_types": ["videogame"],
            "attribute_slug": "units_sold_m",
            "attribute_name": "Unidades vendidas",
            "unit": "millones",
            "direction": "desc",
            "n_items": 4,
            "question_text": "Ordená estos juegos de más a menos copias vendidas",
        },
    },
]


# ─── Seed ────────────────────────────────────────────────────────────────────

async def main():
    if not DB_URL:
        print("ERROR: DATABASE_URL no está configurada.")
        return

    conn = await asyncpg.connect(DB_URL, timeout=15)
    print("Conectado a la DB.")

    # ── Atributos ──────────────────────────────────────────────────────────
    attr_ids: dict[str, str] = {}
    for attr in ATTRIBUTES:
        existing = await conn.fetchrow(
            "SELECT id FROM knowledge_attributes WHERE slug = $1", attr["slug"]
        )
        if existing:
            attr_ids[attr["slug"]] = str(existing["id"])
            print(f"  attr ya existe: {attr['slug']}")
        else:
            aid = str(uuid.uuid4())
            await conn.execute(
                """
                INSERT INTO knowledge_attributes (id, slug, name, data_type, unit, metadata)
                VALUES ($1, $2, $3, $4, $5, '{}')
                """,
                aid, attr["slug"], attr["name"], attr["data_type"], attr.get("unit"),
            )
            attr_ids[attr["slug"]] = aid
            print(f"  attr creado: {attr['slug']}")

    async def upsert_entity(entity_type: str, name: str, slug: str, kid_friendly: bool, popularity: float, metadata: dict) -> str:
        existing = await conn.fetchrow(
            "SELECT id FROM knowledge_entities WHERE slug = $1", slug
        )
        if existing:
            return str(existing["id"])
        eid = str(uuid.uuid4())
        await conn.execute(
            """
            INSERT INTO knowledge_entities
              (id, entity_type, name, slug, kid_friendly, popularity_score, verified, language, metadata)
            VALUES ($1,$2,$3,$4,$5,$6,true,'es',$7)
            """,
            eid, entity_type, name, slug, kid_friendly, popularity,
            '{"image_url": null}',
        )
        return eid

    async def set_attr(entity_id: str, attr_slug: str, value_number: float):
        aid = attr_ids.get(attr_slug)
        if not aid:
            return
        existing = await conn.fetchrow(
            "SELECT id FROM knowledge_entity_attributes WHERE entity_id=$1 AND attribute_id=$2",
            entity_id, aid,
        )
        if existing:
            await conn.execute(
                "UPDATE knowledge_entity_attributes SET value_number=$1 WHERE id=$2",
                value_number, str(existing["id"]),
            )
        else:
            await conn.execute(
                """
                INSERT INTO knowledge_entity_attributes
                  (id, entity_id, attribute_id, value_number, verified, metadata)
                VALUES ($1,$2,$3,$4,true,'{}')
                """,
                str(uuid.uuid4()), entity_id, aid, value_number,
            )

    # ── YouTubers ──────────────────────────────────────────────────────────
    print("\nSeeding YouTubers...")
    for y in YOUTUBERS:
        eid = await upsert_entity("youtuber", y["name"], y["slug"], True, y["subscribers"] / 10, {})
        await set_attr(eid, "subscribers", y["subscribers"])
        print(f"  {y['name']} ({y['subscribers']}M subs)")

    # ── Países ─────────────────────────────────────────────────────────────
    print("\nSeeding Países...")
    for c in COUNTRIES:
        eid = await upsert_entity("country", c["name"], c["slug"], True, c["population"] / 100, {})
        await set_attr(eid, "population", c["population"])
        await set_attr(eid, "area_km2", c["area_km2"])
        print(f"  {c['name']} ({c['population']}M hab.)")

    # ── Videojuegos ────────────────────────────────────────────────────────
    print("\nSeeding Videojuegos...")
    for g in GAMES:
        eid = await upsert_entity("videogame", g["name"], g["slug"], True, g.get("units_sold_m", 0) / 10 + 5, {})
        await set_attr(eid, "release_year", g["release_year"])
        if g.get("units_sold_m"):
            await set_attr(eid, "units_sold_m", g["units_sold_m"])
        if g.get("metacritic"):
            await set_attr(eid, "metacritic", g["metacritic"])
        print(f"  {g['name']} ({g['release_year']})")

    # ── Futbolistas ────────────────────────────────────────────────────────
    print("\nSeeding Futbolistas...")
    for f in FOOTBALLERS:
        eid = await upsert_entity("footballer", f["name"], f["slug"], True, f["goals_career"] / 100, {})
        await set_attr(eid, "goals_career", f["goals_career"])
        await set_attr(eid, "height_cm", f["height_cm"])
        print(f"  {f['name']} ({f['goals_career']} goles)")

    # ── Animales ───────────────────────────────────────────────────────────
    print("\nSeeding Animales...")
    for a in ANIMALS:
        eid = await upsert_entity("animal", a["name"], a["slug"], True, a["speed_kmh"] / 10, {})
        await set_attr(eid, "speed_kmh", a["speed_kmh"])
        print(f"  {a['name']} ({a['speed_kmh']} km/h)")

    # ── Timeline events ────────────────────────────────────────────────────
    print("\nSeeding Timeline Events...")
    for ev in TIMELINE_EVENTS:
        existing = await conn.fetchrow(
            "SELECT id FROM timeline_events WHERE title = $1", ev["title"]
        )
        if existing:
            print(f"  ya existe: {ev['short_title']}")
            continue
        evid = str(uuid.uuid4())
        event_date = datetime.strptime(ev["event_date"], "%Y-%m-%d")
        await conn.execute(
            """
            INSERT INTO timeline_events
              (id, title, short_title, event_date, precision, region, language,
               kid_friendly, verified, metadata)
            VALUES ($1,$2,$3,$4,'year',$5,'es',true,true,'{}')
            """,
            evid, ev["title"], ev["short_title"], event_date, ev.get("region", "global"),
        )
        print(f"  {ev['short_title']} ({ev['event_date'][:4]})")

    # ── Generadores ────────────────────────────────────────────────────────
    print("\nSeeding Generadores procedurales...")
    import json
    for gen in GENERATORS:
        existing = await conn.fetchrow(
            "SELECT id FROM procedural_generators WHERE slug = $1", gen["slug"]
        )
        if existing:
            await conn.execute(
                "UPDATE procedural_generators SET config=$1, enabled=true WHERE slug=$2",
                json.dumps(gen["config"]), gen["slug"],
            )
            print(f"  actualizado: {gen['slug']}")
        else:
            gid = str(uuid.uuid4())
            await conn.execute(
                """
                INSERT INTO procedural_generators (id, slug, generator_type, enabled, config, metadata)
                VALUES ($1,$2,$3,true,$4,'{}')
                """,
                gid, gen["slug"], gen["generator_type"], json.dumps(gen["config"]),
            )
            print(f"  creado: {gen['slug']}")

    await conn.close()
    print("\n✓ Seed del motor procedural completado.")


if __name__ == "__main__":
    asyncio.run(main())
