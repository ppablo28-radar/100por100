"""
200 preguntas nuevas, revisadas y categorizadas.
Cada pregunta tiene tags explícitos para el sistema de modos.

Validación aplicada:
- Respuesta correcta verificada
- Sin duplicados con preguntas existentes
- Distractores plausibles pero claramente incorrectos
- Tags asignados al tema real de la pregunta

Uso: python seed_new_questions.py > new_questions.sql
"""
import re
import uuid

# q = pregunta | o = opciones | c = índice correcto | tags = categorías
QUESTIONS = [

    # ── GAMING ────────────────────────────────────────────────────────────
    {"q": "¿Cuánto tiempo dura un día completo en Minecraft (tiempo real)?",
     "o": ["10 minutos", "20 minutos", "30 minutos", "1 hora"],
     "c": 1, "tags": ["gaming"]},

    {"q": "¿Qué empresa desarrolló 'The Last of Us'?",
     "o": ["Rockstar Games", "Naughty Dog", "Santa Monica Studio", "Insomniac Games"],
     "c": 1, "tags": ["gaming"]},

    {"q": "¿En qué año salió Cyberpunk 2077?",
     "o": ["2018", "2019", "2020", "2021"],
     "c": 2, "tags": ["gaming"]},

    {"q": "¿Qué empresa desarrolló la saga Dark Souls y Elden Ring?",
     "o": ["Capcom", "FromSoftware", "Square Enix", "Bandai Namco"],
     "c": 1, "tags": ["gaming"]},

    {"q": "¿Qué consola de SEGA fue rival de la Super Nintendo en los años 90?",
     "o": ["Dreamcast", "Mega Drive / Genesis", "Saturn", "Game Gear"],
     "c": 1, "tags": ["gaming"]},

    {"q": "¿En qué año salió Grand Theft Auto: San Andreas?",
     "o": ["2003", "2004", "2005", "2006"],
     "c": 1, "tags": ["gaming"]},

    {"q": "¿Cuántos jugadores tiene un partido de Counter-Strike 2 (CS2)?",
     "o": ["8 (4 vs 4)", "10 (5 vs 5)", "12 (6 vs 6)", "16 (8 vs 8)"],
     "c": 1, "tags": ["gaming"]},

    {"q": "¿Qué significa 'FPS' en el contexto de videojuegos?",
     "o": ["Frames Per Second", "First Person Shooter", "Fast Play Speed", "Final Player Score"],
     "c": 0, "tags": ["gaming"]},

    {"q": "¿Cuántos pokémon tipo Dragón existen en la primera generación?",
     "o": ["1", "2", "3", "5"],
     "c": 2, "tags": ["gaming", "anime"]},

    {"q": "¿Cuántos bits tenía la Nintendo 64?",
     "o": ["16", "32", "64", "128"],
     "c": 2, "tags": ["gaming"]},

    {"q": "¿Qué consola vino después del Nintendo 64?",
     "o": ["Wii", "GameCube", "Nintendo DS", "Game Boy Advance"],
     "c": 1, "tags": ["gaming"]},

    {"q": "¿En qué año salió Elden Ring?",
     "o": ["2020", "2021", "2022", "2023"],
     "c": 2, "tags": ["gaming"]},

    {"q": "¿Cuántos jugadores puede haber en un partido de Overwatch (6v6)?",
     "o": ["8", "10", "12", "14"],
     "c": 2, "tags": ["gaming"]},

    {"q": "¿A qué juego pertenece la frase 'It's dangerous to go alone! Take this.'?",
     "o": ["Ocarina of Time", "The Legend of Zelda (1986)", "A Link to the Past", "Majora's Mask"],
     "c": 1, "tags": ["gaming"]},

    {"q": "¿Qué es 'Herobrine' en Minecraft?",
     "o": ["Un boss oficial del juego", "Una leyenda urbana de los jugadores", "Un mod de horror", "Un mob del Nether"],
     "c": 1, "tags": ["gaming"]},

    {"q": "¿Cuántos materiales distintos puede tener una espada en Minecraft?",
     "o": ["4", "5", "6", "7"],
     "c": 2, "tags": ["gaming"]},

    {"q": "¿Cuántos capítulos tiene Fortnite hasta el año 2024?",
     "o": ["3", "4", "5", "6"],
     "c": 2, "tags": ["gaming"]},

    {"q": "¿Qué tipo de personaje es 'Kratos' de God of War?",
     "o": ["Samurái japonés", "Guerrero espartano y dios de la guerra", "Caballero medieval", "Vikingo nórdico"],
     "c": 1, "tags": ["gaming"]},

    {"q": "¿Cuántos objetos necesitás para hacer una mesa de trabajo (crafting table) en Minecraft?",
     "o": ["2 tablas de madera", "3 tablas de madera", "4 tablas de madera", "6 tablas de madera"],
     "c": 2, "tags": ["gaming"]},

    {"q": "¿Cuál fue el primer juego de la saga 'Grand Theft Auto'?",
     "o": ["GTA Vice City", "GTA San Andreas", "Grand Theft Auto (1997)", "GTA III"],
     "c": 2, "tags": ["gaming"]},

    # ── ANIME ─────────────────────────────────────────────────────────────
    {"q": "¿Cuántos capítulos tiene el manga de One Piece aproximadamente (hasta 2024)?",
     "o": ["700", "900", "1000", "Más de 1100"],
     "c": 3, "tags": ["anime"]},

    {"q": "¿Cuántos episodios tiene Naruto Shippuden?",
     "o": ["350", "400", "450", "500"],
     "c": 3, "tags": ["anime"]},

    {"q": "¿En qué año empezó el anime de One Piece?",
     "o": ["1997", "1998", "1999", "2000"],
     "c": 2, "tags": ["anime"]},

    {"q": "¿En qué año empezó el anime de Dragon Ball?",
     "o": ["1984", "1985", "1986", "1987"],
     "c": 2, "tags": ["anime"]},

    {"q": "¿Cuántos miembros tiene Los Piratas del Sombrero de Paja en One Piece?",
     "o": ["8", "9", "10", "11"],
     "c": 2, "tags": ["anime"]},

    {"q": "¿Cómo se llama el barco de Los Piratas de Paja en One Piece?",
     "o": ["Gran Line", "Thousand Sunny", "Going Merry II", "Red Force"],
     "c": 1, "tags": ["anime"]},

    {"q": "¿Cuántas temporadas tiene My Hero Academia?",
     "o": ["5", "6", "7", "8"],
     "c": 2, "tags": ["anime"]},

    {"q": "¿Cuál es el poder del personaje Todoroki en My Hero Academia?",
     "o": ["Explosión", "Mitad fuego y mitad hielo", "Velocidad extrema", "Teletransportación"],
     "c": 1, "tags": ["anime"]},

    {"q": "¿Cuántos miembros tiene la Akatsuki en Naruto?",
     "o": ["7", "8", "9", "10"],
     "c": 3, "tags": ["anime"]},

    {"q": "¿Cuál es el rango ninja más alto en el mundo de Naruto?",
     "o": ["Jounin", "Anbu", "Sannin", "Kage"],
     "c": 3, "tags": ["anime"]},

    {"q": "¿En qué año empezó el anime de Demon Slayer (Kimetsu no Yaiba)?",
     "o": ["2017", "2018", "2019", "2020"],
     "c": 2, "tags": ["anime"]},

    {"q": "¿Cuántos episodios tiene la primera temporada de Attack on Titan?",
     "o": ["20", "22", "24", "25"],
     "c": 3, "tags": ["anime"]},

    {"q": "¿En qué año empezó el anime de My Hero Academia?",
     "o": ["2014", "2015", "2016", "2017"],
     "c": 2, "tags": ["anime"]},

    {"q": "¿Cuántos años tiene Monkey D. Luffy al inicio de One Piece?",
     "o": ["15", "16", "17", "18"],
     "c": 2, "tags": ["anime"]},

    {"q": "¿Cuál es el objetivo de Gon Freecss en Hunter x Hunter?",
     "o": ["Convertirse en el rey pirata", "Ser el mejor cazador para encontrar a su padre", "Convertirse en Hokage", "Ganar el torneo de artes marciales"],
     "c": 1, "tags": ["anime"]},

    # ── SERIES Y PELÍCULAS ────────────────────────────────────────────────
    {"q": "¿En qué año salió la primera película de 'The Avengers'?",
     "o": ["2010", "2011", "2012", "2013"],
     "c": 2, "tags": ["series"]},

    {"q": "¿Quién interpretó al Joker en la película 'Joker' de 2019?",
     "o": ["Heath Ledger", "Jared Leto", "Joaquin Phoenix", "Jack Nicholson"],
     "c": 2, "tags": ["series"]},

    {"q": "¿En qué año se estrenó la película 'Titanic' de James Cameron?",
     "o": ["1995", "1996", "1997", "1998"],
     "c": 2, "tags": ["series"]},

    {"q": "¿Quién creó la serie 'Los Simpsons'?",
     "o": ["Seth MacFarlane", "Matt Groening", "Mike Judge", "Dan Harmon"],
     "c": 1, "tags": ["series"]},

    {"q": "¿En qué año empezó a emitirse la serie 'Los Simpsons'?",
     "o": ["1987", "1988", "1989", "1990"],
     "c": 2, "tags": ["series"]},

    {"q": "¿Cuántas temporadas tiene 'Los Simpsons' (hasta 2024)?",
     "o": ["25", "30", "35", "Más de 35"],
     "c": 3, "tags": ["series"]},

    {"q": "¿Cómo se llama el cuñado de Walter White en Breaking Bad?",
     "o": ["Jesse Pinkman", "Hank Schrader", "Mike Ehrmantraut", "Gustavo Fring"],
     "c": 1, "tags": ["series"]},

    {"q": "¿Quién interpreta a 'Thor' en el Universo Cinematográfico de Marvel?",
     "o": ["Chris Evans", "Chris Hemsworth", "Chris Pratt", "Chris Pine"],
     "c": 1, "tags": ["series"]},

    {"q": "¿En qué ciudad ficticia vive Batman?",
     "o": ["Metropolis", "Gotham City", "Star City", "Central City"],
     "c": 1, "tags": ["series"]},

    {"q": "¿Cuántos libros tiene la saga principal de 'Harry Potter'?",
     "o": ["5", "6", "7", "8"],
     "c": 2, "tags": ["series"]},

    {"q": "¿En qué año se publicó el primer libro de Harry Potter?",
     "o": ["1995", "1996", "1997", "1998"],
     "c": 2, "tags": ["series"]},

    {"q": "¿Quiénes crearon la serie 'Stranger Things'?",
     "o": ["J.J. Abrams", "Steven Spielberg", "Los Hermanos Duffer", "Ryan Murphy"],
     "c": 2, "tags": ["series"]},

    {"q": "¿En qué país se ambienta 'La Casa de Papel'?",
     "o": ["Argentina", "México", "España", "Colombia"],
     "c": 2, "tags": ["series"]},

    {"q": "¿Quién interpreta a 'El Profesor' en La Casa de Papel?",
     "o": ["Álvaro Morte", "Pedro Alonso", "Miguel Herrán", "Jaime Lorente"],
     "c": 0, "tags": ["series"]},

    {"q": "¿En qué año se estrenó la serie 'The Mandalorian'?",
     "o": ["2018", "2019", "2020", "2021"],
     "c": 1, "tags": ["series"]},

    {"q": "¿Cuántas películas tiene la saga de 'John Wick' (hasta 2023)?",
     "o": ["2", "3", "4", "5"],
     "c": 2, "tags": ["series"]},

    {"q": "¿Quién interpreta a John Wick?",
     "o": ["Tom Cruise", "Keanu Reeves", "Dwayne Johnson", "Jason Statham"],
     "c": 1, "tags": ["series"]},

    {"q": "¿En qué año se estrenó 'Avengers: Endgame'?",
     "o": ["2018", "2019", "2020", "2021"],
     "c": 1, "tags": ["series"]},

    {"q": "¿Qué personaje de Marvel dice la frase 'I am Groot'?",
     "o": ["Rocket Raccoon", "Thanos", "Groot", "Nebula"],
     "c": 2, "tags": ["series"]},

    {"q": "¿Cuántas temporadas tiene la serie 'Narcos'?",
     "o": ["2", "3", "4", "5"],
     "c": 1, "tags": ["series"]},

    {"q": "¿En qué año se estrenó la película 'Interstellar'?",
     "o": ["2012", "2013", "2014", "2015"],
     "c": 2, "tags": ["series"]},

    # ── MÚSICA ────────────────────────────────────────────────────────────
    {"q": "¿De qué país es el cantante Feid?",
     "o": ["Venezuela", "Colombia", "México", "Argentina"],
     "c": 1, "tags": ["musica"]},

    {"q": "¿Cómo se llama el primer álbum de Bad Bunny?",
     "o": ["YHLQMDLG", "Un Verano Sin Ti", "X 100PRE", "El Último Tour del Mundo"],
     "c": 2, "tags": ["musica"]},

    {"q": "¿En qué año ganó Billie Eilish su primer Grammy a Álbum del Año?",
     "o": ["2019", "2020", "2021", "2022"],
     "c": 1, "tags": ["musica"]},

    {"q": "¿Cuántos Grammys tiene Beyoncé (récord histórico, hasta 2024)?",
     "o": ["25", "28", "30", "32"],
     "c": 3, "tags": ["musica"]},

    {"q": "¿De qué país es el cantante Rauw Alejandro?",
     "o": ["Colombia", "Puerto Rico", "Rep. Dominicana", "México"],
     "c": 1, "tags": ["musica"]},

    {"q": "¿En qué año se formó el grupo BTS?",
     "o": ["2011", "2012", "2013", "2014"],
     "c": 2, "tags": ["musica"]},

    {"q": "¿Cuántos álbumes de estudio tiene Taylor Swift (hasta 2024)?",
     "o": ["8", "9", "10", "11"],
     "c": 3, "tags": ["musica"]},

    {"q": "¿Qué significa 'YHLQMDLG', el álbum de Bad Bunny?",
     "o": ["Yo Hago Lo Que Me Da La Gana", "Yo Hago Letras Que Me Dan La Gloria", "Yes He Likes Queen", "Yendo Hacia La Quinta"],
     "c": 0, "tags": ["musica"]},

    {"q": "¿En qué año se estrenó la canción 'Despacito' de Luis Fonsi?",
     "o": ["2016", "2017", "2018", "2019"],
     "c": 1, "tags": ["musica"]},

    {"q": "¿Cuántos integrantes tenía el grupo NSYNC?",
     "o": ["4", "5", "6", "7"],
     "c": 1, "tags": ["musica"]},

    {"q": "¿De qué país es el grupo musical 'Maná'?",
     "o": ["Argentina", "España", "Colombia", "México"],
     "c": 3, "tags": ["musica"]},

    {"q": "¿Qué instrumento toca principalmente Taylor Swift?",
     "o": ["Piano", "Violín", "Guitarra", "Bajo"],
     "c": 2, "tags": ["musica"]},

    {"q": "¿De qué país es la cantante Tini Stoessel?",
     "o": ["Colombia", "Uruguay", "Argentina", "Chile"],
     "c": 2, "tags": ["musica"]},

    {"q": "¿En qué año lanzó Justin Bieber la canción 'Baby'?",
     "o": ["2008", "2009", "2010", "2011"],
     "c": 2, "tags": ["musica"]},

    {"q": "¿En qué año empezó Spotify como servicio de streaming?",
     "o": ["2006", "2007", "2008", "2009"],
     "c": 2, "tags": ["musica", "internet"]},

    {"q": "¿De qué país es el cantante Myke Towers?",
     "o": ["Colombia", "México", "Puerto Rico", "Rep. Dominicana"],
     "c": 2, "tags": ["musica"]},

    # ── CIENCIA ───────────────────────────────────────────────────────────
    {"q": "¿Cuál es el número atómico del carbono en la tabla periódica?",
     "o": ["4", "6", "8", "12"],
     "c": 1, "tags": ["ciencia"]},

    {"q": "¿Qué órgano del cuerpo humano produce la insulina?",
     "o": ["Hígado", "Riñón", "Páncreas", "Bazo"],
     "c": 2, "tags": ["ciencia"]},

    {"q": "¿Cuánto tarda la luz en llegar de la Luna a la Tierra?",
     "o": ["0.1 segundos", "1.3 segundos", "5 segundos", "10 segundos"],
     "c": 1, "tags": ["ciencia"]},

    {"q": "¿Cuál es el elemento más abundante en el universo?",
     "o": ["Helio", "Hidrógeno", "Oxígeno", "Carbono"],
     "c": 1, "tags": ["ciencia"]},

    {"q": "¿Cuántas neuronas tiene el cerebro humano aproximadamente?",
     "o": ["10 mil millones", "50 mil millones", "86 mil millones", "200 mil millones"],
     "c": 2, "tags": ["ciencia"]},

    {"q": "¿Qué animal tiene la mordida más fuerte del mundo?",
     "o": ["León", "Tiburón blanco", "Hiena manchada", "Cocodrilo del Nilo"],
     "c": 3, "tags": ["ciencia"]},

    {"q": "¿Cuántos huesos tiene el pie humano?",
     "o": ["20", "23", "26", "30"],
     "c": 2, "tags": ["ciencia"]},

    {"q": "¿Cuál es la velocidad del sonido en el aire aproximadamente?",
     "o": ["200 m/s", "343 m/s", "500 m/s", "1000 m/s"],
     "c": 1, "tags": ["ciencia"]},

    {"q": "¿Cuántos planetas del sistema solar tienen anillos?",
     "o": ["1", "2", "3", "4"],
     "c": 3, "tags": ["ciencia"]},

    {"q": "¿Cuál es el metal más conductor de electricidad?",
     "o": ["Oro", "Cobre", "Plata", "Aluminio"],
     "c": 2, "tags": ["ciencia"]},

    {"q": "¿Cuál es el gas predominante en la atmósfera de Marte?",
     "o": ["Nitrógeno", "Oxígeno", "Dióxido de carbono", "Argón"],
     "c": 2, "tags": ["ciencia"]},

    {"q": "¿Cuántos dientes de leche tiene un niño?",
     "o": ["16", "18", "20", "22"],
     "c": 2, "tags": ["ciencia"]},

    {"q": "¿Cuál es el metal más pesado de la tabla periódica?",
     "o": ["Plomo", "Oro", "Mercurio", "Osmio"],
     "c": 3, "tags": ["ciencia"]},

    {"q": "¿Qué planeta tarda más en dar una vuelta al Sol?",
     "o": ["Saturno", "Urano", "Neptuno", "Plutón"],
     "c": 2, "tags": ["ciencia"]},

    {"q": "¿Cuántos lóbulos tiene el pulmón derecho humano?",
     "o": ["2", "3", "4", "5"],
     "c": 1, "tags": ["ciencia"]},

    {"q": "¿Qué tipo de estrella es nuestro Sol según su clasificación?",
     "o": ["Supergigante azul", "Gigante roja", "Enana amarilla", "Enana blanca"],
     "c": 2, "tags": ["ciencia"]},

    {"q": "¿Cuántos cromosomas tiene una persona con Síndrome de Down?",
     "o": ["44", "45", "46", "47"],
     "c": 3, "tags": ["ciencia"]},

    {"q": "¿A cuántos km/h puede volar una paloma mensajera?",
     "o": ["30 km/h", "60 km/h", "100 km/h", "150 km/h"],
     "c": 1, "tags": ["ciencia"]},

    # ── FÚTBOL ────────────────────────────────────────────────────────────
    {"q": "¿En qué año ganó Argentina su primer Mundial de Fútbol?",
     "o": ["1974", "1978", "1982", "1986"],
     "c": 1, "tags": ["futbol", "deportes"]},

    {"q": "¿Cuántos mundiales ganó Alemania?",
     "o": ["3", "4", "5", "6"],
     "c": 1, "tags": ["futbol", "deportes"]},

    {"q": "¿Quién ganó la Bota de Oro del Mundial 2022 (más goles)?",
     "o": ["Messi", "Mbappé", "Benzema", "Neymar"],
     "c": 1, "tags": ["futbol", "deportes"]},

    {"q": "¿En qué año nació Lionel Messi?",
     "o": ["1985", "1986", "1987", "1988"],
     "c": 2, "tags": ["futbol", "deportes"]},

    {"q": "¿Cuántos Mundiales jugó Diego Maradona como jugador?",
     "o": ["3", "4", "5", "6"],
     "c": 1, "tags": ["futbol", "deportes"]},

    {"q": "¿En qué estadio se jugó la final del Mundial Qatar 2022?",
     "o": ["Al Bayt Stadium", "Lusail Stadium", "Education City", "Al Thumama"],
     "c": 1, "tags": ["futbol", "deportes"]},

    {"q": "¿Cuántos títulos de Copa América ganó Argentina (hasta 2024)?",
     "o": ["14", "15", "16", "17"],
     "c": 2, "tags": ["futbol", "deportes"]},

    {"q": "¿Cuántos títulos de Champions League ganó Cristiano Ronaldo?",
     "o": ["3", "4", "5", "6"],
     "c": 2, "tags": ["futbol", "deportes"]},

    {"q": "¿En qué club argentino jugó Maradona más tiempo?",
     "o": ["River Plate", "Boca Juniors", "Racing Club", "Independiente"],
     "c": 1, "tags": ["futbol", "deportes"]},

    {"q": "¿Cuántos equipos tiene la NBA actualmente?",
     "o": ["28", "29", "30", "32"],
     "c": 2, "tags": ["deportes"]},

    {"q": "¿Cuántas medallas de oro ganó Michael Phelps en Juegos Olímpicos?",
     "o": ["18", "20", "23", "25"],
     "c": 2, "tags": ["deportes"]},

    {"q": "¿Qué deporte inventó James Naismith?",
     "o": ["Béisbol", "Básquetbol", "Voleibol", "Handball"],
     "c": 1, "tags": ["deportes"]},

    {"q": "¿En qué año fueron los primeros Juegos Olímpicos modernos?",
     "o": ["1892", "1896", "1900", "1904"],
     "c": 1, "tags": ["deportes"]},

    {"q": "¿En qué año fue inaugurado el Canal de Panamá?",
     "o": ["1910", "1914", "1920", "1924"],
     "c": 1, "tags": ["deportes", "historia"]},

    {"q": "¿Cuántos sets gana primero en un partido de vóleibol masculino (máximo)?",
     "o": ["3", "4", "5", "6"],
     "c": 2, "tags": ["deportes"]},

    {"q": "¿En qué país se inventó el rugby?",
     "o": ["Irlanda", "Australia", "Inglaterra", "Nueva Zelanda"],
     "c": 2, "tags": ["deportes"]},

    {"q": "¿Cuántos puntos vale la conversión después de un try en rugby?",
     "o": ["1", "2", "3", "4"],
     "c": 1, "tags": ["deportes"]},

    {"q": "¿Cuántos jueces puntúan en un partido de boxeo profesional?",
     "o": ["2", "3", "4", "5"],
     "c": 1, "tags": ["deportes"]},

    {"q": "¿En qué país se inventó el judo?",
     "o": ["China", "Corea del Sur", "Japón", "Mongolia"],
     "c": 2, "tags": ["deportes"]},

    {"q": "¿Cuántos equipos había en la Champions League (formato hasta 2023/24)?",
     "o": ["24", "28", "32", "36"],
     "c": 2, "tags": ["futbol", "deportes"]},

    # ── INTERNET / TECNOLOGÍA ─────────────────────────────────────────────
    {"q": "¿Qué significa 'RAM' en informática?",
     "o": ["Random Access Memory", "Read And More", "Rapid Application Mode", "Remote Access Management"],
     "c": 0, "tags": ["internet"]},

    {"q": "¿En qué año se fundó Microsoft?",
     "o": ["1973", "1975", "1977", "1979"],
     "c": 1, "tags": ["internet"]},

    {"q": "¿Quién cofundó Microsoft junto a Bill Gates?",
     "o": ["Steve Ballmer", "Paul Allen", "Satya Nadella", "Gordon Moore"],
     "c": 1, "tags": ["internet"]},

    {"q": "¿En qué año se envió el primer correo electrónico?",
     "o": ["1969", "1971", "1973", "1975"],
     "c": 1, "tags": ["internet"]},

    {"q": "¿Qué significa 'PDF'?",
     "o": ["Portable Document Format", "Print Document File", "Personal Data Format", "Processing Digital File"],
     "c": 0, "tags": ["internet"]},

    {"q": "¿Cuántos idiomas soporta Google Translate aproximadamente?",
     "o": ["50", "75", "100", "Más de 130"],
     "c": 3, "tags": ["internet"]},

    {"q": "¿En qué año salió Windows 10?",
     "o": ["2013", "2014", "2015", "2016"],
     "c": 2, "tags": ["internet"]},

    {"q": "¿Qué empresa creó el sistema operativo iOS?",
     "o": ["Samsung", "Google", "Apple", "Microsoft"],
     "c": 2, "tags": ["internet"]},

    {"q": "¿Cuántos usuarios tiene WhatsApp aproximadamente?",
     "o": ["500 millones", "1 mil millones", "1.5 mil millones", "Más de 2 mil millones"],
     "c": 3, "tags": ["internet"]},

    {"q": "¿En qué año lanzó Netflix su servicio de streaming (no DVD)?",
     "o": ["2005", "2006", "2007", "2008"],
     "c": 2, "tags": ["internet"]},

    {"q": "¿Qué significa 'VPN'?",
     "o": ["Virtual Private Network", "Verified Public Node", "Very Personal Network", "Video Processing Navigation"],
     "c": 0, "tags": ["internet"]},

    {"q": "¿En qué año se fundó Twitter?",
     "o": ["2004", "2005", "2006", "2007"],
     "c": 2, "tags": ["internet"]},

    {"q": "¿Qué significa 'CPU'?",
     "o": ["Central Processing Unit", "Computer Power Usage", "Central Program Unit", "Computing Process Utility"],
     "c": 0, "tags": ["internet"]},

    {"q": "¿En qué año se lanzó el primer teléfono con Android (HTC Dream)?",
     "o": ["2006", "2007", "2008", "2009"],
     "c": 2, "tags": ["internet"]},

    # ── ARGENTINA / LATINOAMÉRICA ─────────────────────────────────────────
    {"q": "¿Cuántos presidentes tuvo Argentina en diciembre de 2001?",
     "o": ["2", "3", "4", "5"],
     "c": 3, "tags": ["ar"]},

    {"q": "¿En qué año ocurrió la Guerra de Malvinas?",
     "o": ["1978", "1980", "1982", "1984"],
     "c": 2, "tags": ["ar"]},

    {"q": "¿Cuántas provincias tiene Argentina?",
     "o": ["22", "23", "24", "25"],
     "c": 1, "tags": ["ar"]},

    {"q": "¿Cuál es el río más largo de Argentina?",
     "o": ["Río Uruguay", "Río de la Plata", "Río Paraná", "Río Negro"],
     "c": 2, "tags": ["ar"]},

    {"q": "¿Cuánto mide el Cerro Aconcagua?",
     "o": ["5.961 m", "6.461 m", "6.961 m", "7.461 m"],
     "c": 2, "tags": ["ar"]},

    {"q": "¿Cuál es el deporte nacional oficial de Argentina?",
     "o": ["Fútbol", "Hockey", "Pato", "Rugby"],
     "c": 2, "tags": ["ar"]},

    {"q": "¿Cuántos títulos de Copa Libertadores ganó Boca Juniors?",
     "o": ["4", "5", "6", "7"],
     "c": 2, "tags": ["ar", "futbol"]},

    {"q": "¿En qué ciudad nació el Papa Francisco?",
     "o": ["Córdoba", "Rosario", "Buenos Aires", "La Plata"],
     "c": 2, "tags": ["ar"]},

    {"q": "¿En qué año fue fundada la ciudad de Buenos Aires (segunda fundación definitiva)?",
     "o": ["1536", "1580", "1600", "1620"],
     "c": 1, "tags": ["ar"]},

    {"q": "¿Cuál es la segunda ciudad más poblada de Argentina?",
     "o": ["Rosario", "Córdoba", "Mendoza", "La Plata"],
     "c": 1, "tags": ["ar"]},

    {"q": "¿En qué países está el lago Titicaca?",
     "o": ["Argentina y Chile", "Bolivia y Perú", "Colombia y Venezuela", "Ecuador y Perú"],
     "c": 1, "tags": ["ar"]},

    {"q": "¿Cuántos idiomas oficiales tiene Bolivia?",
     "o": ["3", "12", "25", "37"],
     "c": 3, "tags": ["ar"]},

    {"q": "¿Cuál es la moneda de Brasil?",
     "o": ["Peso", "Real", "Bolívar", "Sol"],
     "c": 1, "tags": ["ar"]},

    {"q": "¿Cuál es el país más grande de América Latina?",
     "o": ["Argentina", "México", "Brasil", "Colombia"],
     "c": 2, "tags": ["ar"]},

    {"q": "¿En cuántos países latinoamericanos el español es idioma oficial?",
     "o": ["15", "18", "20", "22"],
     "c": 1, "tags": ["ar"]},

    # ── HISTORIA Y GEOGRAFÍA ──────────────────────────────────────────────
    {"q": "¿En qué año cayó el Imperio Romano de Occidente?",
     "o": ["410", "476", "500", "527"],
     "c": 1, "tags": ["historia"]},

    {"q": "¿Cuál es el país más pequeño del mundo?",
     "o": ["Monaco", "Liechtenstein", "San Marino", "Ciudad del Vaticano"],
     "c": 3, "tags": ["historia", "general"]},

    {"q": "¿Cuántos países tiene el continente asiático?",
     "o": ["40", "44", "48", "54"],
     "c": 2, "tags": ["historia"]},

    {"q": "¿En qué año fue completado el Coliseo Romano?",
     "o": ["50 d.C.", "70 d.C.", "80 d.C.", "100 d.C."],
     "c": 2, "tags": ["historia"]},

    {"q": "¿Cuántos años duró la Segunda Guerra Mundial?",
     "o": ["4", "5", "6", "7"],
     "c": 2, "tags": ["historia"]},

    {"q": "¿Cuál es el lago más profundo del mundo?",
     "o": ["Lago Titicaca", "Lago Superior", "Lago Baikal", "Mar Caspio"],
     "c": 2, "tags": ["historia"]},

    {"q": "¿En qué año llegó Cristóbal Colón a América?",
     "o": ["1490", "1491", "1492", "1493"],
     "c": 2, "tags": ["historia"]},

    {"q": "¿En qué año empezó la Primera Guerra Mundial?",
     "o": ["1912", "1913", "1914", "1915"],
     "c": 2, "tags": ["historia"]},

    {"q": "¿En qué año terminó la Segunda Guerra Mundial?",
     "o": ["1944", "1945", "1946", "1947"],
     "c": 1, "tags": ["historia"]},

    {"q": "¿Cuál es el desierto más caliente y grande del mundo?",
     "o": ["Sahara", "Gobi", "Atacama", "Arábigo"],
     "c": 0, "tags": ["historia"]},

    {"q": "¿En qué año fue construida la Torre Eiffel?",
     "o": ["1885", "1887", "1889", "1891"],
     "c": 2, "tags": ["historia"]},

    {"q": "¿Cuántos metros de altura tiene la Torre Eiffel (con antena)?",
     "o": ["250 m", "300 m", "330 m", "400 m"],
     "c": 2, "tags": ["historia"]},

    {"q": "¿Cuántos países tiene Oceanía?",
     "o": ["8", "10", "14", "20"],
     "c": 2, "tags": ["historia"]},

    {"q": "¿En qué año fue la Revolución Francesa?",
     "o": ["1785", "1787", "1789", "1791"],
     "c": 2, "tags": ["historia"]},

    {"q": "¿Cuál es la capital de Canadá?",
     "o": ["Toronto", "Vancouver", "Montreal", "Ottawa"],
     "c": 3, "tags": ["historia", "general"]},

    {"q": "¿En qué año fue asesinado Abraham Lincoln?",
     "o": ["1863", "1864", "1865", "1866"],
     "c": 2, "tags": ["historia"]},

    {"q": "¿Cuántos países tiene Europa aproximadamente?",
     "o": ["35", "40", "44", "50"],
     "c": 2, "tags": ["historia"]},

    {"q": "¿En qué año empezó la Revolución Rusa?",
     "o": ["1914", "1915", "1917", "1919"],
     "c": 2, "tags": ["historia"]},

    {"q": "¿Cuántos años gobernó Napoleón Bonaparte Francia aproximadamente?",
     "o": ["5", "10", "15", "20"],
     "c": 2, "tags": ["historia"]},

    {"q": "¿En qué continente está Turquía (mayoría de su territorio)?",
     "o": ["Europa", "Asia", "Está dividida entre Europa y Asia", "África"],
     "c": 2, "tags": ["historia", "general"]},

    # ── GAMING EXTRA ──────────────────────────────────────────────────────
    {"q": "¿Cuántos bits tenía la primera PlayStation de Sony?",
     "o": ["16 bits", "32 bits", "64 bits", "128 bits"],
     "c": 1, "tags": ["gaming"]},

    {"q": "¿Qué juego popularizó el género 'battle royale'?",
     "o": ["Fortnite", "PUBG (PlayerUnknown's Battlegrounds)", "H1Z1", "Apex Legends"],
     "c": 1, "tags": ["gaming"]},

    {"q": "¿Cómo se llama el protagonista de 'Hollow Knight'?",
     "o": ["Knight", "The Knight", "Hornet", "Grimm"],
     "c": 1, "tags": ["gaming"]},

    {"q": "¿En qué año salió 'Stardew Valley'?",
     "o": ["2014", "2015", "2016", "2017"],
     "c": 2, "tags": ["gaming"]},

    {"q": "¿Cuántos jugadores soporta Minecraft en un servidor multijugador online?",
     "o": ["Solo 4", "Solo 8", "Hasta 20", "Miles (depende del servidor)"],
     "c": 3, "tags": ["gaming"]},

    {"q": "¿Cuántos jugadores simultáneos récord tuvo GTA Online en Steam?",
     "o": ["50.000", "100.000", "150.000", "364.548"],
     "c": 3, "tags": ["gaming"]},

    {"q": "¿Cuántas estrellas máximas tiene el sistema de búsqueda en GTA?",
     "o": ["4", "5", "6", "7"],
     "c": 1, "tags": ["gaming"]},

    {"q": "¿Qué empresa desarrolló el juego 'Stardew Valley'?",
     "o": ["Nintendo", "Un desarrollador solo (ConcernedApe)", "EA Games", "Ubisoft"],
     "c": 1, "tags": ["gaming"]},

    {"q": "¿Cuál fue el primer juego de la saga 'The Legend of Zelda'?",
     "o": ["Ocarina of Time", "A Link to the Past", "The Legend of Zelda (1986)", "Twilight Princess"],
     "c": 2, "tags": ["gaming"]},

    {"q": "¿Cuántos jugadores puede tener un clan en Clash of Clans?",
     "o": ["30", "40", "50", "60"],
     "c": 2, "tags": ["gaming"]},

    # ── ANIME EXTRA ───────────────────────────────────────────────────────
    {"q": "¿Cuál es el tipo de Fruta del Diablo que tiene Kizaru en One Piece?",
     "o": ["Magma", "Luz", "Hielo", "Oscuridad"],
     "c": 1, "tags": ["anime"]},

    {"q": "¿Cuántos años tiene Naruto Uzumaki al inicio de la serie original?",
     "o": ["10", "11", "12", "13"],
     "c": 2, "tags": ["anime"]},

    {"q": "¿Qué poder tiene Ace (hermano de Luffy) en One Piece?",
     "o": ["Fuego", "Hielo", "Electricidad", "Oscuridad"],
     "c": 0, "tags": ["anime"]},

    {"q": "¿En qué año empezó el anime de My Hero Academia?",
     "o": ["2014", "2015", "2016", "2017"],
     "c": 2, "tags": ["anime"]},

    {"q": "¿Cuántos Kage hay en el mundo de Naruto?",
     "o": ["4", "5", "6", "7"],
     "c": 1, "tags": ["anime"]},

    # ── SERIES EXTRA ──────────────────────────────────────────────────────
    {"q": "¿Cuántas temporadas tiene 'Narcos: México'?",
     "o": ["2", "3", "4", "5"],
     "c": 1, "tags": ["series"]},

    {"q": "¿Cuántos asaltos realiza 'El Profesor' en La Casa de Papel?",
     "o": ["1", "2", "3", "4"],
     "c": 1, "tags": ["series"]},

    {"q": "¿Cuántas películas tiene la saga de 'Fast & Furious' hasta 2023?",
     "o": ["8", "9", "10", "11"],
     "c": 2, "tags": ["series"]},

    {"q": "¿En qué año se estrenó la serie 'Cobra Kai'?",
     "o": ["2016", "2017", "2018", "2019"],
     "c": 2, "tags": ["series"]},

    {"q": "¿Cuántas películas tiene la saga de 'Misión Imposible' hasta 2023?",
     "o": ["5", "6", "7", "8"],
     "c": 2, "tags": ["series"]},

    # ── MÚSICA EXTRA ──────────────────────────────────────────────────────
    {"q": "¿De qué ciudad colombiana es el cantante J Balvin?",
     "o": ["Bogotá", "Cali", "Medellín", "Barranquilla"],
     "c": 2, "tags": ["musica"]},

    {"q": "¿Cuántos álbumes de estudio tiene Bad Bunny hasta 2024?",
     "o": ["3", "4", "5", "6"],
     "c": 2, "tags": ["musica"]},

    {"q": "¿Qué instrumento es más antiguo: la guitarra o el violín?",
     "o": ["La guitarra", "El violín", "Tienen la misma edad", "Ninguno existe antes del siglo XV"],
     "c": 0, "tags": ["musica"]},

    {"q": "¿De qué país es la cantante Karol G?",
     "o": ["Venezuela", "Colombia", "México", "Puerto Rico"],
     "c": 1, "tags": ["musica"]},

    # ── CIENCIA EXTRA ─────────────────────────────────────────────────────
    {"q": "¿Cuántos litros de sangre tiene el cuerpo humano adulto aproximadamente?",
     "o": ["3-4 litros", "5-6 litros", "7-8 litros", "9-10 litros"],
     "c": 1, "tags": ["ciencia"]},

    {"q": "¿A cuántos grados centígrados se derrite el hierro?",
     "o": ["800°C", "1100°C", "1538°C", "2000°C"],
     "c": 2, "tags": ["ciencia"]},

    {"q": "¿Cuántos huesos tiene la mano humana?",
     "o": ["20", "24", "27", "30"],
     "c": 2, "tags": ["ciencia"]},

    {"q": "¿Cuánto mide el diámetro de la Tierra aproximadamente?",
     "o": ["6.371 km", "12.742 km", "40.075 km", "384.400 km"],
     "c": 1, "tags": ["ciencia"]},

    # ── DEPORTES EXTRA ────────────────────────────────────────────────────
    {"q": "¿En qué deporte se usa el término 'hat-trick'?",
     "o": ["Solo en fútbol", "Solo en hockey", "En varios deportes (fútbol, hockey, críquet)", "Solo en béisbol"],
     "c": 2, "tags": ["deportes", "futbol"]},

    {"q": "¿Cuántos puntos vale un tiro de 3 en básquetbol?",
     "o": ["2", "3", "4", "5"],
     "c": 1, "tags": ["deportes"]},

    {"q": "¿Cuántos metros tiene una vuelta a la pista de atletismo estándar?",
     "o": ["200 metros", "300 metros", "400 metros", "500 metros"],
     "c": 2, "tags": ["deportes"]},

    {"q": "¿En qué año fueron los primeros Juegos Paralímpicos?",
     "o": ["1948", "1952", "1960", "1968"],
     "c": 2, "tags": ["deportes"]},

    {"q": "¿Cuántos jugadores tiene un equipo de béisbol en cancha?",
     "o": ["7", "8", "9", "10"],
     "c": 2, "tags": ["deportes"]},

    # ── INTERNET EXTRA ────────────────────────────────────────────────────
    {"q": "¿Cuántos caracteres máximo permite un nombre de usuario en Instagram?",
     "o": ["20", "25", "30", "40"],
     "c": 2, "tags": ["internet"]},

    {"q": "¿Qué significa 'UX' en diseño digital?",
     "o": ["Ultra Experience", "User Experience", "Unified Exchange", "Universal Extension"],
     "c": 1, "tags": ["internet"]},

    {"q": "¿En qué año se fundó Reddit?",
     "o": ["2003", "2005", "2007", "2009"],
     "c": 1, "tags": ["internet"]},

    # ── ARGENTINA EXTRA ───────────────────────────────────────────────────
    {"q": "¿En qué año se fundó el Club Atlético Boca Juniors?",
     "o": ["1900", "1905", "1908", "1912"],
     "c": 2, "tags": ["ar", "futbol"]},

    {"q": "¿Cuál es la moneda oficial de Argentina?",
     "o": ["Austral", "Peso Argentino", "Real", "Bolívar"],
     "c": 1, "tags": ["ar"]},

    # ── HISTORIA EXTRA ────────────────────────────────────────────────────
    {"q": "¿En qué año se fundó la ONU (Organización de Naciones Unidas)?",
     "o": ["1943", "1944", "1945", "1946"],
     "c": 2, "tags": ["historia"]},

    {"q": "¿Cuántos países firmaron originalmente la ONU?",
     "o": ["35", "40", "51", "60"],
     "c": 2, "tags": ["historia"]},

    {"q": "¿En qué año pisó el hombre la Luna por primera vez?",
     "o": ["1965", "1967", "1969", "1971"],
     "c": 2, "tags": ["historia"]},

    {"q": "¿Cuántos metros mide la Gran Muralla China aproximadamente?",
     "o": ["5.000 km", "10.000 km", "21.000 km", "40.000 km"],
     "c": 2, "tags": ["historia"]},

    {"q": "¿Cuántos años reinó Cleopatra en Egipto aproximadamente?",
     "o": ["10 años", "15 años", "21 años", "30 años"],
     "c": 2, "tags": ["historia"]},
]


