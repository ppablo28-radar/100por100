"""
Motor de seeding para 100×100.
Fuente única de verdad para todos los datos de conocimiento.

Para agregar datos: editá las listas COUNTRIES, YOUTUBERS, VIDEOGAMES, etc.
Para correr: GET https://tu-backend.railway.app/admin/seed
"""
import json
import uuid
import asyncpg

# ─── Atributos ────────────────────────────────────────────────────────────────

ATTRIBUTES = {
    # slug: (nombre legible, tipo, unidad)
    "subscribers":        ("Suscriptores",       "integer", "millones"),
    "population":         ("Población",          "integer", "millones de personas"),
    "area_km2":           ("Superficie",          "float",   "km²"),
    "gdp_per_capita_usd": ("PIB per cápita",     "integer", "USD"),
    "life_expectancy":    ("Esperanza de vida",  "float",   "años"),
    "release_year":       ("Año de lanzamiento", "integer", "año"),
    "units_sold_m":       ("Unidades vendidas",  "float",   "millones"),
    "goals_career":       ("Goles en carrera",   "integer", "goles"),
    "height_cm":          ("Altura",             "integer", "cm"),
    "speed_kmh":          ("Velocidad máxima",   "float",   "km/h"),
    "metacritic":         ("Metacritic",         "integer", "puntos"),
    "diameter_km":        ("Diámetro",           "integer", "km"),
    "distance_sun_mkm":   ("Distancia al Sol",   "float",   "millones de km"),
    "moons_count":        ("Número de lunas",    "integer", "lunas"),
    "surface_temp_c":     ("Temperatura media",  "float",   "°C"),
    "market_value_m_eur": ("Valor de mercado",   "integer", "millones €"),
}

# ─── Países ───────────────────────────────────────────────────────────────────
# {slug, name, population (M), area_km2, gdp_per_capita_usd, life_expectancy}

