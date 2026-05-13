-- Seed del motor procedural de conocimiento
-- Pegá esto en Supabase → SQL Editor → New query → Run

-- ── Atributos ──────────────────────────────────────────────────────────────
INSERT INTO knowledge_attributes (id, slug, name, data_type, unit, metadata) VALUES
  (gen_random_uuid(), 'subscribers',   'Suscriptores',        'integer', 'millones',                  '{}'),
  (gen_random_uuid(), 'population',    'Población',           'integer', 'millones de personas',      '{}'),
  (gen_random_uuid(), 'area_km2',      'Superficie',          'float',   'km²',                       '{}'),
  (gen_random_uuid(), 'release_year',  'Año de lanzamiento',  'integer', 'año',                       '{}'),
  (gen_random_uuid(), 'goals_career',  'Goles en carrera',    'integer', 'goles',                     '{}'),
  (gen_random_uuid(), 'speed_kmh',     'Velocidad máxima',    'float',   'km/h',                      '{}'),
  (gen_random_uuid(), 'height_cm',     'Altura',              'integer', 'cm',                        '{}'),
  (gen_random_uuid(), 'units_sold_m',  'Unidades vendidas',   'float',   'millones',                  '{}'),
  (gen_random_uuid(), 'metacritic',    'Metacritic',          'integer', 'puntos',                    '{}'),
  (gen_random_uuid(), 'founded_year',  'Año de fundación',    'integer', 'año',                       '{}')
ON CONFLICT (slug) DO NOTHING;

-- ── YouTubers ──────────────────────────────────────────────────────────────
INSERT INTO knowledge_entities (id, entity_type, name, slug, kid_friendly, popularity_score, verified, language, metadata) VALUES
  (gen_random_uuid(), 'youtuber', 'MrBeast',         'mrbeast',         true, 40.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'youtuber', 'T-Series',        't-series',        true, 28.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'youtuber', 'Cocomelon',       'cocomelon',       true, 18.5, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'youtuber', 'SET India',       'set-india',       true, 17.5, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'youtuber', 'PewDiePie',       'pewdiepie',       true, 11.1, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'youtuber', 'Like Nastya',     'like-nastya',     true, 12.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'youtuber', 'Vlad y Niki',     'vlad-y-niki',    true, 11.5, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'youtuber', 'Kids Diana Show', 'kids-diana-show', true, 12.5, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'youtuber', 'Ibai',            'ibai',            true,  1.2, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'youtuber', 'ElRubius',        'elrubius',        true,  4.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'youtuber', 'Luisito Comunica','luisito-comunica', true, 4.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'youtuber', 'Auronplay',       'auronplay',       true,  3.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'youtuber', 'Vegetta777',      'vegetta777',      true,  3.3, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'youtuber', 'Willyrex',        'willyrex',        true,  1.7, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'youtuber', 'TheGrefg',        'thegrefg',        true,  1.8, true, 'es', '{"image_url":null}')
ON CONFLICT (slug) DO NOTHING;

-- Atributo subscribers para YouTubers
INSERT INTO knowledge_entity_attributes (id, entity_id, attribute_id, value_number, verified, metadata)
SELECT gen_random_uuid(), e.id, a.id, vals.v, true, '{}'
FROM (VALUES
  ('mrbeast',          400),
  ('t-series',         280),
  ('cocomelon',        185),
  ('set-india',        175),
  ('pewdiepie',        111),
  ('like-nastya',      120),
  ('vlad-y-niki',     115),
  ('kids-diana-show',  125),
  ('ibai',              12),
  ('elrubius',          40),
  ('luisito-comunica',  40),
  ('auronplay',         30),
  ('vegetta777',        33),
  ('willyrex',          17),
  ('thegrefg',          18)
) AS vals(slug, v)
JOIN knowledge_entities e ON e.slug = vals.slug
JOIN knowledge_attributes a ON a.slug = 'subscribers'
ON CONFLICT DO NOTHING;