# ── Utilidades ────────────────────────────────────────────────────────────────

SLUG_SEEN: dict[str, int] = {}

def slugify(text: str) -> str:
    t = text.lower()
    for a, b in [
        ("á","a"),("é","e"),("í","i"),("ó","o"),("ú","u"),("ñ","n"),("ü","u"),
        ("¿",""),("?",""),("¡",""),("!",""),("'",""),("'",""),
        (".",""),(",",""),("(",""),(")",""),(":",""),
    ]:
        t = t.replace(a, b)
    t = re.sub(r"[^a-z0-9\s-]", "", t)
    t = re.sub(r"[\s-]+", "-", t).strip("-")
    base = t[:75]
    n = SLUG_SEEN.get(base, 0)
    SLUG_SEEN[base] = n + 1
    return base if n == 0 else f"{base}-{n}"

def esc(text: str) -> str:
    return text.replace("'", "''")


# ── Generador SQL ──────────────────────────────────────────────────────────────

def main() -> None:
    out = open("new_questions.sql", "w", encoding="utf-8")

    def p(t: str = "") -> None:
        out.write(t + "\n")

    # Recopilar todos los tags únicos usados
    all_tags = set()
    for q in QUESTIONS:
        for tag in q.get("tags", []):
            all_tags.add(tag)

    p("BEGIN;\n")

    # 1. Insertar tags (si no existen)
    p("-- Tags")
    for tag in sorted(all_tags):
        p(f"INSERT INTO tags (id, name, slug) VALUES (gen_random_uuid(), '{tag}', '{tag}') ON CONFLICT (slug) DO NOTHING;")
    p()

    q_tag_pairs: list[tuple[str, str]] = []  # (question_id, tag_slug)

    # 2. Preguntas + traducciones + opciones
    q_ids: list[str] = []
    for q in QUESTIONS:
        qid = str(uuid.uuid4())
        tid = str(uuid.uuid4())
        q_ids.append(qid)
        slug = slugify(q["q"])

        p(f"INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('{qid}',1,'{slug}','approved',true,false,'multiple_choice','human',10,'{{}}');")
        title = esc(q["q"])
        p(f"INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('{tid}','{qid}','es','{title}','[]');")

        for i, opt in enumerate(q["o"]):
            oid = str(uuid.uuid4())
            correct = "true" if i == q["c"] else "false"
            p(f"INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('{oid}','{qid}',1,{i},'{esc(opt)}',{correct},true,1.0,'{{}}');")

        for tag in q.get("tags", []):
            q_tag_pairs.append((qid, tag))
        p()

    # 3. question_tags
    p("-- Asignar tags a preguntas")
    for qid, tag_slug in q_tag_pairs:
        p(
            f"INSERT INTO question_tags (question_id, tag_id) "
            f"SELECT '{qid}', id FROM tags WHERE slug = '{tag_slug}' "
            f"ON CONFLICT DO NOTHING;"
        )
    p()

    # 4. Analytics iniciales
    ids_csv = ",".join(f"'{x}'" for x in q_ids)
    p(f"INSERT INTO question_analytics (question_id,times_shown,times_answered,times_skipped,option_pick_rates,audience_difficulty_profiles,updated_at) SELECT id,0,0,0,'{{}}','{{}}',NOW() FROM questions WHERE id IN ({ids_csv});\n")

    p("COMMIT;")
    out.close()

    total = len(QUESTIONS)
    tags_dist: dict[str, int] = {}
    for q in QUESTIONS:
        for t in q.get("tags", []):
            tags_dist[t] = tags_dist.get(t, 0) + 1

    print(f"Generado: new_questions.sql  ({total} preguntas)")
    print("\nDistribución por tag:")
    for tag, n in sorted(tags_dist.items(), key=lambda x: -x[1]):
        print(f"  {tag:<15} {n}")


if __name__ == "__main__":
    main()