COUNTRIES = [
    # ── Gigantes ──────────────────────────────────────────────────────────────
    {"slug": "china",          "name": "China",          "population": 1409,  "area_km2": 9596960,  "gdp_per_capita_usd": 13700, "life_expectancy": 78.3},
    {"slug": "india",          "name": "India",          "population": 1441,  "area_km2": 3287263,  "gdp_per_capita_usd": 2500,  "life_expectancy": 70.0},
    {"slug": "eeuu",           "name": "Estados Unidos", "population": 340,   "area_km2": 9833517,  "gdp_per_capita_usd": 82000, "life_expectancy": 78.5},
    {"slug": "indonesia",      "name": "Indonesia",      "population": 280,   "area_km2": 1904569,  "gdp_per_capita_usd": 5000,  "life_expectancy": 73.5},
    {"slug": "pakistan",       "name": "Pakistan",       "population": 240,   "area_km2": 881913,   "gdp_per_capita_usd": 1600,  "life_expectancy": 67.3},
    {"slug": "brasil",         "name": "Brasil",         "population": 218,   "area_km2": 8515767,  "gdp_per_capita_usd": 11000, "life_expectancy": 75.9},
    {"slug": "nigeria",        "name": "Nigeria",        "population": 225,   "area_km2": 923768,   "gdp_per_capita_usd": 2200,  "life_expectancy": 54.7},
    {"slug": "bangladesh",     "name": "Bangladesh",     "population": 175,   "area_km2": 147570,   "gdp_per_capita_usd": 2800,  "life_expectancy": 73.5},
    {"slug": "etiopia",        "name": "Etiopía",        "population": 130,   "area_km2": 1104300,  "gdp_per_capita_usd": 1000,  "life_expectancy": 66.0},
    {"slug": "mexico",         "name": "México",         "population": 130,   "area_km2": 1964375,  "gdp_per_capita_usd": 13000, "life_expectancy": 75.2},
    {"slug": "egipto",         "name": "Egipto",         "population": 110,   "area_km2": 1001450,  "gdp_per_capita_usd": 4000,  "life_expectancy": 72.0},
    {"slug": "filipinas",      "name": "Filipinas",      "population": 115,   "area_km2": 300000,   "gdp_per_capita_usd": 4000,  "life_expectancy": 71.8},
    # ── Europa ────────────────────────────────────────────────────────────────
    {"slug": "rusia",          "name": "Rusia",          "population": 143,   "area_km2": 17098242, "gdp_per_capita_usd": 12000, "life_expectancy": 73.2},
    {"slug": "alemania",       "name": "Alemania",       "population": 84,    "area_km2": 357114,   "gdp_per_capita_usd": 52000, "life_expectancy": 81.1},
    {"slug": "reino-unido",    "name": "Reino Unido",    "population": 68,    "area_km2": 243610,   "gdp_per_capita_usd": 47000, "life_expectancy": 81.3},
    {"slug": "francia",        "name": "Francia",        "population": 68,    "area_km2": 551695,   "gdp_per_capita_usd": 45000, "life_expectancy": 83.1},
    {"slug": "italia",         "name": "Italia",         "population": 59,    "area_km2": 301340,   "gdp_per_capita_usd": 36000, "life_expectancy": 83.1},
    {"slug": "espana",         "name": "España",         "population": 48,    "area_km2": 505990,   "gdp_per_capita_usd": 33000, "life_expectancy": 83.4},
    {"slug": "turquia",        "name": "Turquía",        "population": 85,    "area_km2": 783356,   "gdp_per_capita_usd": 13000, "life_expectancy": 77.7},
    {"slug": "polonia",        "name": "Polonia",        "population": 38,    "area_km2": 312696,   "gdp_per_capita_usd": 19000, "life_expectancy": 78.0},
    {"slug": "paises-bajos",   "name": "Países Bajos",  "population": 18,    "area_km2": 41543,    "gdp_per_capita_usd": 63000, "life_expectancy": 82.2},
    {"slug": "suecia",         "name": "Suecia",         "population": 11,    "area_km2": 450295,   "gdp_per_capita_usd": 62000, "life_expectancy": 83.0},
    {"slug": "noruega",        "name": "Noruega",        "population": 5.5,   "area_km2": 385207,   "gdp_per_capita_usd": 102000,"life_expectancy": 83.2},
    {"slug": "suiza",          "name": "Suiza",          "population": 8.8,   "area_km2": 41285,    "gdp_per_capita_usd": 105000,"life_expectancy": 83.9},
    {"slug": "grecia",         "name": "Grecia",         "population": 10,    "area_km2": 131957,   "gdp_per_capita_usd": 21000, "life_expectancy": 82.0},
    {"slug": "portugal",       "name": "Portugal",       "population": 10,    "area_km2": 92212,    "gdp_per_capita_usd": 25000, "life_expectancy": 81.9},
    # ── Asia / Oceanía ────────────────────────────────────────────────────────
    {"slug": "japon",          "name": "Japón",          "population": 123,   "area_km2": 377915,   "gdp_per_capita_usd": 34000, "life_expectancy": 84.3},
    {"slug": "corea-sur",      "name": "Corea del Sur",  "population": 52,    "area_km2": 100210,   "gdp_per_capita_usd": 35000, "life_expectancy": 83.6},
    {"slug": "vietnam",        "name": "Vietnam",        "population": 98,    "area_km2": 331212,   "gdp_per_capita_usd": 4200,  "life_expectancy": 75.4},
    {"slug": "tailandia",      "name": "Tailandia",      "population": 71,    "area_km2": 513120,   "gdp_per_capita_usd": 7300,  "life_expectancy": 76.0},
    {"slug": "canada",         "name": "Canadá",         "population": 40,    "area_km2": 9984670,  "gdp_per_capita_usd": 52000, "life_expectancy": 82.3},
    {"slug": "australia",      "name": "Australia",      "population": 26.7,  "area_km2": 7692024,  "gdp_per_capita_usd": 65000, "life_expectancy": 83.4},
    {"slug": "arabia-saudita", "name": "Arabia Saudita", "population": 36,    "area_km2": 2149690,  "gdp_per_capita_usd": 29000, "life_expectancy": 77.6},
    {"slug": "iran",           "name": "Iran",           "population": 88,    "area_km2": 1648195,  "gdp_per_capita_usd": 7000,  "life_expectancy": 75.1},
    # ── África ────────────────────────────────────────────────────────────────
    {"slug": "sudafrica",      "name": "Sudáfrica",      "population": 60,    "area_km2": 1219090,  "gdp_per_capita_usd": 7000,  "life_expectancy": 64.0},
    # ── América Latina ────────────────────────────────────────────────────────
    {"slug": "argentina",      "name": "Argentina",      "population": 46,    "area_km2": 2780400,  "gdp_per_capita_usd": 13000, "life_expectancy": 77.0},
    {"slug": "colombia",       "name": "Colombia",       "population": 52,    "area_km2": 1141748,  "gdp_per_capita_usd": 7000,  "life_expectancy": 76.9},
    {"slug": "chile",          "name": "Chile",          "population": 20,    "area_km2": 756102,   "gdp_per_capita_usd": 16000, "life_expectancy": 80.0},
    {"slug": "peru",           "name": "Perú",           "population": 34,    "area_km2": 1285216,  "gdp_per_capita_usd": 7000,  "life_expectancy": 73.2},
    {"slug": "venezuela",      "name": "Venezuela",      "population": 29,    "area_km2": 912050,   "gdp_per_capita_usd": 3000,  "life_expectancy": 72.7},
    {"slug": "ecuador",        "name": "Ecuador",        "population": 18,    "area_km2": 283561,   "gdp_per_capita_usd": 6000,  "life_expectancy": 77.3},
    {"slug": "bolivia",        "name": "Bolivia",        "population": 12,    "area_km2": 1098581,  "gdp_per_capita_usd": 3700,  "life_expectancy": 70.5},
    {"slug": "paraguay",       "name": "Paraguay",       "population": 7.5,   "area_km2": 406752,   "gdp_per_capita_usd": 5800,  "life_expectancy": 74.3},
    {"slug": "uruguay",        "name": "Uruguay",        "population": 3.4,   "area_km2": 176215,   "gdp_per_capita_usd": 22000, "life_expectancy": 77.8},
    {"slug": "cuba",           "name": "Cuba",           "population": 11,    "area_km2": 109884,   "gdp_per_capita_usd": 9000,  "life_expectancy": 78.8},
]

