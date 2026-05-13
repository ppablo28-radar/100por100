"""
Valida la integridad de questions.json.

Checks:
  - Campos requeridos: question, options, correct, tags
  - options tiene exactamente 4 items
  - correct es entero 0-3
  - tags es lista no vacía con strings válidos
  - No hay preguntas duplicadas
  - El índice correct apunta a una opción no vacía

Uso:
  python validate_questions.py [ruta_al_json]
"""

import json
import sys

VALID_TAGS = {"general", "bahia_blanca"}


def validate(filepath: str) -> bool:
    with open(filepath, encoding="utf-8") as f:
        try:
            questions = json.load(f)
        except json.JSONDecodeError as e:
            print(f"❌ JSON inválido: {e}")
            return False

    if not isinstance(questions, list):
        print("❌ El JSON debe ser un array")
        return False

    errors = []
    seen: dict[str, int] = {}

    for i, q in enumerate(questions):
        n = i + 1

        # Campos requeridos
        for field in ("question", "options", "correct", "tags"):
            if field not in q:
                errors.append(f"Q{n}: falta campo '{field}'")

        if "question" in q:
            if not isinstance(q["question"], str) or not q["question"].strip():
                errors.append(f"Q{n}: 'question' debe ser string no vacío")
            else:
                key = q["question"].strip().lower()
                if key in seen:
                    errors.append(
                        f"Q{n}: duplicada con Q{seen[key]} — '{q['question'][:60]}'"
                    )
                else:
                    seen[key] = n

        if "options" in q:
            opts = q["options"]
            if not isinstance(opts, list):
                errors.append(f"Q{n}: 'options' debe ser lista")
            elif len(opts) != 4:
                errors.append(f"Q{n}: 'options' tiene {len(opts)} items (esperado 4)")
            else:
                for j, opt in enumerate(opts):
                    if not isinstance(opt, str) or not opt.strip():
                        errors.append(f"Q{n}: opción [{j}] está vacía o no es string")

        if "correct" in q:
            c = q["correct"]
            if not isinstance(c, int) or not (0 <= c <= 3):
                errors.append(f"Q{n}: 'correct'={c!r} debe ser entero 0-3")
            elif "options" in q and isinstance(q["options"], list) and len(q["options"]) == 4:
                answer_text = q["options"][c]
                if not answer_text.strip():
                    errors.append(f"Q{n}: la respuesta correcta (índice {c}) está vacía")

        if "tags" in q:
            tags = q["tags"]
            if not isinstance(tags, list) or len(tags) == 0:
                errors.append(f"Q{n}: 'tags' debe ser lista no vacía")
            else:
                for tag in tags:
                    if tag not in VALID_TAGS:
                        errors.append(
                            f"Q{n}: tag desconocido '{tag}' — válidos: {sorted(VALID_TAGS)}"
                        )

    if errors:
        print(f"\n❌  {len(errors)} error(es) encontrado(s) en {filepath}:\n")
        for e in errors:
            print(f"   {e}")
        print()
        return False

    # Resumen exitoso
    by_tag: dict[str, int] = {}
    for q in questions:
        for tag in q.get("tags", []):
            by_tag[tag] = by_tag.get(tag, 0) + 1

    print(f"\n✅  {len(questions)} preguntas válidas en {filepath}\n")
    for tag in sorted(by_tag):
        print(f"   [{tag}]: {by_tag[tag]} preguntas")
    print()
    return True


if __name__ == "__main__":
    path = sys.argv[1] if len(sys.argv) > 1 else "app/questions.json"
    ok = validate(path)
    sys.exit(0 if ok else 1)
