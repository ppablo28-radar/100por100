-- ══════════════════════════════════════════════════════════════
--  100×100 — Estadísticas completas de la base de datos
--  Pegar en Supabase → SQL Editor → Run
-- ══════════════════════════════════════════════════════════════


-- ── 1. RESUMEN TOTAL ───────────────────────────────────────────
SELECT
  COUNT(*)                                                   AS total_preguntas,
  COUNT(*) FILTER (WHERE status = 'approved' AND enabled)   AS aprobadas_activas,
  COUNT(*) FILTER (WHERE status = 'draft')                   AS en_borrador,
  COUNT(*) FILTER (WHERE status = 'rejected')                AS rechazadas,
  COUNT(*) FILTER (WHERE archived)                           AS archivadas,
  COUNT(*) FILTER (WHERE NOT enabled AND NOT archived)       AS deshabilitadas
FROM questions;


-- ── 2. DISTRIBUCIÓN POR ESTADO ────────────────────────────────
SELECT
  status,
  COUNT(*)                                                        AS cantidad,
  ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER())::numeric, 1)   AS porcentaje
FROM questions
GROUP BY status
ORDER BY cantidad DESC;


-- ── 3. TIPO DE RESPUESTA ──────────────────────────────────────
SELECT
  answer_mode,
  COUNT(*) AS cantidad
FROM questions
GROUP BY answer_mode
ORDER BY cantidad DESC;


-- ── 4. CREADOR (humano vs IA) ─────────────────────────────────
SELECT
  created_by_type,
  COUNT(*) AS cantidad
FROM questions
GROUP BY created_by_type;


-- ── 5. TRADUCCIONES POR IDIOMA ────────────────────────────────
SELECT
  language,
  COUNT(*) AS traducciones
FROM question_translations
GROUP BY language
ORDER BY traducciones DESC;


-- ── 6. OPCIONES DE RESPUESTA ──────────────────────────────────
SELECT
  COUNT(*)                                    AS total_opciones,
  ROUND(AVG(opts_por_pregunta)::numeric, 1)   AS promedio_por_pregunta,
  MIN(opts_por_pregunta)                      AS minimo,
  MAX(opts_por_pregunta)                      AS maximo
FROM (
  SELECT question_id, COUNT(*) AS opts_por_pregunta
  FROM   answer_options
  WHERE  enabled = true
  GROUP  BY question_id
) t;

-- Distribución exacta
SELECT
  opts_por_pregunta AS opciones,
  COUNT(*)          AS preguntas
FROM (
  SELECT question_id, COUNT(*) AS opts_por_pregunta
  FROM   answer_options
  WHERE  enabled = true
  GROUP  BY question_id
) t
GROUP BY opts_por_pregunta
ORDER BY opciones;


-- ── 7. ANALYTICS GLOBALES ─────────────────────────────────────
SELECT
  COUNT(*)                                                    AS preguntas_con_analytics,
  COUNT(*) FILTER (WHERE times_answered > 0)                  AS jugadas_al_menos_1_vez,
  COALESCE(SUM(times_shown),    0)                            AS total_veces_mostradas,
  COALESCE(SUM(times_answered), 0)                            AS total_respuestas,
  COALESCE(SUM(times_skipped),  0)                            AS total_saltadas,
  ROUND(
    (AVG(correct_rate) FILTER (WHERE times_answered > 0) * 100)::numeric, 1
  )                                                           AS pct_acierto_promedio,
  ROUND(
    (AVG(average_response_time_ms) FILTER (WHERE times_answered > 0) / 1000.0)::numeric, 1
  )                                                           AS segundos_respuesta_promedio
FROM question_analytics;


-- ── 8. CATEGORÍAS Y CUÁNTAS PREGUNTAS TIENEN ──────────────────
SELECT
  c.name                        AS categoria,
  c.slug,
  c.enabled,
  COUNT(qc.question_id)         AS preguntas_asignadas
FROM      categories c
LEFT JOIN question_categories qc ON c.id = qc.category_id
GROUP BY  c.id, c.name, c.slug, c.enabled
ORDER BY  preguntas_asignadas DESC;


-- ── 9. TAGS ───────────────────────────────────────────────────
SELECT
  t.name                   AS tag,
  COUNT(qt.question_id)    AS preguntas
FROM      tags t
LEFT JOIN question_tags qt ON t.id = qt.tag_id
GROUP BY  t.id, t.name
ORDER BY  preguntas DESC;


-- ── 10. TOP 15 PREGUNTAS MÁS JUGADAS ─────────────────────────
SELECT
  tr.title,
  qa.times_shown                                              AS vistas,
  qa.times_answered                                           AS respondidas,
  ROUND((qa.correct_rate * 100)::numeric, 1)                  AS pct_acierto,
  ROUND((qa.average_response_time_ms / 1000.0)::numeric, 1)   AS seg_promedio
FROM      question_analytics qa
JOIN      question_translations tr ON tr.question_id = qa.question_id
                                   AND tr.language = 'es'
WHERE     qa.times_answered > 0
ORDER BY  qa.times_answered DESC
LIMIT 15;


-- ── 11. TOP 10 MÁS DIFÍCILES (mín. 5 respuestas) ─────────────
SELECT
  tr.title,
  ROUND((qa.correct_rate * 100)::numeric, 1)                  AS pct_acierto,
  qa.times_answered                                           AS respondidas,
  ROUND((qa.average_response_time_ms / 1000.0)::numeric, 1)   AS seg_promedio
FROM      question_analytics qa
JOIN      question_translations tr ON tr.question_id = qa.question_id
                                   AND tr.language = 'es'
WHERE     qa.times_answered >= 5
ORDER BY  qa.correct_rate ASC
LIMIT 10;


-- ── 12. TOP 10 MÁS FÁCILES (mín. 5 respuestas) ───────────────
SELECT
  tr.title,
  ROUND((qa.correct_rate * 100)::numeric, 1)   AS pct_acierto,
  qa.times_answered                            AS respondidas
FROM      question_analytics qa
JOIN      question_translations tr ON tr.question_id = qa.question_id
                                   AND tr.language = 'es'
WHERE     qa.times_answered >= 5
ORDER BY  qa.correct_rate DESC
LIMIT 10;


-- ── 13. PREGUNTAS QUE NADIE RESPONDIÓ BIEN ───────────────────
SELECT
  tr.title,
  qa.times_answered AS respondidas
FROM      question_analytics qa
JOIN      question_translations tr ON tr.question_id = qa.question_id
                                   AND tr.language = 'es'
WHERE     qa.times_answered >= 3
  AND     qa.correct_rate = 0
ORDER BY  qa.times_answered DESC;


-- ── 14. PREGUNTAS MÁS RÁPIDAS DE RESPONDER ───────────────────
SELECT
  tr.title,
  ROUND((qa.average_response_time_ms / 1000.0)::numeric, 1)   AS seg_promedio,
  ROUND((qa.correct_rate * 100)::numeric, 1)                   AS pct_acierto
FROM      question_analytics qa
JOIN      question_translations tr ON tr.question_id = qa.question_id
                                   AND tr.language = 'es'
WHERE     qa.times_answered >= 5
ORDER BY  qa.average_response_time_ms ASC
LIMIT 10;