# ─── YouTubers ────────────────────────────────────────────────────────────────
# {slug, name, subscribers (millones)}

YOUTUBERS = [
    # ── Globales ──────────────────────────────────────────────────────────────
    {"slug": "mrbeast",         "name": "MrBeast",         "subscribers": 350},
    {"slug": "t-series",        "name": "T-Series",        "subscribers": 285},
    {"slug": "cocomelon",       "name": "Cocomelon",       "subscribers": 185},
    {"slug": "set-india",       "name": "SET India",       "subscribers": 175},
    {"slug": "kids-diana-show", "name": "Kids Diana Show", "subscribers": 128},
    {"slug": "vlad-y-niki",    "name": "Vlad y Niki",     "subscribers": 120},
    {"slug": "like-nastya",     "name": "Like Nastya",     "subscribers": 123},
    {"slug": "pewdiepie",       "name": "PewDiePie",       "subscribers": 111},
    {"slug": "dude-perfect",    "name": "Dude Perfect",    "subscribers": 60},
    {"slug": "ryans-world",     "name": "Ryan's World",    "subscribers": 37},
    {"slug": "markiplier",      "name": "Markiplier",      "subscribers": 38},
    {"slug": "sssniperw0lf",    "name": "SSSniperWolf",    "subscribers": 35},
    {"slug": "jacksepticeye",   "name": "Jacksepticeye",   "subscribers": 30},
    {"slug": "vanoss-gaming",   "name": "VanossGaming",    "subscribers": 25},
    # ── Habla hispana ─────────────────────────────────────────────────────────
    {"slug": "holasoy-german",  "name": "HolaSoyGerman",   "subscribers": 47},
    {"slug": "juega-german",    "name": "JuegaGerman",     "subscribers": 46},
    {"slug": "fernanfloo",      "name": "Fernanfloo",      "subscribers": 45},
    {"slug": "elrubius",        "name": "ElRubius",        "subscribers": 40},
    {"slug": "luisito-comunica","name": "Luisito Comunica","subscribers": 40},
    {"slug": "mikecrack",       "name": "Mikecrack",       "subscribers": 29},
    {"slug": "vegetta777",      "name": "Vegetta777",      "subscribers": 33},
    {"slug": "auronplay",       "name": "Auronplay",       "subscribers": 30},
    {"slug": "thegrefg",        "name": "TheGrefg",        "subscribers": 18},
    {"slug": "willyrex",        "name": "Willyrex",        "subscribers": 17},
    {"slug": "lyna-vallejos",   "name": "Lyna Vallejos",   "subscribers": 12},
    {"slug": "ibai",            "name": "Ibai",            "subscribers": 13},
    {"slug": "spreen",          "name": "Spreen",          "subscribers": 13},
    {"slug": "rivers",          "name": "Rivers",          "subscribers": 5},
    {"slug": "wetzel",          "name": "Wetzel",          "subscribers": 6},
    {"slug": "juansguarnizo",   "name": "Juansguarnizo",   "subscribers": 9},
    {"slug": "quackity",        "name": "Quackity",        "subscribers": 7},
    {"slug": "dsimphony",       "name": "DSimphony",       "subscribers": 7},
    {"slug": "ari-gameplays",   "name": "Ari Gameplays",   "subscribers": 5},
    {"slug": "coscu",           "name": "Coscu",           "subscribers": 3.5},
    {"slug": "la-divaza",       "name": "La Divaza",       "subscribers": 4},
    {"slug": "nategentile",     "name": "NateGentile",     "subscribers": 3},
]

# ─── Videojuegos ──────────────────────────────────────────────────────────────
# {slug, name, release_year, units_sold_m (None si no aplica), metacritic}

