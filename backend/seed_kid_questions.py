"""
200 preguntas para jóvenes de 11-14 años.
Categorías: youtubers/streamers, gaming, anime, series, música, ciencia, deportes, internet.
Uso: python seed_kid_questions.py > kid_questions.sql
"""
import re
import uuid

QUESTIONS = [
    # ── YOUTUBERS / STREAMERS ──────────────────────────────────────────────
    {"q": "¿Cuántos suscriptores tiene MrBeast aproximadamente?", "o": ["Más de 100 millones", "Más de 200 millones", "Más de 300 millones", "Más de 500 millones"], "c": 2},
    {"q": "¿De qué país es el streamer Ibai Llanos?", "o": ["México", "Argentina", "Colombia", "España"], "c": 3},
    {"q": "¿Cuántos años tenía MrBeast cuando empezó su canal de YouTube?", "o": ["10 años", "11 años", "12 años", "13 años"], "c": 3},
    {"q": "¿Cómo se llama el streamer argentino famoso por Minecraft?", "o": ["Coscu", "Spreen", "Gonki", "Zuero"], "c": 1},
    {"q": "¿Qué recreó MrBeast en la vida real?", "o": ["Los Juegos del Hambre", "Squid Game", "Among Us real", "Roblox real"], "c": 1},
    {"q": "¿Cuánto ganó el ganador del Squid Game real de MrBeast?", "o": ["$100,000", "$250,000", "$456,000", "$1,000,000"], "c": 2},
    {"q": "¿Cómo se llama el evento de boxeo entre influencers que organiza Ibai?", "o": ["La Copa del Ring", "La Velada del Año", "El Gran Combate", "Influencer Fight"], "c": 1},
    {"q": "¿Cuál es el nombre real de El Rubius?", "o": ["Rubén Doblas", "Rubén García", "Roberto Rubia", "Rodrigo López"], "c": 0},
    {"q": "¿De qué país es el youtuber Vegetta777?", "o": ["México", "Argentina", "España", "Colombia"], "c": 2},
    {"q": "¿De qué país es Luisito Comunica?", "o": ["Colombia", "México", "Argentina", "Venezuela"], "c": 1},
    {"q": "¿De qué país es el creador de contenido Spreen?", "o": ["Colombia", "México", "España", "Argentina"], "c": 3},
    {"q": "¿Cómo se llama el equipo de esports de Ibai y Gerard Piqué?", "o": ["Team Heretics", "Cloud9", "KOI", "NAVI"], "c": 2},
    {"q": "¿En qué año se fundó Twitch?", "o": ["2009", "2010", "2011", "2012"], "c": 2},
    {"q": "¿Qué significa ser 'partner' en Twitch?", "o": ["Tener 100 seguidores", "Estar verificado y monetizar", "Transmitir todos los días", "Ganar un torneo"], "c": 1},
    {"q": "¿Cuántos suscriptores tiene Ibai Llanos en Twitch aproximadamente?", "o": ["3 millones", "5 millones", "8 millones", "Más de 10 millones"], "c": 3},
    {"q": "¿Cuántos millones de suscriptores tiene MrBeast en español?", "o": ["10 millones", "30 millones", "50 millones", "Más de 60 millones"], "c": 3},
    {"q": "¿Cuántas personas pueden ver un stream en Twitch al mismo tiempo?", "o": ["1,000", "100,000", "Sin límite oficial", "10,000"], "c": 2},
    {"q": "¿Cómo se llama el youtuber argentino de 'Coscu Army'?", "o": ["Marcos Coscu", "Diego Gamer", "Pablo Stream", "Lucas TV"], "c": 0},
    {"q": "¿En qué plataforma empezó a ser famoso MrBeast?", "o": ["Twitch", "YouTube", "TikTok", "Instagram"], "c": 1},
    {"q": "¿Qué hace Khaby Lame en sus videos de TikTok?", "o": ["Baila reggaetón", "Reacciona en silencio a hacks absurdos", "Canta con celebridades", "Hace retos de comida"], "c": 1},
    {"q": "¿Cuántas horas de video se suben a YouTube por minuto?", "o": ["50 horas", "100 horas", "300 horas", "Más de 500 horas"], "c": 3},
    {"q": "¿Cuántos suscriptores necesita un canal para el botón de plata de YouTube?", "o": ["10,000", "50,000", "100,000", "500,000"], "c": 2},
    {"q": "¿Cómo se llama la colaboración musical de Bizarrap con Shakira?", "o": ["Sessions #52", "Sessions #53", "Sessions #54", "Sessions #55"], "c": 1},
    {"q": "¿De qué país es Bizarrap?", "o": ["España", "México", "Argentina", "Colombia"], "c": 2},
    {"q": "¿Cuántos restaurantes virtuales tiene la cadena MrBeast Burger?", "o": ["Solo en EEUU", "Cientos en todo el mundo", "Solo en Europa", "Solo 10"], "c": 1},

    # ── GAMING ────────────────────────────────────────────────────────────
    {"q": "¿Cuántos mundos (dimensiones) tiene Minecraft?", "o": ["2", "3", "4", "5"], "c": 1},
    {"q": "¿Cuál es el jefe final de Minecraft?", "o": ["El Wither", "El Dragón del End", "La Bruja", "El Creeper Cargado"], "c": 1},
    {"q": "¿Cuántas generaciones de Pokémon hay actualmente?", "o": ["7", "8", "9", "10"], "c": 2},
    {"q": "¿Cuántos Pokémon existen aproximadamente en total?", "o": ["Menos de 700", "Alrededor de 800", "Alrededor de 900", "Más de 1000"], "c": 3},
    {"q": "¿Cuál es el Pokémon número 1 en la Pokédex Nacional?", "o": ["Charizard", "Mewtwo", "Bulbasaur", "Pikachu"], "c": 2},
    {"q": "¿Qué material es más resistente que el diamante en Minecraft?", "o": ["Obsidiana", "Netherite", "Esmeralda", "Cuarzo"], "c": 1},
    {"q": "¿Cómo se llama el modo de Minecraft donde no podés morir?", "o": ["Modo Supervivencia", "Modo Creativo", "Modo Aventura", "Modo Espectador"], "c": 1},
    {"q": "¿Qué pasa si mirás a los ojos a un Enderman en Minecraft?", "o": ["Nada", "Se vuelve hostil y te ataca", "Te da un regalo", "Desaparece"], "c": 1},
    {"q": "¿Cuántos jugadores puede tener una partida de Among Us?", "o": ["10", "12", "15", "20"], "c": 2},
    {"q": "¿Cuál es la función del impostor en Among Us?", "o": ["Completar tareas", "Eliminar a los tripulantes", "Reparar el cohete", "Reportar cuerpos"], "c": 1},
    {"q": "¿En qué año salió Roblox al público?", "o": ["2004", "2006", "2008", "2010"], "c": 1},
    {"q": "¿Cuántos usuarios mensuales tiene Roblox aproximadamente?", "o": ["50 millones", "100 millones", "150 millones", "Más de 200 millones"], "c": 3},
    {"q": "¿Cuál fue el juego de Roblox más jugado históricamente?", "o": ["Brookhaven", "Adopt Me!", "Arsenal", "Murder Mystery 2"], "c": 1},
    {"q": "¿Qué empresa desarrolló Fortnite?", "o": ["Activision", "EA Games", "Epic Games", "Ubisoft"], "c": 2},
    {"q": "¿Cómo se llama el modo principal de Fortnite?", "o": ["King of the Hill", "Battle Royale", "Last Man Standing", "Survival Mode"], "c": 1},
    {"q": "¿Cuántos jugadores activos tiene Minecraft mensualmente?", "o": ["50 millones", "100 millones", "140 millones", "Más de 170 millones"], "c": 3},
    {"q": "¿Cómo se llama el servidor SMP de Dream?", "o": ["Dream World", "Dream SMP", "Dream Craft", "The Dream Server"], "c": 1},
    {"q": "¿Cuántas temporadas de Pokémon anime hay aproximadamente?", "o": ["Menos de 10", "Alrededor de 15", "Alrededor de 20", "Más de 25"], "c": 3},
    {"q": "¿Cuál de estos juegos es de Riot Games?", "o": ["Fortnite", "Overwatch", "Valorant", "Apex Legends"], "c": 2},
    {"q": "¿Qué tipo de juego es Valorant?", "o": ["Battle Royale", "MOBA", "Shooter táctico", "RPG"], "c": 2},
    {"q": "¿Cuántos campeones hay aproximadamente en League of Legends?", "o": ["Menos de 100", "Alrededor de 120", "Alrededor de 140", "Más de 160"], "c": 3},
    {"q": "¿De qué país es la empresa que creó Free Fire (Garena)?", "o": ["China", "Corea del Sur", "Singapur", "Estados Unidos"], "c": 2},
    {"q": "¿Cuántos mundos tiene Super Mario 64?", "o": ["12", "13", "14", "15"], "c": 3},
    {"q": "¿Cómo se llama el dinosaurio verde que ayuda a Mario?", "o": ["Luigi", "Toad", "Yoshi", "Koopa"], "c": 2},
    {"q": "¿Cuál es la espada más poderosa en Minecraft actualmente?", "o": ["Espada de diamante", "Espada de netherite", "Espada de hierro", "Espada de oro"], "c": 1},
    {"q": "¿En qué juego se usa la estrategia 'Rush B'?", "o": ["Valorant", "Counter-Strike", "Overwatch", "Call of Duty"], "c": 1},
    {"q": "¿Qué color tiene el traje de Steve en Minecraft?", "o": ["Rojo", "Azul", "Verde", "Amarillo"], "c": 1},
    {"q": "¿Cuántos colores tiene un Creeper de Minecraft?", "o": ["Verde uniforme", "Verde con manchas negras", "Azul con blanco", "Gris oscuro"], "c": 1},
    {"q": "¿Qué hace el Creeper en Minecraft cuando se acerca al jugador?", "o": ["Te golpea", "Explota", "Te empuja al vacío", "Te roba objetos"], "c": 1},
    {"q": "¿Cuántos jugadores activos simultáneos récord tuvo Fortnite?", "o": ["Más de 1 millón", "Más de 5 millones", "Más de 12 millones", "Más de 50 millones"], "c": 2},
    {"q": "¿Cuántos mundos de Minecraft puede generar el juego?", "o": ["Miles", "Millones", "Prácticamente infinitos", "Solo 100"], "c": 2},
    {"q": "¿Cuántos corazones tiene Link al inicio de Zelda: Breath of the Wild?", "o": ["1", "2", "3", "4"], "c": 2},
    {"q": "¿Cuántos V-Bucks cuesta el pase de batalla de Fortnite?", "o": ["500", "800", "950", "1200"], "c": 2},
    {"q": "¿Cuántos lados tiene el mapa original de Among Us (The Skeld)?", "o": ["Es circular", "Tiene forma de navio", "Tiene forma de T", "Es cuadrado"], "c": 1},
    {"q": "¿Cuántos juegos tiene la consola Nintendo Switch en su catálogo?", "o": ["Menos de 1000", "Más de 2000", "Más de 4000", "Más de 7000"], "c": 3},

    # ── ANIME ─────────────────────────────────────────────────────────────
    {"q": "¿Cuántas bolas de dragón existen en Dragon Ball?", "o": ["5", "6", "7", "8"], "c": 2},
    {"q": "¿Cuál es la transformación más poderosa de Goku en Dragon Ball Super?", "o": ["Super Saiyan Blue", "Ultra Instinct", "Super Saiyan God", "Super Saiyan 4"], "c": 1},
    {"q": "¿Cuál es el ataque más famoso de Goku?", "o": ["Galick Gun", "Spirit Bomb", "Kamehameha", "Final Flash"], "c": 2},
    {"q": "¿De qué aldea es Naruto Uzumaki?", "o": ["Aldea de la Arena", "Aldea de la Niebla", "Aldea de la Hoja", "Aldea de la Roca"], "c": 2},
    {"q": "¿Cuántos episodios tiene Dragon Ball Z?", "o": ["150", "200", "250", "291"], "c": 3},
    {"q": "¿Cuántos Pilares (Hashira) hay en Demon Slayer?", "o": ["7", "8", "9", "10"], "c": 2},
    {"q": "¿Cuál es el poder de Izuku Midoriya en My Hero Academia?", "o": ["All For One", "One For All", "Zero Gravity", "Dark Shadow"], "c": 1},
    {"q": "¿Cómo se llama el instituto de héroes en My Hero Academia?", "o": ["Hero Academy", "U.A. High School", "Todoroki School", "All Might Academy"], "c": 1},
    {"q": "¿Cuál es el gran tesoro que busca Luffy en One Piece?", "o": ["El Tesoro del Rey", "One Piece", "El Poneglyph de Oro", "El Fruto del Diablo"], "c": 1},
    {"q": "¿Cuál es el poder de Luffy en One Piece?", "o": ["Volar", "Cuerpo de goma", "Invisibilidad", "Control del fuego"], "c": 1},
    {"q": "¿Cuál es el Kekkei Genkai del clan Uchiha en Naruto?", "o": ["Byakugan", "Rinnegan", "Sharingan", "Tenseigan"], "c": 2},
    {"q": "¿Cuántos miembros tiene el equipo original Team 7 de Naruto?", "o": ["3", "4", "5", "6"], "c": 1},
    {"q": "¿Cuántos episodios tiene Naruto (el original)?", "o": ["150", "180", "200", "220"], "c": 3},
    {"q": "¿Cuál es la técnica emblemática de Naruto?", "o": ["Chidori", "Rasengan", "Kage Bunshin", "Raikiri"], "c": 2},
    {"q": "¿De qué color es el pelo de Goku en Super Saiyan?", "o": ["Rojo", "Azul", "Amarillo dorado", "Plateado"], "c": 2},
    {"q": "¿Cuál es el número 1 en el ranking de héroes en My Hero Academia?", "o": ["Endeavor", "All Might", "Hawks", "Best Jeanist"], "c": 1},
    {"q": "¿Cómo se llama el juego de cartas de Yu-Gi-Oh!?", "o": ["Shadow Games", "Duel Monsters", "Card Wars", "Dragon Battles"], "c": 1},
    {"q": "¿En qué año empezó a emitirse Sword Art Online (anime)?", "o": ["2010", "2011", "2012", "2013"], "c": 2},
    {"q": "¿Cuántos episodios tiene Dragon Ball (el original, antes de Z)?", "o": ["100", "120", "153", "200"], "c": 2},
    {"q": "¿Cuál es la técnica de respiración principal de Tanjiro en Demon Slayer?", "o": ["Respiración del Fuego", "Respiración del Agua", "Respiración del Trueno", "Respiración del Viento"], "c": 1},
    {"q": "¿Cómo se llaman los gigantes en Attack on Titan?", "o": ["Colosales", "Titanes", "Gigantes", "Leviatanes"], "c": 1},
    {"q": "¿Cuál es el nombre del ataque de Saitama en One Punch Man?", "o": ["Ultra Punch", "Puño Serio", "Golpe Final", "Puño Cósmico"], "c": 1},
    {"q": "¿Cuántos Caballeros del Zodiaco hay en el equipo principal de Saint Seiya?", "o": ["3", "4", "5", "6"], "c": 2},
    {"q": "¿En qué ciudad se ambienta principalmente Tokyo Revengers?", "o": ["Osaka", "Kyoto", "Tokyo", "Hiroshima"], "c": 2},
    {"q": "¿Cuál es el quirk de Ochaco Uraraka en My Hero Academia?", "o": ["Explosion", "Zero Gravity", "Hardening", "Frog-Form"], "c": 1},

    # ── SERIES Y PELÍCULAS ────────────────────────────────────────────────
    {"q": "¿Cuántas películas hay en la saga de Harry Potter?", "o": ["6", "7", "8", "9"], "c": 2},
    {"q": "¿En qué Casa de Hogwarts está Harry Potter?", "o": ["Hufflepuff", "Ravenclaw", "Gryffindor", "Slytherin"], "c": 2},
    {"q": "¿En qué andén sale el Hogwarts Express?", "o": ["8½", "9¾", "10¼", "7½"], "c": 1},
    {"q": "¿En qué orden cronológico está la historia de Star Wars?", "o": ["Episodio 4 es el primero filmado", "Episodio 1 es el primero filmado", "Episodio 7 es el primero filmado", "Todos se filmaron en orden"], "c": 0},
    {"q": "¿Quién dice 'Yo soy tu padre' en Star Wars?", "o": ["Obi-Wan", "Palpatine", "Darth Vader", "Yoda"], "c": 2},
    {"q": "¿Cuántos participantes hay en El Juego del Calamar originalmente?", "o": ["100", "200", "456", "999"], "c": 2},
    {"q": "¿Cuál es el premio del ganador de El Juego del Calamar?", "o": ["1 millón de dólares", "45,6 mil millones de wones", "100 millones de euros", "1 billón de yenes"], "c": 1},
    {"q": "¿Cuántas temporadas tiene Cobra Kai?", "o": ["4", "5", "6", "7"], "c": 2},
    {"q": "¿Cómo se llama el reino en Frozen?", "o": ["Elsa-land", "Arendelle", "Frozen Kingdom", "Narnia"], "c": 1},
    {"q": "¿Cuántas películas tiene la saga de Toy Story?", "o": ["2", "3", "4", "5"], "c": 2},
    {"q": "¿Cuál es el nombre del villano de Toy Story 1?", "o": ["Lotso", "Sid", "Stinky Pete", "Al"], "c": 1},
    {"q": "¿En qué año se estrenó Stranger Things?", "o": ["2014", "2015", "2016", "2017"], "c": 2},
    {"q": "¿Cuál es el poder de Eleven en Stranger Things?", "o": ["Invisibilidad", "Telekinesis", "Vuelo", "Control del tiempo"], "c": 1},
    {"q": "¿Cuántos hermanos Weasley hay en Harry Potter?", "o": ["5", "6", "7", "8"], "c": 2},
    {"q": "¿Cuántas temporadas tiene La Casa de Papel?", "o": ["3", "4", "5", "6"], "c": 2},
    {"q": "¿En qué ciudad se ambienta Miraculous: Las aventuras de Ladybug?", "o": ["Madrid", "Londres", "París", "Roma"], "c": 2},
    {"q": "¿Cuántos actores distintos interpretaron a Spider-Man en No Way Home?", "o": ["2", "3", "4", "5"], "c": 1},
    {"q": "¿Cómo se llama el actor que interpreta a Peter Parker en el MCU?", "o": ["Andrew Garfield", "Tobey Maguire", "Tom Holland", "Jacob Batalon"], "c": 2},
    {"q": "¿En qué ciudad vive Spider-Man?", "o": ["Chicago", "Los Ángeles", "Nueva York", "Gotham"], "c": 2},
    {"q": "¿Cuántas temporadas tiene Gravity Falls?", "o": ["2", "3", "4", "5"], "c": 0},
    {"q": "¿De qué color es el traje original de Iron Man?", "o": ["Rojo y negro", "Azul y plata", "Rojo y dorado", "Naranja y rojo"], "c": 2},
    {"q": "¿Cómo se llama el capitán de Piratas del Caribe?", "o": ["Davy Jones", "Jack Sparrow", "Will Turner", "Barbossa"], "c": 1},
    {"q": "¿Cuántos miembros hay en el equipo principal de Teen Titans?", "o": ["4", "5", "6", "7"], "c": 1},
    {"q": "¿En qué año se estrenó la primera película de Spider-Man con Tobey Maguire?", "o": ["2000", "2001", "2002", "2003"], "c": 2},
    {"q": "¿Cuántos años durmió la Bella Durmiente según el cuento?", "o": ["10 años", "50 años", "100 años", "1000 años"], "c": 2},
    {"q": "¿Cómo se llama popularmente a Grogu de The Mandalorian?", "o": ["Mini Yoda", "Little Force", "Baby Yoda", "Kid Jedi"], "c": 2},
    {"q": "¿En qué año salió Black Panther?", "o": ["2016", "2017", "2018", "2019"], "c": 2},
    {"q": "¿Cuántos hermanos tiene Elsa en Frozen?", "o": ["Ninguno", "1 (Anna)", "2", "3"], "c": 1},
    {"q": "¿Quién reúne a los Vengadores en el MCU?", "o": ["Iron Man", "Nick Fury", "Captain America", "Thor"], "c": 1},
    {"q": "¿Cuántas películas tiene la trilogía de El Señor de los Anillos de Peter Jackson?", "o": ["2", "3", "4", "6"], "c": 1},

    # ── MÚSICA JÓVENES ────────────────────────────────────────────────────
    {"q": "¿Cuál es el fandom oficial de BTS?", "o": ["Blinks", "Army", "Swifties", "Beehive"], "c": 1},
    {"q": "¿De qué país es Taylor Swift?", "o": ["Canadá", "Australia", "Reino Unido", "Estados Unidos"], "c": 3},
    {"q": "¿Cuántas veces ganó Taylor Swift el Grammy a Álbum del Año?", "o": ["2", "3", "4", "5"], "c": 2},
    {"q": "¿De qué país es Nicki Nicole?", "o": ["Colombia", "Argentina", "México", "Uruguay"], "c": 1},
    {"q": "¿Cuántos integrantes tiene BLACKPINK?", "o": ["3", "4", "5", "6"], "c": 1},
    {"q": "¿De qué país es Justin Bieber?", "o": ["Estados Unidos", "Canadá", "Australia", "Reino Unido"], "c": 1},
    {"q": "¿Cuál es el nombre real de The Weeknd?", "o": ["Abel Tesfaye", "Michael Benjamin", "The Real Weekend", "Abel Makkonen"], "c": 0},
    {"q": "¿Quién fue el artista más escuchado en Spotify 3 años seguidos (2020-2022)?", "o": ["Drake", "Ed Sheeran", "Bad Bunny", "J Balvin"], "c": 2},
    {"q": "¿Cuántos años tenía Billie Eilish cuando lanzó su primer álbum?", "o": ["15", "16", "17", "18"], "c": 2},
    {"q": "¿De qué país es Maluma?", "o": ["Puerto Rico", "Colombia", "Venezuela", "República Dominicana"], "c": 1},
    {"q": "¿Cuántos integrantes tiene el grupo de K-Pop BTS?", "o": ["5", "6", "7", "8"], "c": 2},
    {"q": "¿En qué año se formó One Direction?", "o": ["2008", "2009", "2010", "2011"], "c": 2},
    {"q": "¿De qué país es la cantante Anitta?", "o": ["Colombia", "Argentina", "Brasil", "Venezuela"], "c": 2},
    {"q": "¿Cómo se llama el álbum debut de Billie Eilish?", "o": ["Happier Than Ever", "When We All Fall Asleep", "Hit Me Hard and Soft", "Don't Smile at Me"], "c": 1},
    {"q": "¿Cuántos seguidores tiene Selena Gomez en Instagram aproximadamente?", "o": ["100 millones", "200 millones", "300 millones", "Más de 400 millones"], "c": 3},
    {"q": "¿De qué país es la cantante Dua Lipa?", "o": ["Albania/Reino Unido", "España", "Francia", "Italia"], "c": 0},
    {"q": "¿Cuántos años tenía Olivia Rodrigo cuando lanzó 'drivers license'?", "o": ["15", "16", "17", "18"], "c": 2},
    {"q": "¿Cuál es el fandom de los fans de Harry Styles?", "o": ["Directioners", "Stylists", "Harries", "HarryFans"], "c": 2},
    {"q": "¿De qué país es el cantante de reggaetón Karol G?", "o": ["Puerto Rico", "Colombia", "Venezuela", "República Dominicana"], "c": 1},
    {"q": "¿Cuántos Grammys Latinos ganó Karol G en 2024?", "o": ["1", "2", "3", "5"], "c": 2},

    # ── CIENCIA Y ESCOLAR ─────────────────────────────────────────────────
    {"q": "¿Cuántas patas tiene una abeja?", "o": ["4", "6", "8", "10"], "c": 1},
    {"q": "¿Cuál es el hueso más largo del cuerpo humano?", "o": ["Tibia", "Húmero", "Fémur", "Radio"], "c": 2},
    {"q": "¿Cuántas costillas tiene el ser humano?", "o": ["20", "22", "24", "26"], "c": 2},
    {"q": "¿Cuántos dientes permanentes tiene un adulto?", "o": ["28", "30", "32", "36"], "c": 2},
    {"q": "¿Cuántas cámaras tiene el corazón humano?", "o": ["2", "3", "4", "6"], "c": 2},
    {"q": "¿Cuántos dientes tiene un tiburón blanco a lo largo de su vida?", "o": ["50", "500", "1000", "Más de 3000"], "c": 3},
    {"q": "¿Cuántos países tiene el continente africano?", "o": ["40", "47", "54", "60"], "c": 2},
    {"q": "¿Cuántos grados tiene un ángulo recto?", "o": ["45", "90", "180", "360"], "c": 1},
    {"q": "¿Cuántos países hacen frontera con Argentina?", "o": ["3", "4", "5", "6"], "c": 2},
    {"q": "¿Cuál es la capital de Brasil?", "o": ["São Paulo", "Río de Janeiro", "Brasilia", "Salvador"], "c": 2},
    {"q": "¿Cuántos elementos tiene la tabla periódica?", "o": ["100", "108", "115", "118"], "c": 3},
    {"q": "¿Cuál es el símbolo del oxígeno en la tabla periódica?", "o": ["Ox", "Oc", "O", "Og"], "c": 2},
    {"q": "¿Cuántos ojos tiene una mosca?", "o": ["2", "4", "2 compuestos", "Prácticamente 360° de visión con ojos compuestos"], "c": 3},
    {"q": "¿Cuántos ojos tiene una araña típica?", "o": ["4", "6", "8", "12"], "c": 2},
    {"q": "¿Cuántos huesos tiene el cuerpo humano al nacer?", "o": ["100", "150", "206", "Más de 270"], "c": 3},
    {"q": "¿Cuántos litros de sangre tiene el cuerpo humano adulto?", "o": ["2-3 litros", "3-4 litros", "5-6 litros", "8-10 litros"], "c": 2},
    {"q": "¿Cuántos músculos tiene el cuerpo humano?", "o": ["100", "300", "500", "Más de 600"], "c": 3},
    {"q": "¿A qué velocidad puede nadar un delfín?", "o": ["20 km/h", "30 km/h", "40 km/h", "Más de 50 km/h"], "c": 3},
    {"q": "¿Cuántos idiomas hay en el mundo aproximadamente?", "o": ["1000", "3000", "5000", "Más de 7000"], "c": 3},
    {"q": "¿Cuántas horas duerme un gato al día en promedio?", "o": ["4-6 horas", "8-10 horas", "10-12 horas", "12-16 horas"], "c": 3},

    # ── DEPORTES ──────────────────────────────────────────────────────────
    {"q": "¿Cuántos Mundiales de Fútbol ganó Argentina?", "o": ["2", "3", "4", "5"], "c": 1},
    {"q": "¿Cuántos goles marcó Messi en el Mundial Qatar 2022?", "o": ["5", "6", "7", "8"], "c": 2},
    {"q": "¿En qué club juega Messi actualmente?", "o": ["PSG", "Inter Miami", "Barcelona", "Al-Nassr"], "c": 1},
    {"q": "¿Cuántos goles marcó Messi en toda su carrera en el FC Barcelona?", "o": ["400", "520", "600", "672"], "c": 3},
    {"q": "¿Cuántos goles marcó Cristiano Ronaldo en toda su carrera?", "o": ["500", "650", "800", "Más de 900"], "c": 3},
    {"q": "¿Cuántos jugadores tiene un equipo de voleibol en cancha?", "o": ["5", "6", "7", "8"], "c": 1},
    {"q": "¿Cuántos minutos dura un cuarto en la NBA?", "o": ["10", "12", "15", "20"], "c": 1},
    {"q": "¿Con qué número jugó Michael Jordan en los Chicago Bulls?", "o": ["22", "23", "32", "33"], "c": 1},
    {"q": "¿En qué ciudad se realizaron los Juegos Olímpicos de 2024?", "o": ["Los Ángeles", "Tokyo", "París", "Brisbane"], "c": 2},
    {"q": "¿Cuántos puntos vale un mate (dunk) en básquetbol?", "o": ["1", "2", "3", "4"], "c": 1},
    {"q": "¿En qué año se fundó la FIFA?", "o": ["1896", "1900", "1904", "1910"], "c": 2},
    {"q": "¿Cuántos corredores hay en la final de los 100 metros llanos?", "o": ["6", "7", "8", "9"], "c": 2},
    {"q": "¿Cuántos puntos necesita un equipo para ganar un set de voleibol?", "o": ["20", "21", "25", "30"], "c": 2},
    {"q": "¿Cuántos sets juega una mujer en un Grand Slam de tenis?", "o": ["Primero en ganar 2", "Primero en ganar 3", "Primero en ganar 4", "Primero en ganar 5"], "c": 0},
    {"q": "¿Cuántos goles marca el máximo goleador del Mundial más veces en la historia?", "o": ["5", "6", "7", "8"], "c": 2},

    # ── INTERNET / MEMES / TIKTOK ─────────────────────────────────────────
    {"q": "¿Cuántos seguidores tiene Charlie D'Amelio en TikTok?", "o": ["50 millones", "80 millones", "120 millones", "Más de 150 millones"], "c": 3},
    {"q": "¿Cuál fue el baile viral más famoso de TikTok en 2020?", "o": ["Savage", "Renegade", "WAP", "Say So"], "c": 1},
    {"q": "¿Cuántos años tenía Charli D'Amelio cuando se hizo famosa?", "o": ["13", "14", "15", "16"], "c": 2},
    {"q": "¿Qué significa LOL en internet?", "o": ["Lots of Love", "Laughing Out Loud", "Laugh Online Later", "Living On Laughs"], "c": 1},
    {"q": "¿Cuántos usuarios tiene Instagram aproximadamente?", "o": ["500 millones", "1 mil millones", "1.5 mil millones", "Más de 2 mil millones"], "c": 3},
    {"q": "¿Qué significa AFK en gaming?", "o": ["Already at Fun", "Away From Keyboard", "All For Kills", "Ask For Keys"], "c": 1},
    {"q": "¿Cuántos segundos puede durar máximo un Reel de Instagram?", "o": ["30 segundos", "60 segundos", "90 segundos", "3 minutos"], "c": 2},
    {"q": "¿Qué significa GG al final de un juego?", "o": ["Go Go", "Good Game", "Great Gamer", "Get Going"], "c": 1},
    {"q": "¿Cuál es el emoji más usado en el mundo?", "o": ["❤️", "😂", "🔥", "👍"], "c": 1},
    {"q": "¿Qué significa GOAT en el contexto de deportes e internet?", "o": ["Good Old Athletic Team", "Greatest Of All Time", "Game On All Time", "Go On And Try"], "c": 1},
    {"q": "¿Cuántos usuarios tiene Discord aproximadamente?", "o": ["100 millones", "200 millones", "300 millones", "Más de 500 millones"], "c": 3},
    {"q": "¿Cuántos caracteres puede tener un comentario de YouTube?", "o": ["500", "1000", "5000", "10,000"], "c": 3},
    {"q": "¿Qué significa 'viral' en redes sociales?", "o": ["Un video muy corto", "Contenido que se comparte masivamente", "Un video con filtros", "Un video privado"], "c": 1},
    {"q": "¿Cuántos países hay en el mundo?", "o": ["180", "185", "193", "195"], "c": 3},
    {"q": "¿Qué significa 'streaming'?", "o": ["Descargar películas", "Transmitir contenido por internet en vivo", "Ver televisión por cable", "Escuchar radio AM"], "c": 1},

    # ── EXTRA MIX ─────────────────────────────────────────────────────────
    {"q": "¿Cuántos años tiene Hogwarts como institución en Harry Potter?", "o": ["500 años", "700 años", "1000 años", "2000 años"], "c": 2},
    {"q": "¿Cuántas temporadas tiene 'Gravity Falls'?", "o": ["1", "2", "3", "4"], "c": 1},
    {"q": "¿Cuántos colores tiene la bandera de Argentina?", "o": ["2", "3", "4", "5"], "c": 1},
    {"q": "¿En qué ciudad nació Lionel Messi?", "o": ["Buenos Aires", "Córdoba", "Rosario", "Mendoza"], "c": 2},
    {"q": "¿Cuántas estrellas tiene la bandera de Brasil?", "o": ["22", "24", "27", "30"], "c": 2},
    {"q": "¿Cuántos jugadores tiene cada equipo en el fútbol americano en cancha?", "o": ["9", "10", "11", "12"], "c": 2},
    {"q": "¿Cuántos episodios tiene la primera temporada de Demon Slayer?", "o": ["20", "22", "26", "30"], "c": 2},
    {"q": "¿Cuál es el nombre del arma principal de Link en Zelda?", "o": ["Excalibur", "Espada Maestra", "Espada del Cielo", "Hoja Kokiri"], "c": 1},
    {"q": "¿Cuántos tipos de Pokémon hay actualmente?", "o": ["15", "16", "17", "18"], "c": 3},
    {"q": "¿Qué personaje de Marvel puede cargar el martillo Mjolnir?", "o": ["Iron Man", "Captain America", "Thor", "Hulk"], "c": 2},
    {"q": "¿Cuántos miembros tiene el grupo de K-Pop BLACKPINK?", "o": ["3", "4", "5", "6"], "c": 1},
    {"q": "¿De qué país es la youtuber Yuya (Mariand Castrejon)?", "o": ["Colombia", "México", "Argentina", "España"], "c": 1},
    {"q": "¿Cuántos mundos tiene Super Mario Bros. original de NES?", "o": ["4", "6", "8", "10"], "c": 2},
    {"q": "¿Cuántos tipos de pociones hay en Minecraft básicamente?", "o": ["3", "5", "Muchos tipos distintos", "Solo 1"], "c": 2},
    {"q": "¿Cuántos capítulos tiene el manga de Naruto?", "o": ["400", "500", "600", "700"], "c": 3},
]