-- ── Países ─────────────────────────────────────────────────────────────────
INSERT INTO knowledge_entities (id, entity_type, name, slug, kid_friendly, popularity_score, verified, language, metadata) VALUES
  (gen_random_uuid(), 'country', 'China',          'china',     true, 14.1, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'country', 'India',          'india',     true, 14.3, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'country', 'Estados Unidos', 'eeuu',      true,  3.4, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'country', 'Brasil',         'brasil',    true,  2.2, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'country', 'Argentina',      'argentina', true,  0.5, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'country', 'México',         'mexico',    true,  1.3, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'country', 'Colombia',       'colombia',  true,  0.5, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'country', 'España',         'espana',    true,  0.5, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'country', 'Uruguay',        'uruguay',   true,  0.03,true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'country', 'Chile',          'chile',     true,  0.2, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'country', 'Rusia',          'rusia',     true,  1.4, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'country', 'Canadá',         'canada',    true,  0.4, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'country', 'Australia',      'australia', true,  0.3, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'country', 'Japón',          'japon',     true,  1.2, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'country', 'Alemania',       'alemania',  true,  0.8, true, 'es', '{"image_url":null}')
ON CONFLICT (slug) DO NOTHING;

-- Atributo población
INSERT INTO knowledge_entity_attributes (id, entity_id, attribute_id, value_number, verified, metadata)
SELECT gen_random_uuid(), e.id, a.id, vals.v, true, '{}'
FROM (VALUES
  ('china',     1411), ('india',    1428), ('eeuu',      335),
  ('brasil',     215), ('argentina',  46), ('mexico',    128),
  ('colombia',    52), ('espana',     47), ('uruguay',     3),
  ('chile',       19), ('rusia',     144), ('canada',     38),
  ('australia',   26), ('japon',    124), ('alemania',   84)
) AS vals(slug, v)
JOIN knowledge_entities e ON e.slug = vals.slug
JOIN knowledge_attributes a ON a.slug = 'population'
ON CONFLICT DO NOTHING;

-- Atributo área km²
INSERT INTO knowledge_entity_attributes (id, entity_id, attribute_id, value_number, verified, metadata)
SELECT gen_random_uuid(), e.id, a.id, vals.v, true, '{}'
FROM (VALUES
  ('china',    9596960), ('india',    3287263), ('eeuu',    9833517),
  ('brasil',   8515767), ('argentina',2780400), ('mexico',  1964375),
  ('colombia', 1141748), ('espana',    505990), ('uruguay',  176215),
  ('chile',    756102),  ('rusia',   17098242), ('canada',  9984670),
  ('australia',7692024), ('japon',    377915),  ('alemania',  357114)
) AS vals(slug, v)
JOIN knowledge_entities e ON e.slug = vals.slug
JOIN knowledge_attributes a ON a.slug = 'area_km2'
ON CONFLICT DO NOTHING;

-- ── Videojuegos ────────────────────────────────────────────────────────────
INSERT INTO knowledge_entities (id, entity_type, name, slug, kid_friendly, popularity_score, verified, language, metadata) VALUES
  (gen_random_uuid(), 'videogame', 'Minecraft',               'minecraft',       true, 35.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'videogame', 'GTA V',                   'gta-v',           true, 25.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'videogame', 'Tetris',                  'tetris',          true, 30.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'videogame', 'Fortnite',                'fortnite',        true, 20.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'videogame', 'Roblox',                  'roblox',          true, 18.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'videogame', 'Among Us',                'among-us',        true, 15.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'videogame', 'The Last of Us',          'the-last-of-us',  true, 12.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'videogame', 'Zelda: Breath of the Wild','zelda-botw',     true, 14.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'videogame', 'Super Mario Bros',        'super-mario-bros', true,28.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'videogame', 'Pokémon Rojo/Azul',       'pokemon-rojo-azul',true,22.0,true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'videogame', 'Call of Duty: MW',        'cod-mw',          true, 16.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'videogame', 'FIFA 24',                 'fifa-24',         true, 10.0, true, 'es', '{"image_url":null}')
ON CONFLICT (slug) DO NOTHING;