VIDEOGAMES = [
    {"slug": "minecraft",        "name": "Minecraft",               "release_year": 2011, "units_sold_m": 300,  "metacritic": 93},
    {"slug": "gta-v",            "name": "GTA V",                   "release_year": 2013, "units_sold_m": 200,  "metacritic": 97},
    {"slug": "tetris",           "name": "Tetris",                  "release_year": 1984, "units_sold_m": 520,  "metacritic": 92},
    {"slug": "super-mario-bros", "name": "Super Mario Bros",        "release_year": 1985, "units_sold_m": 58,   "metacritic": None},
    {"slug": "pokemon-rojo-azul","name": "Pokémon Rojo/Azul",       "release_year": 1996, "units_sold_m": 31,   "metacritic": None},
    {"slug": "the-last-of-us",   "name": "The Last of Us",          "release_year": 2013, "units_sold_m": 20,   "metacritic": 95},
    {"slug": "zelda-botw",       "name": "Zelda: Breath of the Wild","release_year": 2017, "units_sold_m": 32,  "metacritic": 97},
    {"slug": "cod-mw",           "name": "Call of Duty: MW",        "release_year": 2007, "units_sold_m": 30,   "metacritic": 94},
    {"slug": "fifa-24",          "name": "FIFA 24",                 "release_year": 2023, "units_sold_m": 10,   "metacritic": 73},
    {"slug": "fortnite",         "name": "Fortnite",                "release_year": 2017, "units_sold_m": None, "metacritic": 81},
    {"slug": "roblox",           "name": "Roblox",                  "release_year": 2006, "units_sold_m": None, "metacritic": None},
    {"slug": "among-us",         "name": "Among Us",                "release_year": 2018, "units_sold_m": None, "metacritic": 85},
    {"slug": "wii-sports",       "name": "Wii Sports",              "release_year": 2006, "units_sold_m": 83,   "metacritic": 76},
    {"slug": "mario-kart-8",     "name": "Mario Kart 8 Deluxe",     "release_year": 2017, "units_sold_m": 62,   "metacritic": 92},
    {"slug": "animal-crossing",  "name": "Animal Crossing: NH",     "release_year": 2020, "units_sold_m": 45,   "metacritic": 90},
    {"slug": "red-dead-2",       "name": "Red Dead Redemption 2",   "release_year": 2018, "units_sold_m": 61,   "metacritic": 97},
    {"slug": "cyberpunk-2077",   "name": "Cyberpunk 2077",          "release_year": 2020, "units_sold_m": 25,   "metacritic": 86},
    {"slug": "elden-ring",       "name": "Elden Ring",              "release_year": 2022, "units_sold_m": 25,   "metacritic": 96},
]

# ─── Planetas ────────────────────────────────────────────────────────────────
# {slug, name, diameter_km, distance_sun_mkm, moons_count, surface_temp_c}

PLANETS = [
    {"slug": "mercurio", "name": "Mercurio", "diameter_km": 4879,   "distance_sun_mkm": 57.9,   "moons_count": 0,   "surface_temp_c": 167},
    {"slug": "venus",    "name": "Venus",    "diameter_km": 12104,  "distance_sun_mkm": 108.2,  "moons_count": 0,   "surface_temp_c": 464},
    {"slug": "tierra",   "name": "Tierra",   "diameter_km": 12742,  "distance_sun_mkm": 149.6,  "moons_count": 1,   "surface_temp_c": 15},
    {"slug": "marte",    "name": "Marte",    "diameter_km": 6779,   "distance_sun_mkm": 227.9,  "moons_count": 2,   "surface_temp_c": -60},
    {"slug": "jupiter",  "name": "Júpiter",  "diameter_km": 139820, "distance_sun_mkm": 778.5,  "moons_count": 95,  "surface_temp_c": -110},
    {"slug": "saturno",  "name": "Saturno",  "diameter_km": 116460, "distance_sun_mkm": 1432.0, "moons_count": 146, "surface_temp_c": -140},
    {"slug": "urano",    "name": "Urano",    "diameter_km": 50724,  "distance_sun_mkm": 2867.0, "moons_count": 28,  "surface_temp_c": -195},
    {"slug": "neptuno",  "name": "Neptuno",  "diameter_km": 49244,  "distance_sun_mkm": 4515.0, "moons_count": 16,  "surface_temp_c": -200},
]

# ─── Futbolistas ──────────────────────────────────────────────────────────────
# {slug, name, goals_career, height_cm, market_value_m_eur}

