-- ══════════════════════════════════════════════════════════════
--  100×100 — Estadísticas completas (query única)
--  Supabase → SQL Editor → pegar todo → Run
-- ══════════════════════════════════════════════════════════════

WITH
-- ── Preguntas ────────────────────────────────────────────────
q_stats AS (
  SELECT
    COUNT(*)                                                 AS total,
    COUNT(*) FILTER (WHERE status = 'approved' AND enabled) AS aprobadas,
    COUNT(*) FILTER (WHERE status = 'draft')                 AS borrador,
    COUNT(*) FILTER (WHERE archived)                         AS archivadas,
    COUNT(*) FILTER (WHERE NOT enabled AND NOT archived)     AS deshabilitadas
  FROM questions
),

-- ── Por estado ───────────────────────────────────────────────
by_status AS (
  SELECT string_agg(status || ': ' || cnt::text, ' | ' ORDER BY cnt DESC) AS estados
  FROM (
    SELECT status, COUNT(*) AS cnt FROM questions GROUP BY status
  ) t
),

-- ── Por creador ──────────────────────────────────────────────
by_creator AS (
  SELECT string_agg(created_by_type || ': ' || cnt::text, ' | ') AS creadores
  FROM (
    SELECT created_by_type, COUNT(*) AS cnt FROM questions GROUP BY created_by_type
  ) t
),

-- ── Traducciones ─────────────────────────────────────────────
by_lang AS (
  SELECT string_agg(language || ': ' || cnt::text, ' | ' ORDER BY cnt DESC) AS idiomas
  FROM (
    SELECT language, COUNT(*) AS cnt FROM question_translations GROUP BY language
  ) t
),

-- ── Opciones ─────────────────────────────────────────────────
opt_stats AS (
  SELECT
    COUNT(*)                                  AS total_opciones,
    ROUND(AVG(opts)::numeric, 1)              AS promedio,
    MIN(opts)                                 AS minimo,
    MAX(opts)                                 AS maximo
  FROM (
    SELECT question_id, COUNT(*) AS opts
    FROM answer_options WHERE enabled GROUP BY question_id
  ) t
),

-- ── Analytics globales ───────────────────────────────────────
a_stats AS (
  SELECT
    COUNT(*)                                                        AS con_analytics,
    COUNT(*) FILTER (WHERE times_answered > 0)                      AS jugadas,
    COALESCE(SUM(times_shown), 0)                                   AS total_vistas,
    COALESCE(SUM(times_answered), 0)                                AS total_respuestas,
    ROUND(
      (AVG(correct_rate) FILTER (WHERE times_answered > 0) * 100)::numeric, 1
    )                                                               AS pct_acierto_prom,
    ROUND(
      (AVG(average_response_time_ms) FILTER (WHERE times_answered > 0) / 1000.0)::numeric, 1
    )                                                               AS seg_respuesta_prom
  FROM question_analytics
),

-- ── Top 10 más jugadas ───────────────────────────────────────
top_jugadas AS (
  SELECT string_agg(
    '#' || rn || ' ' || left(title, 40) || ' (' || respondidas || ' resp, ' || pct || '% ok)',
    E'\n    '
    ORDER BY rn
  ) AS top10_jugadas
  FROM (
    SELECT
      ROW_NUMBER() OVER (ORDER BY qa.times_answered DESC) AS rn,
      tr.title,
      qa.times_answered                                   AS respondidas,
      ROUND((qa.correct_rate * 100)::numeric, 0)          AS pct
    FROM question_analytics qa
    JOIN question_translations tr ON tr.question_id = qa.question_id AND tr.language = 'es'
    WHERE qa.times_answered > 0
    LIMIT 10
  ) t
),

-- ── Top 10 más difíciles (mín 5 respuestas) ─────────────────
top_dificiles AS (
  SELECT string_agg(
    '#' || rn || ' ' || left(title, 40) || ' (' || pct || '% ok, ' || respondidas || ' resp)',
    E'\n    '
    ORDER BY rn
  ) AS top10_dificiles
  FROM (
    SELECT
      ROW_NUMBER() OVER (ORDER BY qa.correct_rate ASC) AS rn,
      tr.title,
      qa.times_answered                                AS respondidas,
      ROUND((qa.correct_rate * 100)::numeric, 0)       AS pct
    FROM question_analytics qa
    JOIN question_translations tr ON tr.question_id = qa.question_id AND tr.language = 'es'
    WHERE qa.times_answered >= 5
    LIMIT 10
  ) t
),

-- ── Top 10 más fáciles ───────────────────────────────────────
top_faciles AS (
  SELECT string_agg(
    '#' || rn || ' ' || left(title, 40) || ' (' || pct || '% ok)',
    E'\n    '
    ORDER BY rn
  ) AS top10_faciles
  FROM (
    SELECT
      ROW_NUMBER() OVER (ORDER BY qa.correct_rate DESC) AS rn,
      tr.title,
      ROUND((qa.correct_rate * 100)::numeric, 0)        AS pct
    FROM question_analytics qa
    JOIN question_translations tr ON tr.question_id = qa.question_id AND tr.language = 'es'
    WHERE qa.times_answered >= 5
    LIMIT 10
  ) t
)

-- ══════ RESULTADO FINAL ══════════════════════════════════════
SELECT
  '=== PREGUNTAS ==='                                     AS seccion,
  'Total: ' || q.total
    || ' | Aprobadas: ' || q.aprobadas
    || ' | Borrador: ' || q.borrador
    || ' | Archivadas: ' || q.archivadas                  AS valor
FROM q_stats q

UNION ALL SELECT '  Por estado', s.estados FROM by_status s
UNION ALL SELECT '  Por creador', c.creadores FROM by_creator c
UNION ALL SELECT '  Por idioma', l.idiomas FROM by_lang l

UNION ALL SELECT '', ''

UNION ALL SELECT
  '=== OPCIONES ===',
  'Total: ' || o.total_opciones
    || ' | Promedio/pregunta: ' || o.promedio
    || ' | Min: ' || o.minimo
    || ' | Max: ' || o.maximo
FROM opt_stats o

UNION ALL SELECT '', ''

UNION ALL SELECT
  '=== ANALYTICS ===',
  'Con datos: ' || a.con_analytics
    || ' | Jugadas 1+ vez: ' || a.jugadas
    || ' | Total vistas: ' || a.total_vistas
    || ' | Total respuestas: ' || a.total_respuestas
FROM a_stats a

UNION ALL SELECT
  '  Rendimiento',
  CASE WHEN a.pct_acierto_prom IS NOT NULL
    THEN '% acierto prom: ' || a.pct_acierto_prom || '% | Seg respuesta prom: ' || a.seg_respuesta_prom || 's'
    ELSE '(sin partidas jugadas todavia)'
  END
FROM a_stats a

UNION ALL SELECT '', ''

UNION ALL SELECT
  '=== TOP 10 MÁS JUGADAS ===',
  COALESCE(t.top10_jugadas, '(sin datos todavia)')
FROM top_jugadas t

UNION ALL SELECT '', ''

UNION ALL SELECT
  '=== TOP 10 MÁS DIFÍCILES (min 5 resp) ===',
  COALESCE(t.top10_dificiles, '(se necesitan 5+ respuestas por pregunta)')
FROM top_dificiles t

UNION ALL SELECT '', ''

UNION ALL SELECT
  '=== TOP 10 MÁS FÁCILES (min 5 resp) ===',
  COALESCE(t.top10_faciles, '(se necesitan 5+ respuestas por pregunta)')
FROM top_faciles t;