-- release_year para juegos
INSERT INTO knowledge_entity_attributes (id, entity_id, attribute_id, value_number, verified, metadata)
SELECT gen_random_uuid(), e.id, a.id, vals.v, true, '{}'
FROM (VALUES
  ('minecraft',2011),('gta-v',2013),('tetris',1984),('fortnite',2017),
  ('roblox',2006),('among-us',2018),('the-last-of-us',2013),('zelda-botw',2017),
  ('super-mario-bros',1985),('pokemon-rojo-azul',1996),('cod-mw',2007),('fifa-24',2023)
) AS vals(slug, v)
JOIN knowledge_entities e ON e.slug = vals.slug
JOIN knowledge_attributes a ON a.slug = 'release_year'
ON CONFLICT DO NOTHING;

-- units_sold_m para juegos
INSERT INTO knowledge_entity_attributes (id, entity_id, attribute_id, value_number, verified, metadata)
SELECT gen_random_uuid(), e.id, a.id, vals.v, true, '{}'
FROM (VALUES
  ('minecraft',300),('gta-v',200),('tetris',520),
  ('the-last-of-us',20),('zelda-botw',32),('super-mario-bros',58),
  ('pokemon-rojo-azul',31),('cod-mw',30),('fifa-24',10)
) AS vals(slug, v)
JOIN knowledge_entities e ON e.slug = vals.slug
JOIN knowledge_attributes a ON a.slug = 'units_sold_m'
ON CONFLICT DO NOTHING;

-- ── Futbolistas ────────────────────────────────────────────────────────────
INSERT INTO knowledge_entities (id, entity_type, name, slug, kid_friendly, popularity_score, verified, language, metadata) VALUES
  (gen_random_uuid(), 'footballer', 'Lionel Messi',     'messi',        true, 9.9, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'footballer', 'Cristiano Ronaldo','cristiano',    true, 9.8, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'footballer', 'Pelé',             'pele',         true, 9.5, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'footballer', 'Ronaldo Nazário',  'ronaldo-r9',   true, 9.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'footballer', 'Neymar Jr',        'neymar',       true, 8.5, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'footballer', 'Kylian Mbappé',    'mbappe',       true, 9.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'footballer', 'Erling Haaland',   'haaland',      true, 8.8, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'footballer', 'Robert Lewandowski','lewandowski', true, 8.5, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'footballer', 'Lamine Yamal',     'yamal',        true, 8.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'footballer', 'Vinicius Jr',      'vinicius',     true, 8.5, true, 'es', '{"image_url":null}')
ON CONFLICT (slug) DO NOTHING;

-- goals_career para futbolistas
INSERT INTO knowledge_entity_attributes (id, entity_id, attribute_id, value_number, verified, metadata)
SELECT gen_random_uuid(), e.id, a.id, vals.v, true, '{}'
FROM (VALUES
  ('messi',820),('cristiano',890),('pele',767),('ronaldo-r9',414),
  ('neymar',400),('mbappe',280),('haaland',290),('lewandowski',620),
  ('yamal',40),('vinicius',130)
) AS vals(slug, v)
JOIN knowledge_entities e ON e.slug = vals.slug
JOIN knowledge_attributes a ON a.slug = 'goals_career'
ON CONFLICT DO NOTHING;

-- height_cm para futbolistas
INSERT INTO knowledge_entity_attributes (id, entity_id, attribute_id, value_number, verified, metadata)
SELECT gen_random_uuid(), e.id, a.id, vals.v, true, '{}'
FROM (VALUES
  ('messi',169),('cristiano',187),('pele',173),('ronaldo-r9',183),
  ('neymar',175),('mbappe',178),('haaland',194),('lewandowski',185),
  ('yamal',180),('vinicius',176)
) AS vals(slug, v)
JOIN knowledge_entities e ON e.slug = vals.slug
JOIN knowledge_attributes a ON a.slug = 'height_cm'
ON CONFLICT DO NOTHING;