FOOTBALLERS = [
    {"slug": "messi",        "name": "Lionel Messi",       "goals_career": 820, "height_cm": 169, "market_value_m_eur": 25},
    {"slug": "cristiano",    "name": "Cristiano Ronaldo",  "goals_career": 890, "height_cm": 187, "market_value_m_eur": 15},
    {"slug": "pele",         "name": "Pelé",               "goals_career": 767, "height_cm": 173, "market_value_m_eur": None},
    {"slug": "ronaldo-r9",   "name": "Ronaldo Nazário",    "goals_career": 414, "height_cm": 183, "market_value_m_eur": None},
    {"slug": "maradona",     "name": "Diego Maradona",     "goals_career": 312, "height_cm": 165, "market_value_m_eur": None},
    {"slug": "ronaldinho",   "name": "Ronaldinho",         "goals_career": 306, "height_cm": 181, "market_value_m_eur": None},
    {"slug": "neymar",       "name": "Neymar Jr",          "goals_career": 400, "height_cm": 175, "market_value_m_eur": 40},
    {"slug": "mbappe",       "name": "Kylian Mbappé",      "goals_career": 290, "height_cm": 178, "market_value_m_eur": 200},
    {"slug": "haaland",      "name": "Erling Haaland",     "goals_career": 290, "height_cm": 194, "market_value_m_eur": 200},
    {"slug": "lewandowski",  "name": "Robert Lewandowski", "goals_career": 630, "height_cm": 185, "market_value_m_eur": 15},
    {"slug": "benzema",      "name": "Karim Benzema",      "goals_career": 424, "height_cm": 185, "market_value_m_eur": 20},
    {"slug": "zlatan",       "name": "Zlatan Ibrahimovic", "goals_career": 570, "height_cm": 195, "market_value_m_eur": None},
    {"slug": "kane",         "name": "Harry Kane",         "goals_career": 290, "height_cm": 188, "market_value_m_eur": 100},
    {"slug": "vinicius",     "name": "Vinicius Jr",        "goals_career": 130, "height_cm": 176, "market_value_m_eur": 180},
    {"slug": "yamal",        "name": "Lamine Yamal",       "goals_career": 40,  "height_cm": 180, "market_value_m_eur": 180},
    {"slug": "lautaro",      "name": "Lautaro Martínez",   "goals_career": 150, "height_cm": 174, "market_value_m_eur": 110},
    {"slug": "suarez",       "name": "Luis Suárez",        "goals_career": 450, "height_cm": 182, "market_value_m_eur": None},
    {"slug": "falcao",       "name": "Radamel Falcao",     "goals_career": 350, "height_cm": 177, "market_value_m_eur": None},
    {"slug": "james-r",      "name": "James Rodríguez",    "goals_career": 160, "height_cm": 180, "market_value_m_eur": 8},
    {"slug": "de-bruyne",    "name": "Kevin De Bruyne",    "goals_career": 120, "height_cm": 181, "market_value_m_eur": 60},
]

# ─── Generadores ──────────────────────────────────────────────────────────────

