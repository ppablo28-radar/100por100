"""
Preguntas raras, graciosas y sorprendentes para generar momentos épicos.
Uso: python seed_funny_questions.py > funny_questions.sql
"""
import re, uuid

QUESTIONS = [
    # ── TRAMPA / SORPRESA ──────────────────────────────────────────────────
    {"q": "¿De qué color es el caballo blanco de Napoleón?", "o": ["Marrón", "Negro", "Blanco", "Gris"], "c": 2},
    {"q": "¿Cuánto pesa 1 kg de plumas vs 1 kg de hierro?", "o": ["El hierro pesa más", "Las plumas pesan más", "Pesan igual", "Depende de la altitud"], "c": 2},
    {"q": "¿Cuántos meses del año tienen 28 días?", "o": ["Solo febrero", "Los meses pares", "Todos los meses", "Solo en años bisiestos"], "c": 2},
    {"q": "¿Si tirás una piedra al mar, qué queda?", "o": ["Un hoyo en el agua", "Ondas", "La piedra en el fondo", "Un mojado"], "c": 2},
    {"q": "Un granjero tiene 17 ovejas. Todas menos 9 mueren. ¿Cuántas quedan?", "o": ["8", "9", "17", "0"], "c": 1},
    {"q": "¿Qué es más pesado: un kilo de algodón o un kilo de plomo?", "o": ["El plomo", "El algodón", "Pesan igual", "El que llegue primero"], "c": 2},
    {"q": "¿Qué hace una vaca mirando hacia el norte?", "o": ["Muge al norte", "Nada especial", "Se orienta", "La cola apunta al sur"], "c": 1},
    {"q": "¿Cuántos animales de cada especie llevó Moisés en el arca?", "o": ["2", "7", "14", "Ninguno, fue Noé"], "c": 3},
    {"q": "¿En qué año ocurrió la Batalla de 1814?", "o": ["1812", "1813", "1814", "1815"], "c": 2},
    {"q": "¿Puede un hombre casarse con la hermana de su viuda?", "o": ["Sí en algunos países", "No es legal", "No, porque estaría muerto", "Solo en Las Vegas"], "c": 2},
    {"q": "¿Cuántos países tiene América del Sur que empiezan con 'K'?", "o": ["0", "1", "2", "3"], "c": 0},
    {"q": "Un avión cae exactamente en la frontera entre Argentina y Chile. ¿Dónde entierran a los sobrevivientes?", "o": ["Argentina", "Chile", "A los muertos, no a los sobrevivientes", "Mitad y mitad"], "c": 2},
    {"q": "¿Qué es más rápido: ¿calor o frío?", "o": ["El frío", "El calor", "Son iguales", "El calor, porque podés atrapar un resfriado"], "c": 3},
    {"q": "¿Cuántos lados tiene un círculo?", "o": ["0", "1", "2", "Infinitos"], "c": 1},
    {"q": "Si hay 3 manzanas y sacás 2, ¿cuántas tenés vos?", "o": ["1", "2", "3", "Ninguna"], "c": 1},

    # ── DATOS INCREÍBLES / SORPRENDENTES ───────────────────────────────────
    {"q": "¿Cuántas veces por segundo parpadea un ser humano en promedio?", "o": ["2-4 veces", "5-8 veces", "15-20 veces", "30-40 veces"], "c": 2},
    {"q": "¿Cuántas veces más fuerte que el acero puede ser la seda de araña?", "o": ["Igual", "2 veces", "5 veces", "Hasta 5 veces más resistente"], "c": 3},
    {"q": "¿Qué color tiene la sangre de un pulpo?", "o": ["Roja", "Azul", "Verde", "Transparente"], "c": 1},
    {"q": "¿Cuántos cerebros tiene un pulpo?", "o": ["1", "2", "3", "9 (uno central + uno en cada tentáculo)"], "c": 3},
    {"q": "¿A cuántos km/h puede estornudar un humano?", "o": ["50 km/h", "100 km/h", "150 km/h", "160 km/h"], "c": 3},
    {"q": "¿Cuánto tiempo puede sobrevivir una cucaracha sin cabeza?", "o": ["Segundos", "Minutos", "Horas", "Semanas"], "c": 3},
    {"q": "¿Cuántos años puede vivir una almeja?", "o": ["5 años", "20 años", "100 años", "Más de 500 años"], "c": 3},
    {"q": "¿Cuántos huesos tiene una tiburón?", "o": ["100", "200", "500", "0 (son cartílago)"], "c": 3},
    {"q": "¿Qué animal tiene la lengua más larga del mundo en relación a su cuerpo?", "o": ["La jirafa", "El oso hormiguero", "El camaleón", "El pangolín"], "c": 2},
    {"q": "¿Cuántas veces el Sol cabe en Júpiter?", "o": ["El Sol es más grande", "10 veces", "Júpiter cabe en el Sol 1000 veces", "Tienen el mismo tamaño"], "c": 2},
    {"q": "¿Cuánto pesa el cerebro humano aproximadamente?", "o": ["500 gramos", "1 kg", "1.4 kg", "2 kg"], "c": 2},
    {"q": "¿Cuántos litros de saliva produce un humano al día?", "o": ["0.1 litros", "0.5 litros", "1-1.5 litros", "3 litros"], "c": 2},
    {"q": "¿A qué velocidad crecen las uñas humanas?", "o": ["1 cm por semana", "3 mm por mes", "1 cm por mes", "5 mm por semana"], "c": 1},
    {"q": "¿Cuántos olores distintos puede detectar la nariz humana?", "o": ["1,000", "10,000", "100,000", "Más de 1 billón"], "c": 3},
    {"q": "¿Cuántos latidos por minuto tiene el corazón de un colibrí?", "o": ["60-80", "150-200", "300-500", "Más de 1000"], "c": 3},
    {"q": "¿Cuántos gramos de oro hay en el cuerpo humano?", "o": ["0 gramos", "0.2 miligramos", "1 gramo", "5 gramos"], "c": 1},

    # ── ABSURDAS / DIVERTIDAS ──────────────────────────────────────────────
    {"q": "¿Cuántas pizzas se consumen por segundo en el mundo?", "o": ["10", "100", "350", "Más de 1000"], "c": 2},
    {"q": "¿Qué pasaría si todos saltaran al mismo tiempo?", "o": ["Un terremoto catastrófico", "Prácticamente nada", "La Tierra se mueve 1 mm", "Se rompe el eje terrestre"], "c": 1},
    {"q": "¿Cuántos años llevaría contar hasta 1 millón en voz alta?", "o": ["1 día", "1 semana", "Alrededor de 23 días", "1 año"], "c": 2},
    {"q": "¿En qué año se inventaron los lentes de sol?", "o": ["1900", "1920", "1929", "1950"], "c": 2},
    {"q": "¿Cuántas veces por hora puede mover las orejas un gato?", "o": ["No puede", "10 veces", "Más de 180 veces", "50 veces"], "c": 2},
    {"q": "¿Cuántos fotones del Sol llegan a la Tierra por segundo?", "o": ["Millones", "Billones", "Cuatrillones", "Una cantidad incontable"], "c": 3},
    {"q": "¿Cuántos idiomas tiene más de 1 millón de hablantes?", "o": ["23", "42", "Más de 80", "Más de 200"], "c": 2},
    {"q": "¿Cuántas canciones escucha el humano promedio en su vida?", "o": ["1,000", "10,000", "100,000", "Más de 1 millón"], "c": 3},
    {"q": "¿A qué temperatura vive una bacteria extremófila resistente al calor?", "o": ["50°C", "80°C", "100°C", "Más de 121°C"], "c": 3},
    {"q": "¿Cuántos colores puede ver un mantis camarón?", "o": ["Los mismos que un humano", "El doble que un humano", "3 veces más", "16 tipos de receptores de color"], "c": 3},
    {"q": "¿Qué porcentaje del ADN humano compartimos con un plátano?", "o": ["5%", "20%", "50%", "60%"], "c": 3},
    {"q": "¿Cuántas veces puede doblarse un papel en la misma dirección?", "o": ["Sin límite", "100 veces", "Máximo 7-8 veces", "50 veces"], "c": 2},
    {"q": "¿Cuánto pesaría el cerebro de Homer Simpson?", "o": ["Igual que el nuestro", "La mitad", "El doble", "Homer no tiene cerebro"], "c": 0},
    {"q": "¿Cuántos Pikachus entrarían en un estadio de 100,000 personas?", "o": ["Igual que personas", "Muchos más", "Muchos menos", "Depende del nivel de Pikachu"], "c": 1},
    {"q": "¿En qué idioma dicen '¿Por qué?' de la forma más corta del mundo?", "o": ["Chino", "Japonés", "Mandarín", "En chino: '为什么' (wèishéme)"], "c": 3},
]