-- ── Animales ───────────────────────────────────────────────────────────────
INSERT INTO knowledge_entities (id, entity_type, name, slug, kid_friendly, popularity_score, verified, language, metadata) VALUES
  (gen_random_uuid(), 'animal', 'Guepardo',  'guepardo',  true, 9.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'animal', 'Pronghorn', 'pronghorn', true, 5.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'animal', 'Ñu',        'gnu',       true, 6.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'animal', 'León',      'leon',      true, 9.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'animal', 'Caballo',   'caballo',   true, 8.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'animal', 'Tigre',     'tigre',     true, 8.5, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'animal', 'Oso pardo', 'oso-pardo', true, 7.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'animal', 'Elefante',  'elefante',  true, 8.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'animal', 'Cocodrilo', 'cocodrilo', true, 7.0, true, 'es', '{"image_url":null}'),
  (gen_random_uuid(), 'animal', 'Pingüino',  'pinguino',  true, 7.5, true, 'es', '{"image_url":null}')
ON CONFLICT (slug) DO NOTHING;

-- speed_kmh para animales
INSERT INTO knowledge_entity_attributes (id, entity_id, attribute_id, value_number, verified, metadata)
SELECT gen_random_uuid(), e.id, a.id, vals.v, true, '{}'
FROM (VALUES
  ('guepardo',112),('pronghorn',98),('gnu',80),('leon',80),('caballo',88),
  ('tigre',65),('oso-pardo',56),('elefante',40),('cocodrilo',30),('pinguino',36)
) AS vals(slug, v)
JOIN knowledge_entities e ON e.slug = vals.slug
JOIN knowledge_attributes a ON a.slug = 'speed_kmh'
ON CONFLICT DO NOTHING;

-- ── Timeline Events ────────────────────────────────────────────────────────
INSERT INTO timeline_events (id, title, short_title, event_date, precision, region, language, kid_friendly, verified, metadata) VALUES
  (gen_random_uuid(), 'Llegada de Cristóbal Colón a América',    'Colón llega a América',      '1492-10-12', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Inicio de la Revolución Francesa',        'Revolución Francesa',         '1789-07-14', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Fin de la Segunda Guerra Mundial',         'Fin de la 2da Guerra',        '1945-09-02', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Llegada del hombre a la Luna',             'Hombre en la Luna',           '1969-07-20', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Caída del Muro de Berlín',                 'Caída del Muro de Berlín',    '1989-11-09', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Primer vuelo de los hermanos Wright',      'Primer vuelo en avión',       '1903-12-17', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Nacimiento de Internet (ARPANET)',         'Nace Internet (ARPANET)',     '1969-10-29', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Se lanza el primer iPhone',                'Nace el iPhone',              '2007-06-29', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Fundación de Google',                      'Nace Google',                 '1998-09-04', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Fundación de Facebook',                    'Nace Facebook',               '2004-02-04', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Lanzamiento de YouTube',                   'Nace YouTube',                '2005-04-23', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Fundación de Twitter (ahora X)',           'Nace Twitter',                '2006-03-21', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Lanzamiento de TikTok',                    'Nace TikTok',                 '2016-09-01', 'month', 'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Inicio de la pandemia de COVID-19',        'Inicio del COVID-19',         '2020-03-11', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Lanzamiento de Minecraft',                 'Sale Minecraft',              '2011-11-18', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Lanzamiento de Fortnite Battle Royale',    'Sale Fortnite BR',            '2017-09-26', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Lanzamiento de Among Us',                  'Sale Among Us',               '2018-06-15', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Sale Grand Theft Auto V',                  'Sale GTA V',                  '2013-09-17', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Primer campeonato mundial de Fortnite',    'World Cup de Fortnite',       '2019-07-28', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Argentina gana el Mundial de Qatar 2022',  'Argentina campeón 2022',      '2022-12-18', 'day',   'AR',     'es', true, true, '{}'),
  (gen_random_uuid(), 'Messi gana su 8vo Balón de Oro',          'Messi: 8vo Balón de Oro',    '2023-10-30', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Brasil gana el Mundial Corea-Japón 2002',  'Brasil campeón 2002',         '2002-06-30', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Diego Maradona: gol de la mano de dios',  'Gol de la mano de Dios',     '1986-06-22', 'day',   'AR',     'es', true, true, '{}'),
  (gen_random_uuid(), 'Gangnam Style rompe récord en YouTube',    'Gangnam Style viral',         '2012-11-24', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'MrBeast supera los 100M de suscriptores', 'MrBeast: 100M subs',         '2022-06-01', 'month', 'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Se estrena Avengers: Endgame',             'Sale Avengers: Endgame',      '2019-04-26', 'day',   'global', 'es', true, true, '{}'),
  (gen_random_uuid(), 'Lanzamiento de Netflix en LATAM',          'Netflix llega a LATAM',       '2011-09-12', 'day',   'LATAM',  'es', true, true, '{}'),
  (gen_random_uuid(), 'Se funda Roblox Corporation',              'Nace Roblox',                 '2006-09-01', 'month', 'global', 'es', true, true, '{}');

