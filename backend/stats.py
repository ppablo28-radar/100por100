"""
Estadísticas completas de preguntas en Supabase.

Uso:
    python stats.py

Requiere en .env:
    SUPABASE_URL = https://hfldkqfxtvhlnkgyjtil.supabase.co
    SUPABASE_KEY = sb_publishable_...   (clave anon del proyecto)
"""
import os
import sys
from collections import Counter
from urllib import request as urllib_request
from urllib.error import HTTPError
import json as json_lib

sys.stdout.reconfigure(encoding="utf-8")

try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass  # python-dotenv ya está instalado, pero por si acaso

SUPABASE_URL = os.getenv("SUPABASE_URL", "").rstrip("/")
SUPABASE_KEY = os.getenv("SUPABASE_KEY", "")


# ── Helpers ──────────────────────────────────────────────────────────────────

def fetch(table: str, select: str = "*", filters: dict | None = None) -> list[dict]:
    """GET /rest/v1/{table} con paginación automática."""
    params = f"select={select}"
    if filters:
        for k, v in filters.items():
            params += f"&{k}={v}"

    url = f"{SUPABASE_URL}/rest/v1/{table}?{params}"
    req = urllib_request.Request(url, headers={
        "apikey": SUPABASE_KEY,
        "Authorization": f"Bearer {SUPABASE_KEY}",
        "Range": "0-9999",
    })
    try:
        with urllib_request.urlopen(req) as resp:
            return json_lib.loads(resp.read())
    except HTTPError as e:
        print(f"❌ Error al consultar '{table}': {e.code} {e.reason}")
        return []


def sep(title: str) -> None:
    width = 56
    print(f"\n{'═' * width}")
    print(f"  {title}")
    print('─' * width)


def bar(value: int, total: int, width: int = 20) -> str:
    filled = int(value * width / total) if total else 0
    return "█" * filled + "░" * (width - filled)


# ── Main ─────────────────────────────────────────────────────────────────────

