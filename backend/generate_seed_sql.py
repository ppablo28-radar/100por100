"""
Genera SQL con las 193 preguntas del JSON para pegar en el SQL Editor de Supabase.

Uso:
    python generate_seed_sql.py > seed_data.sql
"""
import json
import re
import uuid

SLUG_COUNTER: dict[str, int] = {}


def slugify(text: str) -> str:
    text = text.lower()
    for old, new in [
        ("á", "a"), ("é", "e"), ("í", "i"), ("ó", "o"), ("ú", "u"),
        ("ñ", "n"), ("ü", "u"), ("ç", "c"),
        ("¿", ""), ("?", ""), ("¡", ""), ("!", ""), ("'", ""), ("'", ""),
        ("%", "pct"), ("°", ""), ("×", "x"),
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


OUT_FILE = "seed_data.sql"


def main() -> None:
    with open("app/questions.json", encoding="utf-8") as f:
        questions = json.load(f)

    out = open(OUT_FILE, "w", encoding="utf-8")

    def p(text: str = "") -> None:
        out.write(text + "\n")

    p("BEGIN;\n")

    q_ids: list[str] = []

    for q in questions:
        q_id = str(uuid.uuid4())
        t_id  = str(uuid.uuid4())
        q_ids.append(q_id)
        slug  = slugify(q["question"])
        title = esc(q["question"])

        p(
            f"INSERT INTO questions "
            f"(id, version, slug, status, enabled, archived, answer_mode, "
            f"created_by_type, default_duration_seconds, metadata) VALUES "
            f"('{q_id}', 1, '{slug}', 'approved', true, false, "
            f"'multiple_choice', 'human', 10, '{{}}');"
        )

        p(
            f"INSERT INTO question_translations "
            f"(id, question_id, language, title, keywords) VALUES "
            f"('{t_id}', '{q_id}', 'es', '{title}', '[]');"
        )

        for i, option_text in enumerate(q["options"]):
            opt_id     = str(uuid.uuid4())
            is_correct = "true" if i == q["correct"] else "false"
            opt_text   = esc(option_text)
            p(
                f"INSERT INTO answer_options "
                f"(id, question_id, version, display_order, text, "
                f"is_correct, enabled, weight, metadata) VALUES "
                f"('{opt_id}', '{q_id}', 1, {i}, '{opt_text}', "
                f"{is_correct}, true, 1.0, '{{}}');"
            )

        p()

    # Inicializar analytics en 0 para cada pregunta
    ids_list = ", ".join(f"'{q_id}'" for q_id in q_ids)
    p(
        f"INSERT INTO question_analytics "
        f"(question_id, times_shown, times_answered, times_skipped, "
        f"option_pick_rates, audience_difficulty_profiles, updated_at) "
        f"SELECT id, 0, 0, 0, '{{}}', '{{}}', NOW() "
        f"FROM questions WHERE id IN ({ids_list});\n"
    )

    p("COMMIT;")
    p(f"\n-- {len(questions)} preguntas insertadas.")
    out.close()
    print(f"Generado: {OUT_FILE}  ({len(questions)} preguntas)")


if __name__ == "__main__":
    main()