-- ── Generadores procedurales ───────────────────────────────────────────────
INSERT INTO procedural_generators (id, slug, generator_type, enabled, config, metadata) VALUES
  (gen_random_uuid(), 'timeline-gaming-global', 'timeline_order', true,
   '{"n_events":4,"question_text":"¿En qué orden ocurrieron estos eventos del mundo gaming?","kid_safe_only":false}', '{}'),

  (gen_random_uuid(), 'timeline-historia-global', 'timeline_order', true,
   '{"n_events":4,"question_text":"Ordená estos eventos históricos de más antiguo a más reciente","kid_safe_only":false}', '{}'),

  (gen_random_uuid(), 'higher-lower-youtubers-subs', 'higher_lower', true,
   '{"allowed_entity_types":["youtuber"],"attribute_slug":"subscribers","attribute_name":"Suscriptores","unit":"millones","direction":"higher","question_text":"¿Quién tiene más suscriptores en YouTube?"}', '{}'),

  (gen_random_uuid(), 'higher-lower-paises-poblacion', 'higher_lower', true,
   '{"allowed_entity_types":["country"],"attribute_slug":"population","attribute_name":"Población","unit":"millones de personas","direction":"higher","question_text":"¿Cuál de estos países tiene más población?"}', '{}'),

  (gen_random_uuid(), 'higher-lower-futbolistas-goles', 'higher_lower', true,
   '{"allowed_entity_types":["footballer"],"attribute_slug":"goals_career","attribute_name":"Goles en carrera","unit":"goles","direction":"higher","question_text":"¿Quién tiene más goles en su carrera?"}', '{}'),

  (gen_random_uuid(), 'higher-lower-animales-velocidad', 'higher_lower', true,
   '{"allowed_entity_types":["animal"],"attribute_slug":"speed_kmh","attribute_name":"Velocidad máxima","unit":"km/h","direction":"higher","question_text":"¿Cuál de estos animales es más rápido?"}', '{}'),

  (gen_random_uuid(), 'closest-number-youtubers-subs', 'closest_number', true,
   '{"allowed_entity_types":["youtuber"],"attribute_slug":"subscribers","attribute_name":"Suscriptores","unit":"millones"}', '{}'),

  (gen_random_uuid(), 'closest-number-paises-poblacion', 'closest_number', true,
   '{"allowed_entity_types":["country"],"attribute_slug":"population","attribute_name":"Población","unit":"millones de personas"}', '{}'),

  (gen_random_uuid(), 'ranking-paises-area', 'ranking_order', true,
   '{"allowed_entity_types":["country"],"attribute_slug":"area_km2","attribute_name":"Superficie","unit":"km²","direction":"desc","n_items":4,"question_text":"Ordená estos países de mayor a menor superficie"}', '{}'),

  (gen_random_uuid(), 'ranking-juegos-ventas', 'ranking_order', true,
   '{"allowed_entity_types":["videogame"],"attribute_slug":"units_sold_m","attribute_name":"Unidades vendidas","unit":"millones","direction":"desc","n_items":4,"question_text":"Ordená estos juegos de más a menos copias vendidas"}', '{}')

ON CONFLICT (slug) DO NOTHING;