def main() -> None:
    if not SUPABASE_URL or not SUPABASE_KEY:
        print("❌  Faltan SUPABASE_URL o SUPABASE_KEY en el .env")
        print()
        print("  Agregá en backend/.env:")
        print("  SUPABASE_URL = https://hfldkqfxtvhlnkgyjtil.supabase.co")
        print("  SUPABASE_KEY = sb_publishable_...   (la clave anon de tu proyecto)")
        sys.exit(1)

    print()
    print("  100×100 — Estadísticas de la base de datos")
    print(f"  {SUPABASE_URL}")

    # ── Preguntas ─────────────────────────────────────────────────────
    questions = fetch(
        "questions",
        "id,status,enabled,archived,answer_mode,created_by_type"
    )
    total = len(questions)

    sep(f"TOTAL: {total} preguntas")

    # Por estado
    print("\n  Por estado:")
    for status, count in Counter(q["status"] for q in questions).most_common():
        pct = count * 100 // total if total else 0
        print(f"    {status:<14} {count:>4}  {bar(count, total)}  {pct}%")

    # Habilitadas/archivadas
    enabled  = sum(1 for q in questions if q.get("enabled"))
    archived = sum(1 for q in questions if q.get("archived"))
    print(f"\n  Habilitadas:    {enabled}")
    print(f"  Deshabilitadas: {total - enabled}")
    print(f"  Archivadas:     {archived}")

    # ── Traducciones ──────────────────────────────────────────────────
    sep("TRADUCCIONES")
    translations = fetch("question_translations", "question_id,language,title")
    lang_count = Counter(t["language"] for t in translations)
    for lang, count in lang_count.most_common():
        print(f"  {lang:<6}  {count:>4} traducciones  {bar(count, total)}")

    # ── Opciones de respuesta ─────────────────────────────────────────
    sep("OPCIONES DE RESPUESTA")
    options = fetch("answer_options", "question_id,is_correct,enabled")
    opts_per_q = Counter(o["question_id"] for o in options)
    if opts_per_q:
        counts = list(opts_per_q.values())
        print(f"  Total opciones:         {len(options)}")
        print(f"  Promedio por pregunta:  {sum(counts)/len(counts):.1f}")
        print(f"  Mínimo / Máximo:        {min(counts)} / {max(counts)}")
        print()
        print("  Distribución (cuántas preguntas tienen N opciones):")
        for n, qty in sorted(Counter(counts).items()):
            print(f"    {n} opciones → {qty:>4} preguntas  {bar(qty, total)}")
        correct_opts = sum(1 for o in options if o.get("is_correct"))
        print(f"\n  Opciones marcadas como correctas: {correct_opts}")
        print(f"  Promedio correctas/pregunta:      {correct_opts/total:.2f}")

    # ── Categorías ────────────────────────────────────────────────────
    sep("CATEGORÍAS")
    categories = fetch("categories", "id,name,slug,enabled")
    q_cats     = fetch("question_categories", "category_id")
    cat_counts = Counter(qc["category_id"] for qc in q_cats)
    if categories:
        print(f"  Total categorías creadas: {len(categories)}")
        for cat in sorted(categories, key=lambda c: -cat_counts.get(c["id"], 0)):
            n = cat_counts.get(cat["id"], 0)
            en = "✓" if cat.get("enabled") else "✗"
            print(f"  {en}  {cat['name']:<30} {n:>4} preguntas")
    else:
        print("  Sin categorías creadas todavía")
        print("  (Las preguntas se pueden categorizar desde el SQL Editor)")

    # ── Tags ──────────────────────────────────────────────────────────
    sep("TAGS")
    tags    = fetch("tags", "id,name")
    q_tags  = fetch("question_tags", "tag_id")
    tag_cnt = Counter(qt["tag_id"] for qt in q_tags)
    if tags:
        print(f"  Total tags: {len(tags)}")
        for tag in sorted(tags, key=lambda t: -tag_cnt.get(t["id"], 0)):
            print(f"    {tag['name']:<30} {tag_cnt.get(tag['id'], 0):>4} preguntas")
    else:
        print("  Sin tags creados todavía")

    # ── Analytics ─────────────────────────────────────────────────────
    sep("ANALYTICS DE PARTIDAS")
    analytics = fetch(
        "question_analytics",
        "question_id,times_shown,times_answered,times_skipped,"
        "correct_rate,average_response_time_ms,fun_score,difficulty_real"
    )
    played = [a for a in analytics if (a.get("times_answered") or 0) > 0]
    print(f"  Preguntas con registro analytics: {len(analytics)}")
    print(f"  Preguntas jugadas al menos 1 vez: {len(played)}")

    if played:
        shown    = sum(a.get("times_shown")    or 0 for a in analytics)
        answered = sum(a.get("times_answered") or 0 for a in analytics)
        skipped  = sum(a.get("times_skipped")  or 0 for a in analytics)
        print(f"\n  Total veces mostradas:     {shown:,}")
        print(f"  Total respondidas:         {answered:,}")
        print(f"  Total saltadas:            {skipped:,}")
        if answered:
            pct_ans = answered * 100 // shown if shown else 0
            print(f"  Tasa de respuesta:         {pct_ans}%")

        rates = [a["correct_rate"] for a in played if a.get("correct_rate") is not None]
        times = [a["average_response_time_ms"] for a in played
                 if a.get("average_response_time_ms") is not None]
        if rates:
            print(f"\n  % aciertos promedio:       {sum(rates)/len(rates)*100:.1f}%")
            print(f"  % aciertos más bajo:       {min(rates)*100:.1f}%")
            print(f"  % aciertos más alto:       {max(rates)*100:.1f}%")
        if times:
            print(f"\n  Tiempo respuesta promedio: {sum(times)/len(times)/1000:.1f}s")
            print(f"  Más rápida:                {min(times)/1000:.1f}s")
            print(f"  Más lenta:                 {max(times)/1000:.1f}s")
    else:
        print("\n  Las preguntas en Supabase todavía no tienen datos de partidas.")
        print("  Los analytics se llenaran a medida que se juegue.")

    # ── Top preguntas más jugadas ─────────────────────────────────────
    if played:
        sep("TOP 10 — MÁS JUGADAS")
        trans_map = {t["question_id"]: t["title"]
                     for t in translations if t["language"] == "es"}
        top = sorted(played, key=lambda a: -(a.get("times_answered") or 0))[:10]
        for i, a in enumerate(top, 1):
            title   = trans_map.get(a["question_id"], "?")[:42]
            shown   = a.get("times_shown") or 0
            ans     = a.get("times_answered") or 0
            rate    = a.get("correct_rate")
            pct_str = f"{rate*100:.0f}%" if rate is not None else "—"
            print(f"  {i:>2}. {title:<42}  vistas:{shown:>3}  aciertos:{pct_str}")

        sep("TOP 10 — MÁS DIFÍCILES (mín. 5 respuestas)")
        hard = sorted(
            [a for a in played
             if (a.get("times_answered") or 0) >= 5 and a.get("correct_rate") is not None],
            key=lambda a: a["correct_rate"]
        )[:10]
        if hard:
            for i, a in enumerate(hard, 1):
                title = trans_map.get(a["question_id"], "?")[:42]
                rate  = a["correct_rate"]
                ans   = a.get("times_answered") or 0
                print(f"  {i:>2}. {title:<42}  aciertos:{rate*100:.0f}%  n={ans}")
        else:
            print("  No hay preguntas con 5+ respuestas todavía")

    # ── Resumen final ─────────────────────────────────────────────────
    sep("RESUMEN")
    print(f"  📚  Total preguntas:           {total}")
    print(f"  ✅  Aprobadas y habilitadas:   {sum(1 for q in questions if q.get('status')=='approved' and q.get('enabled'))}")
    print(f"  🌐  Con traducción español:    {lang_count.get('es', 0)}")
    print(f"  🏷️   Con categorías:            {len(set(qc['category_id'] for qc in q_cats))}")
    print(f"  📊  Con registro de analytics: {len(analytics)}")
    print(f"  🎮  Jugadas al menos 1 vez:    {len(played)}")
    if played:
        total_plays = sum(a.get("times_answered") or 0 for a in played)
        print(f"  🏆  Total respuestas en DB:    {total_plays:,}")
    print()


if __name__ == "__main__":
    main()