GENERATORS = [
    # Países · Población
    {"slug": "higher-lower-paises-poblacion", "type": "higher_lower", "config": {
        "allowed_entity_types": ["country"], "attribute_slug": "population",
        "attribute_name": "Población", "unit": "millones de personas",
        "direction": "higher", "min_options": 2, "max_options": 10,
        "question_text": "¿Cuál de estos países tiene más población?"}},
    {"slug": "ranking-paises-poblacion", "type": "ranking_order", "config": {
        "allowed_entity_types": ["country"], "attribute_slug": "population",
        "attribute_name": "Población", "unit": "millones de personas",
        "direction": "desc", "min_items": 2, "max_items": 6,
        "question_text": "Ordená estos países de mayor a menor población"}},
    {"slug": "closest-number-paises-poblacion", "type": "closest_number", "config": {
        "allowed_entity_types": ["country"], "attribute_slug": "population",
        "attribute_name": "Población", "unit": "millones de personas",
        "question_text": "¿Cuántos millones de habitantes tiene",
        "min_options": 4, "max_options": 10}},
    # Países · Superficie
    {"slug": "higher-lower-paises-area", "type": "higher_lower", "config": {
        "allowed_entity_types": ["country"], "attribute_slug": "area_km2",
        "attribute_name": "Superficie", "unit": "km²",
        "direction": "higher", "min_options": 2, "max_options": 10,
        "question_text": "¿Cuál de estos países tiene más superficie?"}},
    {"slug": "ranking-paises-area", "type": "ranking_order", "config": {
        "allowed_entity_types": ["country"], "attribute_slug": "area_km2",
        "attribute_name": "Superficie", "unit": "km²",
        "direction": "desc", "min_items": 2, "max_items": 6,
        "question_text": "Ordená estos países de mayor a menor superficie"}},
    {"slug": "closest-number-paises-area", "type": "closest_number", "config": {
        "allowed_entity_types": ["country"], "attribute_slug": "area_km2",
        "attribute_name": "Superficie", "unit": "km²",
        "question_text": "¿Cuántos km² tiene",
        "min_options": 4, "max_options": 10}},
    # Países · PIB per cápita
    {"slug": "higher-lower-paises-pib", "type": "higher_lower", "config": {
        "allowed_entity_types": ["country"], "attribute_slug": "gdp_per_capita_usd",
        "attribute_name": "PIB per cápita", "unit": "USD",
        "direction": "higher", "min_options": 2, "max_options": 8,
        "question_text": "¿Cuál de estos países tiene mayor PIB per cápita?"}},
    {"slug": "ranking-paises-pib", "type": "ranking_order", "config": {
        "allowed_entity_types": ["country"], "attribute_slug": "gdp_per_capita_usd",
        "attribute_name": "PIB per cápita", "unit": "USD",
        "direction": "desc", "min_items": 2, "max_items": 6,
        "question_text": "Ordená estos países de mayor a menor PIB per cápita"}},
    {"slug": "closest-number-paises-pib", "type": "closest_number", "config": {
        "allowed_entity_types": ["country"], "attribute_slug": "gdp_per_capita_usd",
        "attribute_name": "PIB per cápita", "unit": "USD",
        "question_text": "¿Cuál es el PIB per cápita de",
        "min_options": 4, "max_options": 8}},
    # Países · Esperanza de vida
    {"slug": "higher-lower-paises-vida", "type": "higher_lower", "config": {
        "allowed_entity_types": ["country"], "attribute_slug": "life_expectancy",
        "attribute_name": "Esperanza de vida", "unit": "años",
        "direction": "higher", "min_options": 2, "max_options": 8,
        "question_text": "¿En cuál de estos países la gente vive más años?"}},
    {"slug": "ranking-paises-vida", "type": "ranking_order", "config": {
        "allowed_entity_types": ["country"], "attribute_slug": "life_expectancy",
        "attribute_name": "Esperanza de vida", "unit": "años",
        "direction": "desc", "min_items": 2, "max_items": 6,
        "question_text": "Ordená estos países de mayor a menor esperanza de vida"}},
    {"slug": "closest-number-paises-vida", "type": "closest_number", "config": {
        "allowed_entity_types": ["country"], "attribute_slug": "life_expectancy",
        "attribute_name": "Esperanza de vida", "unit": "años",
        "question_text": "¿Cuántos años de esperanza de vida tiene",
        "min_options": 4, "max_options": 8}},
    # YouTubers · Suscriptores
    {"slug": "higher-lower-youtubers-subs", "type": "higher_lower", "config": {
        "allowed_entity_types": ["youtuber"], "attribute_slug": "subscribers",
        "attribute_name": "Suscriptores", "unit": "millones",
        "direction": "higher", "min_options": 2, "max_options": 10,
        "question_text": "¿Quién tiene más suscriptores en YouTube?"}},
    {"slug": "ranking-youtubers-subs", "type": "ranking_order", "config": {
        "allowed_entity_types": ["youtuber"], "attribute_slug": "subscribers",
        "attribute_name": "Suscriptores", "unit": "millones",
        "direction": "desc", "min_items": 2, "max_items": 6,
        "question_text": "Ordená estos YouTubers de mayor a menor suscriptores"}},
    {"slug": "closest-number-youtubers-subs", "type": "closest_number", "config": {
        "allowed_entity_types": ["youtuber"], "attribute_slug": "subscribers",
        "attribute_name": "Suscriptores", "unit": "millones",
        "question_text": "¿Cuántos millones de suscriptores tiene",
        "min_options": 4, "max_options": 10}},
    # Videojuegos · Año
    {"slug": "higher-lower-games-year", "type": "higher_lower", "config": {
        "allowed_entity_types": ["videogame"], "attribute_slug": "release_year",
        "attribute_name": "Año de lanzamiento", "unit": "",
        "direction": "higher", "min_options": 2, "max_options": 8,
        "question_text": "¿Cuál de estos juegos salió más recientemente?"}},
    {"slug": "ranking-games-year", "type": "ranking_order", "config": {
        "allowed_entity_types": ["videogame"], "attribute_slug": "release_year",
        "attribute_name": "Año de lanzamiento", "unit": "",
        "direction": "asc", "min_items": 2, "max_items": 6,
        "question_text": "Ordená estos juegos de más antiguo a más reciente"}},
    {"slug": "closest-number-games-year", "type": "closest_number", "config": {
        "allowed_entity_types": ["videogame"], "attribute_slug": "release_year",
        "attribute_name": "Año de lanzamiento", "unit": "",
        "question_text": "¿En qué año salió",
        "min_options": 4, "max_options": 8}},
    # Videojuegos · Ventas
    {"slug": "higher-lower-games-sales", "type": "higher_lower", "config": {
        "allowed_entity_types": ["videogame"], "attribute_slug": "units_sold_m",
        "attribute_name": "Copias vendidas", "unit": "millones",
        "direction": "higher", "min_options": 2, "max_options": 8,
        "question_text": "¿Cuál de estos juegos vendió más copias?"}},
    {"slug": "ranking-games-sales", "type": "ranking_order", "config": {
        "allowed_entity_types": ["videogame"], "attribute_slug": "units_sold_m",
        "attribute_name": "Copias vendidas", "unit": "millones",
        "direction": "desc", "min_items": 2, "max_items": 6,
        "question_text": "Ordená estos juegos de más a menos copias vendidas"}},
    {"slug": "closest-number-games-sales", "type": "closest_number", "config": {
        "allowed_entity_types": ["videogame"], "attribute_slug": "units_sold_m",
        "attribute_name": "Copias vendidas", "unit": "millones",
        "question_text": "¿Cuántos millones de copias vendió",
        "min_options": 4, "max_options": 8}},
    # Planetas · Diámetro
    {"slug": "higher-lower-planetas-diametro", "type": "higher_lower", "config": {
        "allowed_entity_types": ["planet"], "attribute_slug": "diameter_km",
        "attribute_name": "Diámetro", "unit": "km",
        "direction": "higher", "min_options": 2, "max_options": 8,
        "question_text": "¿Cuál de estos planetas es más grande?"}},
    {"slug": "ranking-planetas-diametro", "type": "ranking_order", "config": {
        "allowed_entity_types": ["planet"], "attribute_slug": "diameter_km",
        "attribute_name": "Diámetro", "unit": "km",
        "direction": "desc", "min_items": 2, "max_items": 8,
        "question_text": "Ordená estos planetas de mayor a menor tamaño"}},
    {"slug": "closest-number-planetas-diametro", "type": "closest_number", "config": {
        "allowed_entity_types": ["planet"], "attribute_slug": "diameter_km",
        "attribute_name": "Diámetro", "unit": "km",
        "question_text": "¿Cuántos km de diámetro tiene",
        "min_options": 4, "max_options": 8}},
    # Planetas · Distancia al Sol
    {"slug": "higher-lower-planetas-distancia", "type": "higher_lower", "config": {
        "allowed_entity_types": ["planet"], "attribute_slug": "distance_sun_mkm",
        "attribute_name": "Distancia al Sol", "unit": "millones de km",
        "direction": "higher", "min_options": 2, "max_options": 8,
        "question_text": "¿Cuál de estos planetas está más lejos del Sol?"}},
    {"slug": "ranking-planetas-distancia", "type": "ranking_order", "config": {
        "allowed_entity_types": ["planet"], "attribute_slug": "distance_sun_mkm",
        "attribute_name": "Distancia al Sol", "unit": "millones de km",
        "direction": "asc", "min_items": 2, "max_items": 8,
        "question_text": "Ordená estos planetas de más cercano a más lejano del Sol"}},
    {"slug": "closest-number-planetas-distancia", "type": "closest_number", "config": {
        "allowed_entity_types": ["planet"], "attribute_slug": "distance_sun_mkm",
        "attribute_name": "Distancia al Sol", "unit": "millones de km",
        "question_text": "¿A cuántos millones de km del Sol está",
        "min_options": 4, "max_options": 8}},
    # Futbolistas · Goles en carrera
    {"slug": "higher-lower-futbolistas-goles", "type": "higher_lower", "config": {
        "allowed_entity_types": ["footballer"], "attribute_slug": "goals_career",
        "attribute_name": "Goles en carrera", "unit": "goles",
        "direction": "higher", "min_options": 2, "max_options": 8,
        "question_text": "¿Quién tiene más goles en su carrera?"}},
    {"slug": "ranking-futbolistas-goles", "type": "ranking_order", "config": {
        "allowed_entity_types": ["footballer"], "attribute_slug": "goals_career",
        "attribute_name": "Goles en carrera", "unit": "goles",
        "direction": "desc", "min_items": 2, "max_items": 6,
        "question_text": "Ordená estos futbolistas de más a menos goles en carrera"}},
    {"slug": "closest-number-futbolistas-goles", "type": "closest_number", "config": {
        "allowed_entity_types": ["footballer"], "attribute_slug": "goals_career",
        "attribute_name": "Goles en carrera", "unit": "goles",
        "question_text": "¿Cuántos goles hizo en su carrera",
        "min_options": 4, "max_options": 8}},
    # Futbolistas · Altura
    {"slug": "higher-lower-futbolistas-altura", "type": "higher_lower", "config": {
        "allowed_entity_types": ["footballer"], "attribute_slug": "height_cm",
        "attribute_name": "Altura", "unit": "cm",
        "direction": "higher", "min_options": 2, "max_options": 8,
        "question_text": "¿Cuál de estos futbolistas es más alto?"}},
    {"slug": "ranking-futbolistas-altura", "type": "ranking_order", "config": {
        "allowed_entity_types": ["footballer"], "attribute_slug": "height_cm",
        "attribute_name": "Altura", "unit": "cm",
        "direction": "desc", "min_items": 2, "max_items": 6,
        "question_text": "Ordená estos futbolistas de mayor a menor altura"}},
    {"slug": "closest-number-futbolistas-altura", "type": "closest_number", "config": {
        "allowed_entity_types": ["footballer"], "attribute_slug": "height_cm",
        "attribute_name": "Altura", "unit": "cm",
        "question_text": "¿Cuántos cm mide",
        "min_options": 4, "max_options": 8}},
]