SLUG_SEEN: dict[str, int] = {}

def slugify(text: str) -> str:
    text = text.lower()
    for old, new in [
        ("á","a"),("é","e"),("í","i"),("ó","o"),("ú","u"),("ñ","n"),("ü","u"),
        ("¿",""),("?",""),("¡",""),("!",""),("'",""),("'",""),("%","pct"),("°",""),("×","x"),
        ("'",""),
    ]:
        text = text.replace(old, new)
    import re as _re
    text = _re.sub(r"[^a-z0-9\s-]", "", text)
    text = _re.sub(r"[\s-]+", "-", text).strip("-")
    base = text[:75]
    count = SLUG_SEEN.get(base, 0)
    SLUG_SEEN[base] = count + 1
    return base if count == 0 else f"{base}-{count}"

def esc(t: str) -> str:
    return t.replace("'", "''")

def main() -> None:
    out = open("funny_questions.sql", "w", encoding="utf-8")
    def p(t: str = "") -> None:
        out.write(t + "\n")

    p("BEGIN;\n")
    q_ids: list[str] = []

    for q in QUESTIONS:
        qid = str(uuid.uuid4())
        tid = str(uuid.uuid4())
        q_ids.append(qid)
        slug  = slugify(q["q"])
        title = esc(q["q"])

        p(f"INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('{qid}',1,'{slug}','approved',true,false,'multiple_choice','human',10,'{{}}');")
        p(f"INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('{tid}','{qid}','es','{title}','[]');")
        for i, opt in enumerate(q["o"]):
            oid = str(uuid.uuid4())
            correct = "true" if i == q["c"] else "false"
            p(f"INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('{oid}','{qid}',1,{i},'{esc(opt)}',{correct},true,1.0,'{{}}');")
        p()

    ids = ",".join(f"'{x}'" for x in q_ids)
    p(f"INSERT INTO question_analytics (question_id,times_shown,times_answered,times_skipped,option_pick_rates,audience_difficulty_profiles,updated_at) SELECT id,0,0,0,'{{}}','{{}}',NOW() FROM questions WHERE id IN ({ids});\n")
    p("COMMIT;")
    out.close()
    print(f"Generado: funny_questions.sql  ({len(QUESTIONS)} preguntas)")

if __name__ == "__main__":
    main()