SLUG_COUNTER: dict[str, int] = {}


def slugify(text: str) -> str:
    text = text.lower()
    for old, new in [
        ("á","a"),("é","e"),("í","i"),("ó","o"),("ú","u"),("ñ","n"),("ü","u"),
        ("¿",""),("?",""),("¡",""),("!",""),("'",""),("'",""),("%","pct"),("°",""),("×","x"),
    ]:
        text = text.replace(old, new)
    text = re.sub(r"[^a-z0-9\s-]", "", text)
    text = re.sub(r"[\s-]+", "-", text).strip("-")
    base = text[:75]
    count = SLUG_COUNTER.get(base, 0)
    SLUG_COUNTER[base] = count + 1
    return base if count == 0 else f"{base}-{count}"


def esc(text: str) -> str:
    return text.replace("'", "''")


def main() -> None:
    out = open("kid_questions.sql", "w", encoding="utf-8")

    def p(text: str = "") -> None:
        out.write(text + "\n")

    p("BEGIN;\n")
    q_ids: list[str] = []

    for q in QUESTIONS:
        q_id = str(uuid.uuid4())
        t_id = str(uuid.uuid4())
        q_ids.append(q_id)
        slug = slugify(q["q"])
        title = esc(q["q"])

        p(f"INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('{q_id}',1,'{slug}','approved',true,false,'multiple_choice','human',10,'{{}}');")
        p(f"INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('{t_id}','{q_id}','es','{title}','[]');")

        for i, opt in enumerate(q["o"]):
            opt_id = str(uuid.uuid4())
            correct = "true" if i == q["c"] else "false"
            p(f"INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('{opt_id}','{q_id}',1,{i},'{esc(opt)}',{correct},true,1.0,'{{}}');")

        p()

    ids_csv = ",".join(f"'{x}'" for x in q_ids)
    p(f"INSERT INTO question_analytics (question_id,times_shown,times_answered,times_skipped,option_pick_rates,audience_difficulty_profiles,updated_at) SELECT id,0,0,0,'{{}}','{{}}',NOW() FROM questions WHERE id IN ({ids_csv});\n")
    p("COMMIT;")
    out.close()
    print(f"Generado: kid_questions.sql  ({len(QUESTIONS)} preguntas)")


if __name__ == "__main__":
    main()