# ─── Funciones de seed ────────────────────────────────────────────────────────

async def seed_all(db_url: str) -> dict:
    conn = await asyncpg.connect(db_url, timeout=15)
    log = []

    try:
        # 1. Atributos
        attr_ids = {}
        for slug, (name, dtype, unit) in ATTRIBUTES.items():
            row = await conn.fetchrow("SELECT id FROM knowledge_attributes WHERE slug=$1", slug)
            if row:
                attr_ids[slug] = str(row["id"])
            else:
                aid = str(uuid.uuid4())
                await conn.execute(
                    "INSERT INTO knowledge_attributes(id,slug,name,data_type,unit,metadata) VALUES($1,$2,$3,$4,$5,'{}')",
                    aid, slug, name, dtype, unit
                )
                attr_ids[slug] = aid
                log.append(f"+ attr: {slug}")

        # 2. Países
        for c in COUNTRIES:
            await _upsert_entity(conn, "country", c["slug"], c["name"], log)
            eid = await _get_entity_id(conn, c["slug"])
            for attr_slug in ("population", "area_km2", "gdp_per_capita_usd", "life_expectancy"):
                val = c.get(attr_slug)
                if val is not None and attr_slug in attr_ids:
                    await _set_attr(conn, eid, attr_ids[attr_slug], float(val))

        log.append(f"✓ {len(COUNTRIES)} países procesados")

        # 3. YouTubers
        for y in YOUTUBERS:
            await _upsert_entity(conn, "youtuber", y["slug"], y["name"], log)
            eid = await _get_entity_id(conn, y["slug"])
            if "subscribers" in attr_ids:
                await _set_attr(conn, eid, attr_ids["subscribers"], float(y["subscribers"]))

        log.append(f"✓ {len(YOUTUBERS)} YouTubers procesados")

        # 4. Videojuegos
        for g in VIDEOGAMES:
            await _upsert_entity(conn, "videogame", g["slug"], g["name"], log)
            eid = await _get_entity_id(conn, g["slug"])
            for attr_slug in ("release_year", "units_sold_m", "metacritic"):
                val = g.get(attr_slug)
                if val is not None and attr_slug in attr_ids:
                    await _set_attr(conn, eid, attr_ids[attr_slug], float(val))

        log.append(f"✓ {len(VIDEOGAMES)} videojuegos procesados")

        # 5. Planetas
        for p in PLANETS:
            await _upsert_entity(conn, "planet", p["slug"], p["name"], log)
            eid = await _get_entity_id(conn, p["slug"])
            for attr_slug in ("diameter_km", "distance_sun_mkm", "moons_count", "surface_temp_c"):
                val = p.get(attr_slug)
                if val is not None and attr_slug in attr_ids:
                    await _set_attr(conn, eid, attr_ids[attr_slug], float(val))

        log.append(f"✓ {len(PLANETS)} planetas procesados")

        # 6. Futbolistas
        for f in FOOTBALLERS:
            await _upsert_entity(conn, "footballer", f["slug"], f["name"], log)
            eid = await _get_entity_id(conn, f["slug"])
            for attr_slug in ("goals_career", "height_cm", "market_value_m_eur"):
                val = f.get(attr_slug)
                if val is not None and attr_slug in attr_ids:
                    await _set_attr(conn, eid, attr_ids[attr_slug], float(val))

        log.append(f"✓ {len(FOOTBALLERS)} futbolistas procesados")

        # 7. Generadores
        for gen in GENERATORS:
            row = await conn.fetchrow(
                "SELECT id FROM procedural_generators WHERE slug=$1", gen["slug"]
            )
            cfg = json.dumps(gen["config"])
            if row:
                await conn.execute(
                    "UPDATE procedural_generators SET config=$1, generator_type=$2, enabled=true WHERE slug=$3",
                    cfg, gen["type"], gen["slug"]
                )
            else:
                await conn.execute(
                    "INSERT INTO procedural_generators(id,slug,generator_type,enabled,config,metadata) VALUES($1,$2,$3,true,$4,'{}')",
                    str(uuid.uuid4()), gen["slug"], gen["type"], cfg
                )
                log.append(f"+ generator: {gen['slug']}")

        log.append(f"✓ {len(GENERATORS)} generadores procesados")

    finally:
        await conn.close()

    return {"ok": True, "log": log}


async def _get_entity_id(conn, slug: str) -> str:
    row = await conn.fetchrow("SELECT id FROM knowledge_entities WHERE slug=$1", slug)
    return str(row["id"])


async def _upsert_entity(conn, entity_type: str, slug: str, name: str, log: list):
    row = await conn.fetchrow("SELECT id FROM knowledge_entities WHERE slug=$1", slug)
    if not row:
        await conn.execute(
            "INSERT INTO knowledge_entities(id,entity_type,name,slug,kid_friendly,popularity_score,verified,language,metadata) "
            "VALUES($1,$2,$3,$4,true,5.0,true,'es','{\"image_url\":null}')",
            str(uuid.uuid4()), entity_type, name, slug
        )
        log.append(f"+ {entity_type}: {name}")
    else:
        await conn.execute(
            "UPDATE knowledge_entities SET name=$1 WHERE slug=$2", name, slug
        )


async def _set_attr(conn, entity_id: str, attribute_id: str, value: float):
    row = await conn.fetchrow(
        "SELECT id FROM knowledge_entity_attributes WHERE entity_id=$1 AND attribute_id=$2",
        entity_id, attribute_id
    )
    if row:
        await conn.execute(
            "UPDATE knowledge_entity_attributes SET value_number=$1 WHERE id=$2",
            value, str(row["id"])
        )
    else:
        await conn.execute(
            "INSERT INTO knowledge_entity_attributes(id,entity_id,attribute_id,value_number,verified,metadata) "
            "VALUES($1,$2,$3,$4,true,'{}')",
            str(uuid.uuid4()), entity_id, attribute_id, value
        )
