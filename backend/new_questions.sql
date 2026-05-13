BEGIN;

-- Tags
INSERT INTO tags (id, name, slug) VALUES (gen_random_uuid(), 'anime', 'anime') ON CONFLICT (slug) DO NOTHING;
INSERT INTO tags (id, name, slug) VALUES (gen_random_uuid(), 'ar', 'ar') ON CONFLICT (slug) DO NOTHING;
INSERT INTO tags (id, name, slug) VALUES (gen_random_uuid(), 'ciencia', 'ciencia') ON CONFLICT (slug) DO NOTHING;
INSERT INTO tags (id, name, slug) VALUES (gen_random_uuid(), 'deportes', 'deportes') ON CONFLICT (slug) DO NOTHING;
INSERT INTO tags (id, name, slug) VALUES (gen_random_uuid(), 'futbol', 'futbol') ON CONFLICT (slug) DO NOTHING;
INSERT INTO tags (id, name, slug) VALUES (gen_random_uuid(), 'gaming', 'gaming') ON CONFLICT (slug) DO NOTHING;
INSERT INTO tags (id, name, slug) VALUES (gen_random_uuid(), 'general', 'general') ON CONFLICT (slug) DO NOTHING;
INSERT INTO tags (id, name, slug) VALUES (gen_random_uuid(), 'historia', 'historia') ON CONFLICT (slug) DO NOTHING;
INSERT INTO tags (id, name, slug) VALUES (gen_random_uuid(), 'internet', 'internet') ON CONFLICT (slug) DO NOTHING;
INSERT INTO tags (id, name, slug) VALUES (gen_random_uuid(), 'musica', 'musica') ON CONFLICT (slug) DO NOTHING;
INSERT INTO tags (id, name, slug) VALUES (gen_random_uuid(), 'series', 'series') ON CONFLICT (slug) DO NOTHING;

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('f86709f7-eae3-4de4-9374-8ecd82386e7c',1,'cuanto-tiempo-dura-un-dia-completo-en-minecraft-tiempo-real','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('653cff1d-32c5-4e33-b87c-31fe30deac84','f86709f7-eae3-4de4-9374-8ecd82386e7c','es','¿Cuánto tiempo dura un día completo en Minecraft (tiempo real)?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ac4360df-7438-4d26-bbd2-c96df29635c7','f86709f7-eae3-4de4-9374-8ecd82386e7c',1,0,'10 minutos',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('46549e65-ec43-4c3d-b384-93d2f7e54b78','f86709f7-eae3-4de4-9374-8ecd82386e7c',1,1,'20 minutos',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6bf55196-8714-4cfe-8d47-78da7f578e74','f86709f7-eae3-4de4-9374-8ecd82386e7c',1,2,'30 minutos',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8adb06e0-9b71-4ea6-b8bc-4531b815f1d6','f86709f7-eae3-4de4-9374-8ecd82386e7c',1,3,'1 hora',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('0b8de970-bc0e-4ba8-8858-43239ff7e3e7',1,'que-empresa-desarrollo-the-last-of-us','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('c0471a71-54b4-4631-90a0-089632e2e0b9','0b8de970-bc0e-4ba8-8858-43239ff7e3e7','es','¿Qué empresa desarrolló ''The Last of Us''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('10a16dcf-ad4d-40c6-965b-93ddbf9f99bb','0b8de970-bc0e-4ba8-8858-43239ff7e3e7',1,0,'Rockstar Games',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('41b5f834-15bb-437a-bdb2-1a436dc60cd3','0b8de970-bc0e-4ba8-8858-43239ff7e3e7',1,1,'Naughty Dog',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('38dd52fc-b619-43d4-bd50-95906eac7c73','0b8de970-bc0e-4ba8-8858-43239ff7e3e7',1,2,'Santa Monica Studio',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f2063ec4-ad09-4859-8719-f0bb860c23a1','0b8de970-bc0e-4ba8-8858-43239ff7e3e7',1,3,'Insomniac Games',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('70750849-91b7-4cd9-ad52-1b07b14e702d',1,'en-que-ano-salio-cyberpunk-2077','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('577bdb68-0205-468d-a617-6c964e0d9b0d','70750849-91b7-4cd9-ad52-1b07b14e702d','es','¿En qué año salió Cyberpunk 2077?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('801ca2bb-beeb-47d5-87d9-ca4f529549cc','70750849-91b7-4cd9-ad52-1b07b14e702d',1,0,'2018',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c6e19177-7746-49dc-a9e3-0b8383d08940','70750849-91b7-4cd9-ad52-1b07b14e702d',1,1,'2019',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f3c2b0af-4135-41db-801c-309808ed5759','70750849-91b7-4cd9-ad52-1b07b14e702d',1,2,'2020',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('20335a1d-fb31-478e-a461-745902520491','70750849-91b7-4cd9-ad52-1b07b14e702d',1,3,'2021',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('3c846436-e90b-4ca8-a60c-ca68a6c68492',1,'que-empresa-desarrollo-la-saga-dark-souls-y-elden-ring','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('0f5d6f23-06fd-4ad4-9793-9e735a21dd3b','3c846436-e90b-4ca8-a60c-ca68a6c68492','es','¿Qué empresa desarrolló la saga Dark Souls y Elden Ring?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('32e74e04-b01b-4a06-8c1a-f5356c067099','3c846436-e90b-4ca8-a60c-ca68a6c68492',1,0,'Capcom',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f9b0a457-9792-4118-93e1-b675d4bee26c','3c846436-e90b-4ca8-a60c-ca68a6c68492',1,1,'FromSoftware',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e7dcede8-da7a-487c-88b0-14721bcd1e01','3c846436-e90b-4ca8-a60c-ca68a6c68492',1,2,'Square Enix',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a8042057-12e6-4f1b-bcfb-7da426e2f3c4','3c846436-e90b-4ca8-a60c-ca68a6c68492',1,3,'Bandai Namco',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('916bf9b0-c1dd-45e2-8a03-0244818517ec',1,'que-consola-de-sega-fue-rival-de-la-super-nintendo-en-los-anos-90','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('0f4e2523-c242-4302-88cc-ea3e20f968ff','916bf9b0-c1dd-45e2-8a03-0244818517ec','es','¿Qué consola de SEGA fue rival de la Super Nintendo en los años 90?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('efe16a11-3fcb-4d5a-a12b-9eeba82efed5','916bf9b0-c1dd-45e2-8a03-0244818517ec',1,0,'Dreamcast',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('246b7840-0400-48de-aa9e-447dc8cd182e','916bf9b0-c1dd-45e2-8a03-0244818517ec',1,1,'Mega Drive / Genesis',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e0970c04-c0bd-4c04-bbf0-a9e72b1b63b7','916bf9b0-c1dd-45e2-8a03-0244818517ec',1,2,'Saturn',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3740f2c1-68e3-419c-b3b4-be46d184e162','916bf9b0-c1dd-45e2-8a03-0244818517ec',1,3,'Game Gear',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('81a6c915-74d1-4eb5-a01d-5e96433b50bd',1,'en-que-ano-salio-grand-theft-auto-san-andreas','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('80f716dc-16a0-4f78-b740-50f275a3bdd5','81a6c915-74d1-4eb5-a01d-5e96433b50bd','es','¿En qué año salió Grand Theft Auto: San Andreas?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c385c83d-aced-4f66-acba-c4a54f252aec','81a6c915-74d1-4eb5-a01d-5e96433b50bd',1,0,'2003',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c7cc454d-d179-4d2e-b9be-2b5e6be9bfec','81a6c915-74d1-4eb5-a01d-5e96433b50bd',1,1,'2004',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f6b58180-b6a9-41c2-bfd2-3c77c261062d','81a6c915-74d1-4eb5-a01d-5e96433b50bd',1,2,'2005',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e5a87e58-256b-49ca-81cc-e0af659fc155','81a6c915-74d1-4eb5-a01d-5e96433b50bd',1,3,'2006',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('ccd46e0b-40ad-4378-9746-c2e5648e0244',1,'cuantos-jugadores-tiene-un-partido-de-counter-strike-2-cs2','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('e04660d4-4899-402d-ba86-f905d4408cb5','ccd46e0b-40ad-4378-9746-c2e5648e0244','es','¿Cuántos jugadores tiene un partido de Counter-Strike 2 (CS2)?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('60c521fb-4fcd-4a0c-921c-e4615c8332c2','ccd46e0b-40ad-4378-9746-c2e5648e0244',1,0,'8 (4 vs 4)',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('0b8e79de-8646-4ad0-b68d-cc79b5f2e9c3','ccd46e0b-40ad-4378-9746-c2e5648e0244',1,1,'10 (5 vs 5)',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f8cde77a-0e0a-4a25-83aa-389ebca0cb09','ccd46e0b-40ad-4378-9746-c2e5648e0244',1,2,'12 (6 vs 6)',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('67d98814-a709-4de6-ae5a-7bb9e0bd7216','ccd46e0b-40ad-4378-9746-c2e5648e0244',1,3,'16 (8 vs 8)',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('ecd4b254-4d49-4ee5-955b-3705cfc518bf',1,'que-significa-fps-en-el-contexto-de-videojuegos','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('d999f7e5-dab6-4868-8e9a-1eb576af524b','ecd4b254-4d49-4ee5-955b-3705cfc518bf','es','¿Qué significa ''FPS'' en el contexto de videojuegos?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5180d7c8-525f-4ba9-b73e-24cc4d31201c','ecd4b254-4d49-4ee5-955b-3705cfc518bf',1,0,'Frames Per Second',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5c10a7c8-2ed8-4c41-b1d1-2af4cfa7a5f6','ecd4b254-4d49-4ee5-955b-3705cfc518bf',1,1,'First Person Shooter',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6a65406c-40e0-4177-9e8e-35da2de3d585','ecd4b254-4d49-4ee5-955b-3705cfc518bf',1,2,'Fast Play Speed',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('2803f956-d0ef-44de-9fb5-f0a8f03ad5fa','ecd4b254-4d49-4ee5-955b-3705cfc518bf',1,3,'Final Player Score',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('65e32081-7caf-4621-9dff-1457ed223e3b',1,'cuantos-pokemon-tipo-dragon-existen-en-la-primera-generacion','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('0154c0e4-b0d4-478e-bbca-9bc88ed31627','65e32081-7caf-4621-9dff-1457ed223e3b','es','¿Cuántos pokémon tipo Dragón existen en la primera generación?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ebb8e81b-5839-424e-b7a4-00eba61b9e6a','65e32081-7caf-4621-9dff-1457ed223e3b',1,0,'1',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8ecb1cae-8ba7-46fb-adbd-db4fe1743d0b','65e32081-7caf-4621-9dff-1457ed223e3b',1,1,'2',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('935ebcc4-2710-4ab4-a4a9-f5c051444451','65e32081-7caf-4621-9dff-1457ed223e3b',1,2,'3',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b5f04b51-5cbd-465a-9c00-b3b8f0352e93','65e32081-7caf-4621-9dff-1457ed223e3b',1,3,'5',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('68e23eee-2a73-4b3f-b746-495432095b1e',1,'cuantos-bits-tenia-la-nintendo-64','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('d2af7576-edc1-4a81-8450-3bdbda52cfcd','68e23eee-2a73-4b3f-b746-495432095b1e','es','¿Cuántos bits tenía la Nintendo 64?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4509e79c-70a4-4615-bedd-118975f86051','68e23eee-2a73-4b3f-b746-495432095b1e',1,0,'16',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7b4a371a-3010-4d8c-8dcb-967524ab91a6','68e23eee-2a73-4b3f-b746-495432095b1e',1,1,'32',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('30014b17-9cb6-453d-9310-edcf70992d7f','68e23eee-2a73-4b3f-b746-495432095b1e',1,2,'64',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3d95fa42-0e82-445d-9aab-8a112ebe5ee7','68e23eee-2a73-4b3f-b746-495432095b1e',1,3,'128',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('6fd99f78-99fc-4e1b-aca0-1059c9329b19',1,'que-consola-vino-despues-del-nintendo-64','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('b20e647d-a0fe-48ac-9fc8-c36acd674865','6fd99f78-99fc-4e1b-aca0-1059c9329b19','es','¿Qué consola vino después del Nintendo 64?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('2c0e67b8-df47-4d72-84e5-b55d1af56880','6fd99f78-99fc-4e1b-aca0-1059c9329b19',1,0,'Wii',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9d7a8f77-5728-45f4-a982-919114a804fb','6fd99f78-99fc-4e1b-aca0-1059c9329b19',1,1,'GameCube',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e0b18ca7-7874-4c60-838b-ef95953dc106','6fd99f78-99fc-4e1b-aca0-1059c9329b19',1,2,'Nintendo DS',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c587c1f5-52d5-429e-883d-ca99e89b82fe','6fd99f78-99fc-4e1b-aca0-1059c9329b19',1,3,'Game Boy Advance',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('60d47f24-46ec-4eea-b2fd-94dd342c6042',1,'en-que-ano-salio-elden-ring','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('635a4413-11c0-4c04-9aa4-07c4375cc4bc','60d47f24-46ec-4eea-b2fd-94dd342c6042','es','¿En qué año salió Elden Ring?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('11255868-e8f4-4016-a4ff-56e7bba835c9','60d47f24-46ec-4eea-b2fd-94dd342c6042',1,0,'2020',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('97680104-f369-4a4b-aee8-8e1389a56a11','60d47f24-46ec-4eea-b2fd-94dd342c6042',1,1,'2021',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('149bf006-81b7-4a16-8f34-0bfe7455c42b','60d47f24-46ec-4eea-b2fd-94dd342c6042',1,2,'2022',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e9abc9fa-b51f-4b73-95bd-cd4d3d694e5e','60d47f24-46ec-4eea-b2fd-94dd342c6042',1,3,'2023',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('33843aba-3eab-4109-9a0d-b651f326e605',1,'cuantos-jugadores-puede-haber-en-un-partido-de-overwatch-6v6','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('0c7f882a-006d-4cdf-accf-df220e15f701','33843aba-3eab-4109-9a0d-b651f326e605','es','¿Cuántos jugadores puede haber en un partido de Overwatch (6v6)?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('2c03ed8a-9e3f-43ac-892b-c8c1125e84d7','33843aba-3eab-4109-9a0d-b651f326e605',1,0,'8',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4d504681-2a50-445f-8d62-3aede0a1bf1f','33843aba-3eab-4109-9a0d-b651f326e605',1,1,'10',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('251b0e98-5e2f-477a-a834-afb6e962ef9e','33843aba-3eab-4109-9a0d-b651f326e605',1,2,'12',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('83df750d-8f1c-4e67-b288-e3f90c03fa92','33843aba-3eab-4109-9a0d-b651f326e605',1,3,'14',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('56e758d1-a96f-4c36-98e4-49430716532d',1,'a-que-juego-pertenece-la-frase-its-dangerous-to-go-alone-take-this','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('cbf45323-1251-4d51-98da-8aca6d7ff2e2','56e758d1-a96f-4c36-98e4-49430716532d','es','¿A qué juego pertenece la frase ''It''s dangerous to go alone! Take this.''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5e37117c-ca2e-4494-ac9a-ff787b302b0a','56e758d1-a96f-4c36-98e4-49430716532d',1,0,'Ocarina of Time',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('51050784-422d-4a22-8f1e-1f7c8c4a235f','56e758d1-a96f-4c36-98e4-49430716532d',1,1,'The Legend of Zelda (1986)',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f3bf9523-4e93-4c49-814f-c14c095255a6','56e758d1-a96f-4c36-98e4-49430716532d',1,2,'A Link to the Past',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ec013061-0794-4137-a67d-aa0e7c17aaae','56e758d1-a96f-4c36-98e4-49430716532d',1,3,'Majora''s Mask',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('c818e1b0-4d11-456e-a51d-1425e185884d',1,'que-es-herobrine-en-minecraft','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('11dc7de4-0524-40a7-be0b-89187a2b6a01','c818e1b0-4d11-456e-a51d-1425e185884d','es','¿Qué es ''Herobrine'' en Minecraft?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ddf51a58-bc9f-461c-b010-1c89b683c3f8','c818e1b0-4d11-456e-a51d-1425e185884d',1,0,'Un boss oficial del juego',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a0d8e3a9-b65d-45ae-aa97-605e13e87f88','c818e1b0-4d11-456e-a51d-1425e185884d',1,1,'Una leyenda urbana de los jugadores',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('943a4247-7e4d-4559-ac73-50ba56781154','c818e1b0-4d11-456e-a51d-1425e185884d',1,2,'Un mod de horror',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('aea1b2ad-7c54-4fa2-a6e5-286b087d759d','c818e1b0-4d11-456e-a51d-1425e185884d',1,3,'Un mob del Nether',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('d03db57c-3c1d-4943-afce-88de4b921335',1,'cuantos-materiales-distintos-puede-tener-una-espada-en-minecraft','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('a07059b4-a92e-4745-be06-ee03a7303f96','d03db57c-3c1d-4943-afce-88de4b921335','es','¿Cuántos materiales distintos puede tener una espada en Minecraft?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8a20b0c4-bdec-48d1-a288-8a34e0fd7f56','d03db57c-3c1d-4943-afce-88de4b921335',1,0,'4',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f8b119a8-3a3d-4d22-a7bf-2ff66bbc4f05','d03db57c-3c1d-4943-afce-88de4b921335',1,1,'5',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1bbd70cc-4801-48b5-a140-c1036d9cbb9e','d03db57c-3c1d-4943-afce-88de4b921335',1,2,'6',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('0274d34f-8261-4c23-8dd0-581876cbc694','d03db57c-3c1d-4943-afce-88de4b921335',1,3,'7',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('55e3abc6-7ac9-41c8-bd68-be6641dc95af',1,'cuantos-capitulos-tiene-fortnite-hasta-el-ano-2024','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('e6bf67b3-5f26-4d28-aedd-1ca8e3c148a3','55e3abc6-7ac9-41c8-bd68-be6641dc95af','es','¿Cuántos capítulos tiene Fortnite hasta el año 2024?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('dff08072-c031-493f-9c28-051b700a906a','55e3abc6-7ac9-41c8-bd68-be6641dc95af',1,0,'3',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a8c67773-fd4c-4de5-a6b6-253308114bb6','55e3abc6-7ac9-41c8-bd68-be6641dc95af',1,1,'4',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9dc7c432-c4aa-42d4-b06e-d09581833d7d','55e3abc6-7ac9-41c8-bd68-be6641dc95af',1,2,'5',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('48e50787-3d6e-4e8f-9e83-a2f5063ad02e','55e3abc6-7ac9-41c8-bd68-be6641dc95af',1,3,'6',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('33bafa89-a71f-4b0a-adff-89af67a2372d',1,'que-tipo-de-personaje-es-kratos-de-god-of-war','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('b6a16ddd-4a5f-48f9-aa8c-fd3217e72333','33bafa89-a71f-4b0a-adff-89af67a2372d','es','¿Qué tipo de personaje es ''Kratos'' de God of War?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f4ccbb42-16fd-4a32-8516-64916f68a9bd','33bafa89-a71f-4b0a-adff-89af67a2372d',1,0,'Samurái japonés',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('193dd601-7386-40b7-865c-e2d6eec6c9e8','33bafa89-a71f-4b0a-adff-89af67a2372d',1,1,'Guerrero espartano y dios de la guerra',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('76cef813-9479-4134-b32a-e8f955926ce8','33bafa89-a71f-4b0a-adff-89af67a2372d',1,2,'Caballero medieval',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c67f55a9-3e3a-4de1-a5c7-739a05dc2b58','33bafa89-a71f-4b0a-adff-89af67a2372d',1,3,'Vikingo nórdico',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('ce0e51ad-6675-4be2-8146-2cb98c738e4f',1,'cuantos-objetos-necesitas-para-hacer-una-mesa-de-trabajo-crafting-table-en-','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('33433cb1-022d-49d7-8d41-2b70f7ae157a','ce0e51ad-6675-4be2-8146-2cb98c738e4f','es','¿Cuántos objetos necesitás para hacer una mesa de trabajo (crafting table) en Minecraft?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e0146637-020c-4e77-8257-c6108f05f112','ce0e51ad-6675-4be2-8146-2cb98c738e4f',1,0,'2 tablas de madera',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3a804fe3-6a86-488c-9c62-dab9a4170c80','ce0e51ad-6675-4be2-8146-2cb98c738e4f',1,1,'3 tablas de madera',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ac3fa5c6-ed41-48bc-8109-ed3e6e688dc1','ce0e51ad-6675-4be2-8146-2cb98c738e4f',1,2,'4 tablas de madera',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9ab34c94-bead-4474-9136-8ba3ead9be10','ce0e51ad-6675-4be2-8146-2cb98c738e4f',1,3,'6 tablas de madera',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('eb9000e5-b0ed-458b-bcd0-eec8c226024a',1,'cual-fue-el-primer-juego-de-la-saga-grand-theft-auto','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('82a51011-f6f6-4e92-a561-dddf8b67d59a','eb9000e5-b0ed-458b-bcd0-eec8c226024a','es','¿Cuál fue el primer juego de la saga ''Grand Theft Auto''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('43c5e30c-8797-4bf5-8d49-1667118c6b55','eb9000e5-b0ed-458b-bcd0-eec8c226024a',1,0,'GTA Vice City',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3736b375-9e1d-4846-96d4-774699b17720','eb9000e5-b0ed-458b-bcd0-eec8c226024a',1,1,'GTA San Andreas',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('15b1c9a4-0a61-4636-a2a6-4e55fe070625','eb9000e5-b0ed-458b-bcd0-eec8c226024a',1,2,'Grand Theft Auto (1997)',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('038292a7-49f7-48f2-940a-565b87318825','eb9000e5-b0ed-458b-bcd0-eec8c226024a',1,3,'GTA III',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('75a252ac-4a9b-46f7-ada8-6b27873ad7bd',1,'cuantos-capitulos-tiene-el-manga-de-one-piece-aproximadamente-hasta-2024','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('b883920c-54ca-43b7-9b32-176194df29b4','75a252ac-4a9b-46f7-ada8-6b27873ad7bd','es','¿Cuántos capítulos tiene el manga de One Piece aproximadamente (hasta 2024)?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f37bc2a1-91f8-4f3c-90c6-c2dd39a3dac0','75a252ac-4a9b-46f7-ada8-6b27873ad7bd',1,0,'700',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('678c74ab-3fa1-4ba2-9dd0-32c84691bcd3','75a252ac-4a9b-46f7-ada8-6b27873ad7bd',1,1,'900',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6e1b2787-b554-4a15-94fa-c333da547b1b','75a252ac-4a9b-46f7-ada8-6b27873ad7bd',1,2,'1000',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b91c27de-593f-4c09-9a86-ec44441eb4a3','75a252ac-4a9b-46f7-ada8-6b27873ad7bd',1,3,'Más de 1100',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('ff2f827f-1c0e-472a-8f99-58aae2233c0f',1,'cuantos-episodios-tiene-naruto-shippuden','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('84d6a676-0769-47a6-ae35-3db7f7595e2e','ff2f827f-1c0e-472a-8f99-58aae2233c0f','es','¿Cuántos episodios tiene Naruto Shippuden?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b758ea9d-9fb6-4413-b041-64c0e4fa0616','ff2f827f-1c0e-472a-8f99-58aae2233c0f',1,0,'350',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a1abe1f3-3406-486c-84df-cd0d6ad817f2','ff2f827f-1c0e-472a-8f99-58aae2233c0f',1,1,'400',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('839d9f02-3237-445a-bae1-4f7230bda0b0','ff2f827f-1c0e-472a-8f99-58aae2233c0f',1,2,'450',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b79f8198-96b2-4042-acc2-29f879165e96','ff2f827f-1c0e-472a-8f99-58aae2233c0f',1,3,'500',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('7f856fee-4547-4ac5-a7b9-703851a76b94',1,'en-que-ano-empezo-el-anime-de-one-piece','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('00084bbd-bba4-4a61-b19b-c17cdaab4a22','7f856fee-4547-4ac5-a7b9-703851a76b94','es','¿En qué año empezó el anime de One Piece?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('584d604d-16fd-4c6d-8e96-300a0827f14d','7f856fee-4547-4ac5-a7b9-703851a76b94',1,0,'1997',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a362aa0e-e4f4-499a-a9ce-6ac9384cb999','7f856fee-4547-4ac5-a7b9-703851a76b94',1,1,'1998',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9a13a456-79aa-4d80-aa19-61eec9785a0a','7f856fee-4547-4ac5-a7b9-703851a76b94',1,2,'1999',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('10f2fd7f-8f6b-44c1-befe-89475f29e37c','7f856fee-4547-4ac5-a7b9-703851a76b94',1,3,'2000',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('a3e38d1c-141a-4d66-8ea0-8a778c3c594a',1,'en-que-ano-empezo-el-anime-de-dragon-ball','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('27a7c772-a294-4d4f-859a-b19ded40cf9c','a3e38d1c-141a-4d66-8ea0-8a778c3c594a','es','¿En qué año empezó el anime de Dragon Ball?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e5f88687-3913-440f-8994-4a2fee09500e','a3e38d1c-141a-4d66-8ea0-8a778c3c594a',1,0,'1984',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('96dcb53d-c421-4883-af27-9747fac9a2fa','a3e38d1c-141a-4d66-8ea0-8a778c3c594a',1,1,'1985',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b286ef03-5952-41af-a9fb-c064fb0cede0','a3e38d1c-141a-4d66-8ea0-8a778c3c594a',1,2,'1986',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('2dd45c8e-6cf7-420d-b3ff-b0dfc97622d1','a3e38d1c-141a-4d66-8ea0-8a778c3c594a',1,3,'1987',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('eaf963e8-2c41-4066-88ba-bc8242d66f11',1,'cuantos-miembros-tiene-los-piratas-del-sombrero-de-paja-en-one-piece','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('9298a690-0862-4aa1-934a-b22daf87a804','eaf963e8-2c41-4066-88ba-bc8242d66f11','es','¿Cuántos miembros tiene Los Piratas del Sombrero de Paja en One Piece?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('2c8f592a-db8f-4066-bced-2a50d62a5262','eaf963e8-2c41-4066-88ba-bc8242d66f11',1,0,'8',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a2423424-94c2-4bf5-bd2d-e8fc83e4d081','eaf963e8-2c41-4066-88ba-bc8242d66f11',1,1,'9',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a5616aa2-5dd2-4c7a-9999-48d54a80a184','eaf963e8-2c41-4066-88ba-bc8242d66f11',1,2,'10',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6abb9b66-71c8-40a2-a646-5ac6e1284a3b','eaf963e8-2c41-4066-88ba-bc8242d66f11',1,3,'11',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('4c59e986-d045-4d29-bcc9-49ef92205f98',1,'como-se-llama-el-barco-de-los-piratas-de-paja-en-one-piece','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('f8297852-d05b-496d-80d7-255785fe43c3','4c59e986-d045-4d29-bcc9-49ef92205f98','es','¿Cómo se llama el barco de Los Piratas de Paja en One Piece?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e23dfbb1-8cc2-424d-811d-dee9f6287a7b','4c59e986-d045-4d29-bcc9-49ef92205f98',1,0,'Gran Line',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a01ea4c9-2462-43ba-aaf8-4e4798bf8077','4c59e986-d045-4d29-bcc9-49ef92205f98',1,1,'Thousand Sunny',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('641f9171-7b67-473d-85ca-27c07b953423','4c59e986-d045-4d29-bcc9-49ef92205f98',1,2,'Going Merry II',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('96e03f6f-0194-4f53-8cb8-89a5cfa5d2e9','4c59e986-d045-4d29-bcc9-49ef92205f98',1,3,'Red Force',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('92a3d297-bef0-46d3-a5bb-c74d7293a69c',1,'cuantas-temporadas-tiene-my-hero-academia','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('1eaa17b4-85e7-4f9d-aaa8-f5e6ab1e15cb','92a3d297-bef0-46d3-a5bb-c74d7293a69c','es','¿Cuántas temporadas tiene My Hero Academia?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9fd00d71-7093-440e-b34d-ccdf7278dc69','92a3d297-bef0-46d3-a5bb-c74d7293a69c',1,0,'5',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('769539cd-67af-4695-a850-da3b0e1bcc13','92a3d297-bef0-46d3-a5bb-c74d7293a69c',1,1,'6',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('00ecf453-7b26-4b58-9349-7f2247054984','92a3d297-bef0-46d3-a5bb-c74d7293a69c',1,2,'7',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f0f404cf-aa76-4892-8e78-4ad05a4f8f92','92a3d297-bef0-46d3-a5bb-c74d7293a69c',1,3,'8',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('c01fac9a-1b0d-43ac-bc68-2eda0dbfef4d',1,'cual-es-el-poder-del-personaje-todoroki-en-my-hero-academia','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('bd042284-4c09-4b91-81b2-7433f897cff9','c01fac9a-1b0d-43ac-bc68-2eda0dbfef4d','es','¿Cuál es el poder del personaje Todoroki en My Hero Academia?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f498155f-3cc2-4b64-acb0-3f647ec59b8a','c01fac9a-1b0d-43ac-bc68-2eda0dbfef4d',1,0,'Explosión',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('98934321-81c7-4c87-a207-818cb7de4378','c01fac9a-1b0d-43ac-bc68-2eda0dbfef4d',1,1,'Mitad fuego y mitad hielo',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a755db6e-1a69-4a29-886a-7433604653da','c01fac9a-1b0d-43ac-bc68-2eda0dbfef4d',1,2,'Velocidad extrema',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8de1bcbf-ec33-4d44-8460-89d3bee44d96','c01fac9a-1b0d-43ac-bc68-2eda0dbfef4d',1,3,'Teletransportación',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('9be8de6d-f59e-49cf-ae47-8e1fe479b57a',1,'cuantos-miembros-tiene-la-akatsuki-en-naruto','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('94647524-6387-4573-9634-b0b7dc8bb538','9be8de6d-f59e-49cf-ae47-8e1fe479b57a','es','¿Cuántos miembros tiene la Akatsuki en Naruto?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ab0cf4c2-6260-4143-acfb-97f1aecf4e59','9be8de6d-f59e-49cf-ae47-8e1fe479b57a',1,0,'7',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ecc8507e-7745-498b-9671-ae4f4745aee3','9be8de6d-f59e-49cf-ae47-8e1fe479b57a',1,1,'8',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d567ab6d-ac10-4b13-ba7e-8bac2987e6a9','9be8de6d-f59e-49cf-ae47-8e1fe479b57a',1,2,'9',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('79265f0e-5d95-4e37-8fde-6c6e869dc110','9be8de6d-f59e-49cf-ae47-8e1fe479b57a',1,3,'10',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('10df9949-e3ea-4aec-b6cc-386ff8f9dbb2',1,'cual-es-el-rango-ninja-mas-alto-en-el-mundo-de-naruto','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('6f8f8c67-baff-4fc0-ad18-3d16a20280b8','10df9949-e3ea-4aec-b6cc-386ff8f9dbb2','es','¿Cuál es el rango ninja más alto en el mundo de Naruto?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8e5361e3-0787-422a-9f0d-5efee79360ca','10df9949-e3ea-4aec-b6cc-386ff8f9dbb2',1,0,'Jounin',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('795d1ae6-d699-4a2a-87e7-50c8ca6b3553','10df9949-e3ea-4aec-b6cc-386ff8f9dbb2',1,1,'Anbu',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b8e7c398-e1b2-4914-9ba3-c8db5e848c8c','10df9949-e3ea-4aec-b6cc-386ff8f9dbb2',1,2,'Sannin',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f3bf70d3-e1c3-4195-84c1-3203477e7f76','10df9949-e3ea-4aec-b6cc-386ff8f9dbb2',1,3,'Kage',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('7c9e5fc0-4576-4848-92c8-2c17b3bde991',1,'en-que-ano-empezo-el-anime-de-demon-slayer-kimetsu-no-yaiba','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('8e93b7c0-8061-4213-9cae-e8a164125592','7c9e5fc0-4576-4848-92c8-2c17b3bde991','es','¿En qué año empezó el anime de Demon Slayer (Kimetsu no Yaiba)?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1c6528d7-ff79-4281-a31f-c6b22c809f6e','7c9e5fc0-4576-4848-92c8-2c17b3bde991',1,0,'2017',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a9c21b3f-c89c-4f6b-bf6c-da31c9d6a4c6','7c9e5fc0-4576-4848-92c8-2c17b3bde991',1,1,'2018',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d1ceb41f-5848-4764-a341-bb72b1446bd1','7c9e5fc0-4576-4848-92c8-2c17b3bde991',1,2,'2019',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('761d1127-4ace-4d80-8827-7652fd595c86','7c9e5fc0-4576-4848-92c8-2c17b3bde991',1,3,'2020',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('a5e20185-5630-45d4-831d-4e6c1e751305',1,'cuantos-episodios-tiene-la-primera-temporada-de-attack-on-titan','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('40b86142-7afe-47ba-9042-ac49df60e0d7','a5e20185-5630-45d4-831d-4e6c1e751305','es','¿Cuántos episodios tiene la primera temporada de Attack on Titan?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f7cf17df-7242-4f20-a9fd-3a5b4dbeeafa','a5e20185-5630-45d4-831d-4e6c1e751305',1,0,'20',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f1917ff2-d02d-4589-9c4c-7122dc14bce6','a5e20185-5630-45d4-831d-4e6c1e751305',1,1,'22',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('14cfec9d-fdf5-4a7e-8f84-5ec554e3fc02','a5e20185-5630-45d4-831d-4e6c1e751305',1,2,'24',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('19752484-3c32-4b08-b249-17b49e84ff78','a5e20185-5630-45d4-831d-4e6c1e751305',1,3,'25',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('2c63ff05-981d-4cf1-85d7-a72fe79fb04c',1,'en-que-ano-empezo-el-anime-de-my-hero-academia','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('c51a9b70-4c81-4896-9196-a90e320489ab','2c63ff05-981d-4cf1-85d7-a72fe79fb04c','es','¿En qué año empezó el anime de My Hero Academia?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6d7148ed-a12b-4fba-b7be-f25c068e1c4f','2c63ff05-981d-4cf1-85d7-a72fe79fb04c',1,0,'2014',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c251d7a2-3843-4e1f-811e-a199267c0274','2c63ff05-981d-4cf1-85d7-a72fe79fb04c',1,1,'2015',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8c4ebfb6-676e-4900-9b49-d4b1161bf995','2c63ff05-981d-4cf1-85d7-a72fe79fb04c',1,2,'2016',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('18dbfe42-fee0-4a53-9ada-93b9ec774bfa','2c63ff05-981d-4cf1-85d7-a72fe79fb04c',1,3,'2017',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('ada74067-fbbe-4130-b4f6-1c838b9544d0',1,'cuantos-anos-tiene-monkey-d-luffy-al-inicio-de-one-piece','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('da0d4b83-bf7b-4473-b0fe-336b4e56a6db','ada74067-fbbe-4130-b4f6-1c838b9544d0','es','¿Cuántos años tiene Monkey D. Luffy al inicio de One Piece?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('20c67eed-2496-40fb-af6f-ecce95cd2742','ada74067-fbbe-4130-b4f6-1c838b9544d0',1,0,'15',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d81cde2f-91f7-4c38-bd44-9d732106474e','ada74067-fbbe-4130-b4f6-1c838b9544d0',1,1,'16',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7b4bdcef-1746-4d8e-a697-6840994e9e3b','ada74067-fbbe-4130-b4f6-1c838b9544d0',1,2,'17',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c13f9d57-833d-47e9-b1b2-ecc13e11348d','ada74067-fbbe-4130-b4f6-1c838b9544d0',1,3,'18',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('75232211-21f8-4eed-adaf-1b1e6e100d99',1,'cual-es-el-objetivo-de-gon-freecss-en-hunter-x-hunter','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('f1129b39-a7ac-4f72-9a49-a039fbd19260','75232211-21f8-4eed-adaf-1b1e6e100d99','es','¿Cuál es el objetivo de Gon Freecss en Hunter x Hunter?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('786f3e01-af7c-4f61-9f48-222daa60d11a','75232211-21f8-4eed-adaf-1b1e6e100d99',1,0,'Convertirse en el rey pirata',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f743bc45-5693-4c00-8f48-9a263b6bcee7','75232211-21f8-4eed-adaf-1b1e6e100d99',1,1,'Ser el mejor cazador para encontrar a su padre',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8d97c0c6-1dac-4f26-931a-0782b0cec5a6','75232211-21f8-4eed-adaf-1b1e6e100d99',1,2,'Convertirse en Hokage',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7b9180d8-2e10-4fa1-a5cf-6ccadb7a9d1d','75232211-21f8-4eed-adaf-1b1e6e100d99',1,3,'Ganar el torneo de artes marciales',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('d41455ea-acb9-4b0c-a36f-3d56559989dc',1,'en-que-ano-salio-la-primera-pelicula-de-the-avengers','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('07b3e442-94be-4a3b-8358-aec40073556a','d41455ea-acb9-4b0c-a36f-3d56559989dc','es','¿En qué año salió la primera película de ''The Avengers''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3c03ade9-7037-4e62-99b0-19844fac0645','d41455ea-acb9-4b0c-a36f-3d56559989dc',1,0,'2010',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e9ea5254-9736-4127-a3b8-6dcd018aa540','d41455ea-acb9-4b0c-a36f-3d56559989dc',1,1,'2011',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('592d01c3-7d18-4fbe-aa2c-e65809ed35e6','d41455ea-acb9-4b0c-a36f-3d56559989dc',1,2,'2012',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f961bb88-b975-44f7-aaa7-fc0c43cd52ec','d41455ea-acb9-4b0c-a36f-3d56559989dc',1,3,'2013',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('78a4e7bf-2f67-4227-a5fe-ef37e6bd54e5',1,'quien-interpreto-al-joker-en-la-pelicula-joker-de-2019','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('da900fdc-8526-47ba-9675-65d53fb5949e','78a4e7bf-2f67-4227-a5fe-ef37e6bd54e5','es','¿Quién interpretó al Joker en la película ''Joker'' de 2019?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('2e143bf0-f186-409b-872b-d93782f28aae','78a4e7bf-2f67-4227-a5fe-ef37e6bd54e5',1,0,'Heath Ledger',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a4db23ab-a782-4f11-8e86-6c307408eadd','78a4e7bf-2f67-4227-a5fe-ef37e6bd54e5',1,1,'Jared Leto',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('592b2308-eac6-4074-9268-d99a87a78c22','78a4e7bf-2f67-4227-a5fe-ef37e6bd54e5',1,2,'Joaquin Phoenix',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f51b2888-9c01-44da-bc48-db1219c6429b','78a4e7bf-2f67-4227-a5fe-ef37e6bd54e5',1,3,'Jack Nicholson',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('70271395-8b60-43b3-96b1-c331243f683e',1,'en-que-ano-se-estreno-la-pelicula-titanic-de-james-cameron','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('3e2374f4-6559-4879-93ea-041669fd1a00','70271395-8b60-43b3-96b1-c331243f683e','es','¿En qué año se estrenó la película ''Titanic'' de James Cameron?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('058da5fb-b96c-4cc1-a961-5019d4fb9b5b','70271395-8b60-43b3-96b1-c331243f683e',1,0,'1995',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('31efbb14-7b7c-440d-9734-dacc901f5c7f','70271395-8b60-43b3-96b1-c331243f683e',1,1,'1996',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6704c805-829e-458a-b702-baac77429b34','70271395-8b60-43b3-96b1-c331243f683e',1,2,'1997',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('407a2ab3-c34e-46bd-99ce-60cd44d7942a','70271395-8b60-43b3-96b1-c331243f683e',1,3,'1998',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('73c11504-f564-4b31-94e9-97b3778ba4d8',1,'quien-creo-la-serie-los-simpsons','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('02b2718d-728c-4088-9987-5eef89cd2964','73c11504-f564-4b31-94e9-97b3778ba4d8','es','¿Quién creó la serie ''Los Simpsons''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f597a41c-3ef6-4903-aab4-f231ebd15363','73c11504-f564-4b31-94e9-97b3778ba4d8',1,0,'Seth MacFarlane',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('360c79ba-3d39-4b67-b280-a12dd8c25fab','73c11504-f564-4b31-94e9-97b3778ba4d8',1,1,'Matt Groening',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('cce9add2-b0a6-428a-b97f-cbffc1ea35f1','73c11504-f564-4b31-94e9-97b3778ba4d8',1,2,'Mike Judge',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d1a9d59a-41fa-43d5-8b83-e9572d9e79a3','73c11504-f564-4b31-94e9-97b3778ba4d8',1,3,'Dan Harmon',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('609fe674-1b81-454f-b849-4dfd0c4d9cd7',1,'en-que-ano-empezo-a-emitirse-la-serie-los-simpsons','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('583a9950-03dc-4472-bab9-42ab36f3be1a','609fe674-1b81-454f-b849-4dfd0c4d9cd7','es','¿En qué año empezó a emitirse la serie ''Los Simpsons''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('cd9968ca-9f68-48d8-9656-401cc9fb161b','609fe674-1b81-454f-b849-4dfd0c4d9cd7',1,0,'1987',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('0dffab20-3248-41f7-a6e6-b185d4264af7','609fe674-1b81-454f-b849-4dfd0c4d9cd7',1,1,'1988',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('24112076-7745-44f3-bf81-955cdb569c07','609fe674-1b81-454f-b849-4dfd0c4d9cd7',1,2,'1989',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6707ad56-e1b6-4237-8f3d-0509ae3c06ae','609fe674-1b81-454f-b849-4dfd0c4d9cd7',1,3,'1990',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('8665e229-d4f8-4ff9-b77a-a41c71c24db8',1,'cuantas-temporadas-tiene-los-simpsons-hasta-2024','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('8fc92f2e-572c-48c3-91e4-cc24e35f45da','8665e229-d4f8-4ff9-b77a-a41c71c24db8','es','¿Cuántas temporadas tiene ''Los Simpsons'' (hasta 2024)?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f23af4bf-4590-4582-81ac-93c40efd4b84','8665e229-d4f8-4ff9-b77a-a41c71c24db8',1,0,'25',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('91705fe6-8644-4f70-9c84-b743c463568c','8665e229-d4f8-4ff9-b77a-a41c71c24db8',1,1,'30',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('73250a7a-ee39-4193-a8e7-3bf25caecd01','8665e229-d4f8-4ff9-b77a-a41c71c24db8',1,2,'35',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e8f6027d-657b-400b-95b8-a2c089816c52','8665e229-d4f8-4ff9-b77a-a41c71c24db8',1,3,'Más de 35',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('1ee595d6-3036-4e61-9223-7ad548744b5b',1,'como-se-llama-el-cunado-de-walter-white-en-breaking-bad','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('e9608913-f5c0-4dcd-a5b7-6d6dfcdf92e8','1ee595d6-3036-4e61-9223-7ad548744b5b','es','¿Cómo se llama el cuñado de Walter White en Breaking Bad?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a3b4e77d-8cca-4e9f-955c-9a132f833bf1','1ee595d6-3036-4e61-9223-7ad548744b5b',1,0,'Jesse Pinkman',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('45116e22-e688-491f-9318-e5cbcf611a48','1ee595d6-3036-4e61-9223-7ad548744b5b',1,1,'Hank Schrader',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('94fa46fc-c40b-45bd-96a7-3a44656cf341','1ee595d6-3036-4e61-9223-7ad548744b5b',1,2,'Mike Ehrmantraut',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('2490ee27-127c-4ca7-9872-6c07b8be1a9b','1ee595d6-3036-4e61-9223-7ad548744b5b',1,3,'Gustavo Fring',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('0491db38-eecf-47e6-99d7-954ca60b84c1',1,'quien-interpreta-a-thor-en-el-universo-cinematografico-de-marvel','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('41163132-9c5e-4117-9f04-289c3ed5ce62','0491db38-eecf-47e6-99d7-954ca60b84c1','es','¿Quién interpreta a ''Thor'' en el Universo Cinematográfico de Marvel?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('300e9560-8818-4803-a828-c09317e8269d','0491db38-eecf-47e6-99d7-954ca60b84c1',1,0,'Chris Evans',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('2da210d6-c613-4973-880c-6032587adef8','0491db38-eecf-47e6-99d7-954ca60b84c1',1,1,'Chris Hemsworth',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('2c1ec81a-4967-40aa-b98a-fe56550536c7','0491db38-eecf-47e6-99d7-954ca60b84c1',1,2,'Chris Pratt',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('56282aa1-9a4d-4070-b8a5-074c2eba2738','0491db38-eecf-47e6-99d7-954ca60b84c1',1,3,'Chris Pine',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('75e99dda-eb87-46a3-91be-8da560d471bc',1,'en-que-ciudad-ficticia-vive-batman','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('0fb8bdff-8393-42e1-9ef1-2e0a4f9433f3','75e99dda-eb87-46a3-91be-8da560d471bc','es','¿En qué ciudad ficticia vive Batman?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e4ebdd76-1ac2-4674-88b6-075050808306','75e99dda-eb87-46a3-91be-8da560d471bc',1,0,'Metropolis',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('de55e015-45dc-450f-b2e6-d012c07cc259','75e99dda-eb87-46a3-91be-8da560d471bc',1,1,'Gotham City',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('67d96b22-c3b6-4b6f-ac46-81a87a411bd3','75e99dda-eb87-46a3-91be-8da560d471bc',1,2,'Star City',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5875a352-29e7-4ee2-b185-ab7cdfa28c4e','75e99dda-eb87-46a3-91be-8da560d471bc',1,3,'Central City',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('6fb07077-6662-4edc-8666-a1fac8a97e5a',1,'cuantos-libros-tiene-la-saga-principal-de-harry-potter','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('9e0fdcde-c896-4808-9325-0e06d4dd469f','6fb07077-6662-4edc-8666-a1fac8a97e5a','es','¿Cuántos libros tiene la saga principal de ''Harry Potter''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('68d81022-692f-4c33-adff-4b945c368e97','6fb07077-6662-4edc-8666-a1fac8a97e5a',1,0,'5',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('924a24b8-d98d-4b22-a70f-f20409b603db','6fb07077-6662-4edc-8666-a1fac8a97e5a',1,1,'6',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('956818ed-58a9-4418-88f7-23ae767f65cd','6fb07077-6662-4edc-8666-a1fac8a97e5a',1,2,'7',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('db71ddeb-ba2c-41e9-ba04-b4429a433a9e','6fb07077-6662-4edc-8666-a1fac8a97e5a',1,3,'8',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('1c5cc44b-574d-41c3-839c-fa8a77ad237d',1,'en-que-ano-se-publico-el-primer-libro-de-harry-potter','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('8e5dc071-5de9-40e9-916a-48619d79af06','1c5cc44b-574d-41c3-839c-fa8a77ad237d','es','¿En qué año se publicó el primer libro de Harry Potter?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('96d65369-beff-444d-bbbf-f91c6fe92d9b','1c5cc44b-574d-41c3-839c-fa8a77ad237d',1,0,'1995',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('30f0cfe8-c233-4014-8852-3ec183e0018b','1c5cc44b-574d-41c3-839c-fa8a77ad237d',1,1,'1996',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f41293f9-a124-4741-9b56-c0688ad856c7','1c5cc44b-574d-41c3-839c-fa8a77ad237d',1,2,'1997',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('dbbe3640-3952-4adb-9fe5-448b2cc6b47f','1c5cc44b-574d-41c3-839c-fa8a77ad237d',1,3,'1998',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('cff15035-62c7-46b5-a222-d355d915cd9d',1,'quienes-crearon-la-serie-stranger-things','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('93da7e15-2b36-43fc-9d2e-39a509c1552d','cff15035-62c7-46b5-a222-d355d915cd9d','es','¿Quiénes crearon la serie ''Stranger Things''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5b51947d-b45c-476a-9884-5735d7b7b108','cff15035-62c7-46b5-a222-d355d915cd9d',1,0,'J.J. Abrams',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('758f0da8-dab3-4ee6-875b-87011279891d','cff15035-62c7-46b5-a222-d355d915cd9d',1,1,'Steven Spielberg',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f2290001-3381-4845-b284-de0a4292cf6f','cff15035-62c7-46b5-a222-d355d915cd9d',1,2,'Los Hermanos Duffer',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('79bdf5c2-ca3a-4cf0-8d86-3602e62804b2','cff15035-62c7-46b5-a222-d355d915cd9d',1,3,'Ryan Murphy',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('ef270d95-9b9b-4f08-b457-fd0680b00408',1,'en-que-pais-se-ambienta-la-casa-de-papel','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('9bda0f73-b62e-414f-8970-8b6d8f04396b','ef270d95-9b9b-4f08-b457-fd0680b00408','es','¿En qué país se ambienta ''La Casa de Papel''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9806cdbc-8ce9-409c-b4af-fd53c3c34fcb','ef270d95-9b9b-4f08-b457-fd0680b00408',1,0,'Argentina',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ff1e7233-5c71-4ba2-a9dc-9b5ee9f50516','ef270d95-9b9b-4f08-b457-fd0680b00408',1,1,'México',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ab82f2d0-131b-4829-9c4c-d18f4cee059b','ef270d95-9b9b-4f08-b457-fd0680b00408',1,2,'España',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b4429107-0b2a-48ec-b06f-d4e5c07f0b13','ef270d95-9b9b-4f08-b457-fd0680b00408',1,3,'Colombia',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('5f4538eb-8487-45a1-8ed6-ff946922b57f',1,'quien-interpreta-a-el-profesor-en-la-casa-de-papel','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('1e796293-bc73-4029-af0b-53ef9777bf40','5f4538eb-8487-45a1-8ed6-ff946922b57f','es','¿Quién interpreta a ''El Profesor'' en La Casa de Papel?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c86fc966-9922-4b6d-9fda-2bc53cc06948','5f4538eb-8487-45a1-8ed6-ff946922b57f',1,0,'Álvaro Morte',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5601b170-8ccb-4bd0-981a-4437f64a27b0','5f4538eb-8487-45a1-8ed6-ff946922b57f',1,1,'Pedro Alonso',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('931bb3fc-bd6f-42ec-93ed-c91c79b50874','5f4538eb-8487-45a1-8ed6-ff946922b57f',1,2,'Miguel Herrán',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e89faefa-6640-498f-9d8e-4ed2c951a09b','5f4538eb-8487-45a1-8ed6-ff946922b57f',1,3,'Jaime Lorente',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('e05d8bf1-a7ed-4cde-bf17-af8651dbff7d',1,'en-que-ano-se-estreno-la-serie-the-mandalorian','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('15a66834-54cb-4921-b7ee-1a398969f9e4','e05d8bf1-a7ed-4cde-bf17-af8651dbff7d','es','¿En qué año se estrenó la serie ''The Mandalorian''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9858f014-55d5-4560-8111-0ce7c365860a','e05d8bf1-a7ed-4cde-bf17-af8651dbff7d',1,0,'2018',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8d953b22-02ae-4e12-b24c-ff147c9c8839','e05d8bf1-a7ed-4cde-bf17-af8651dbff7d',1,1,'2019',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('aac3e2bc-26ea-4ed8-8dc3-d9b040b5a5a9','e05d8bf1-a7ed-4cde-bf17-af8651dbff7d',1,2,'2020',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7f5f165e-a227-44b3-b369-00ecf5d4e9f5','e05d8bf1-a7ed-4cde-bf17-af8651dbff7d',1,3,'2021',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('f6cfa116-466d-4478-b055-7c5bf9f9b4b3',1,'cuantas-peliculas-tiene-la-saga-de-john-wick-hasta-2023','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('1882c34a-46cd-494e-91b4-a346981e73e8','f6cfa116-466d-4478-b055-7c5bf9f9b4b3','es','¿Cuántas películas tiene la saga de ''John Wick'' (hasta 2023)?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('012414b8-2aff-4c3f-9aa7-6f21bace0b01','f6cfa116-466d-4478-b055-7c5bf9f9b4b3',1,0,'2',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d4e6bbc4-53b2-4be5-a99b-497a5c38bb0c','f6cfa116-466d-4478-b055-7c5bf9f9b4b3',1,1,'3',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('647f9a03-0cb7-4b8d-95e4-6441ca0874bb','f6cfa116-466d-4478-b055-7c5bf9f9b4b3',1,2,'4',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('82ecb367-4481-4c28-b106-317845bf92b7','f6cfa116-466d-4478-b055-7c5bf9f9b4b3',1,3,'5',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('6d127c23-dcd7-4d26-9f03-eb4e8ea6f159',1,'quien-interpreta-a-john-wick','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('3f624a70-2db0-4689-9d34-12d9589bbb6c','6d127c23-dcd7-4d26-9f03-eb4e8ea6f159','es','¿Quién interpreta a John Wick?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5c493ccd-2692-48e4-9d1c-2e4a1e34c7cb','6d127c23-dcd7-4d26-9f03-eb4e8ea6f159',1,0,'Tom Cruise',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6bc87b98-11c9-435e-b174-ead7fadb25fe','6d127c23-dcd7-4d26-9f03-eb4e8ea6f159',1,1,'Keanu Reeves',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6446460e-b427-45f5-b12f-352353382869','6d127c23-dcd7-4d26-9f03-eb4e8ea6f159',1,2,'Dwayne Johnson',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('59d9c247-1abe-43b8-81be-97f207e047f7','6d127c23-dcd7-4d26-9f03-eb4e8ea6f159',1,3,'Jason Statham',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('b7eb4296-a70f-41b2-93c3-cd7c30b1501a',1,'en-que-ano-se-estreno-avengers-endgame','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('7997505c-da6b-450f-8648-72e6ffda226d','b7eb4296-a70f-41b2-93c3-cd7c30b1501a','es','¿En qué año se estrenó ''Avengers: Endgame''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('bd6b16c7-3948-41ff-9119-f71f9e880e30','b7eb4296-a70f-41b2-93c3-cd7c30b1501a',1,0,'2018',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b78027f6-b44e-4f92-8912-94ff135d9908','b7eb4296-a70f-41b2-93c3-cd7c30b1501a',1,1,'2019',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('21057448-0dcb-4107-8db0-1f6589d1e6af','b7eb4296-a70f-41b2-93c3-cd7c30b1501a',1,2,'2020',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('de64d41e-ba38-4097-9d06-25be09ba7533','b7eb4296-a70f-41b2-93c3-cd7c30b1501a',1,3,'2021',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('d8eed3bb-5768-4cc7-9c8d-e7545e90f348',1,'que-personaje-de-marvel-dice-la-frase-i-am-groot','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('b76b189d-99eb-444d-a13c-528c3ebcaf8a','d8eed3bb-5768-4cc7-9c8d-e7545e90f348','es','¿Qué personaje de Marvel dice la frase ''I am Groot''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('fafab447-cf5b-4942-92b1-53fc48b0cd52','d8eed3bb-5768-4cc7-9c8d-e7545e90f348',1,0,'Rocket Raccoon',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('800d3a66-58cf-453e-acd8-b538927ef405','d8eed3bb-5768-4cc7-9c8d-e7545e90f348',1,1,'Thanos',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('00d989e5-4ed1-4aff-85dd-037e69a85682','d8eed3bb-5768-4cc7-9c8d-e7545e90f348',1,2,'Groot',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('15ee81d2-a04b-4af0-820e-a16bdc77a0ab','d8eed3bb-5768-4cc7-9c8d-e7545e90f348',1,3,'Nebula',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('37b588b1-1484-48ba-84d5-7eb3ae717505',1,'cuantas-temporadas-tiene-la-serie-narcos','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('e4271229-c2b8-4558-9281-66e17b0706d6','37b588b1-1484-48ba-84d5-7eb3ae717505','es','¿Cuántas temporadas tiene la serie ''Narcos''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1c4a540a-5df7-4a6a-97d0-9a7ed9a87096','37b588b1-1484-48ba-84d5-7eb3ae717505',1,0,'2',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b783679e-fc1e-4090-9230-878403b16b59','37b588b1-1484-48ba-84d5-7eb3ae717505',1,1,'3',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d15f4436-8dc2-4cbf-8073-a1cd10e6f18b','37b588b1-1484-48ba-84d5-7eb3ae717505',1,2,'4',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('36e91d93-c257-4143-8638-ac176487429a','37b588b1-1484-48ba-84d5-7eb3ae717505',1,3,'5',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('df4c4b5e-49cb-4ec2-805d-b3c94c2fece9',1,'en-que-ano-se-estreno-la-pelicula-interstellar','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('1a8d6631-2869-4bd0-a991-0fc3c6bd9e70','df4c4b5e-49cb-4ec2-805d-b3c94c2fece9','es','¿En qué año se estrenó la película ''Interstellar''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ae2ba8d3-5d2d-42b7-a31f-765b18a8f5cc','df4c4b5e-49cb-4ec2-805d-b3c94c2fece9',1,0,'2012',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('eaf10aa6-c0c0-41a7-ba78-3e3cd7c79bf2','df4c4b5e-49cb-4ec2-805d-b3c94c2fece9',1,1,'2013',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('276bdbf9-fedf-458f-9283-6b50363029bc','df4c4b5e-49cb-4ec2-805d-b3c94c2fece9',1,2,'2014',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1ce08119-30af-48fe-ae8b-e40840bd01a1','df4c4b5e-49cb-4ec2-805d-b3c94c2fece9',1,3,'2015',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('9080eb9e-0a93-497e-8a89-b751972d6cc2',1,'de-que-pais-es-el-cantante-feid','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('26693b5e-2e66-4f01-a9dc-aaf83590af86','9080eb9e-0a93-497e-8a89-b751972d6cc2','es','¿De qué país es el cantante Feid?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a1a0b779-0546-425b-881e-705e3ee5d8c5','9080eb9e-0a93-497e-8a89-b751972d6cc2',1,0,'Venezuela',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9063b57a-3de3-45ba-a515-37b37536f30b','9080eb9e-0a93-497e-8a89-b751972d6cc2',1,1,'Colombia',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ab098707-9592-4b81-a2d5-986298992d92','9080eb9e-0a93-497e-8a89-b751972d6cc2',1,2,'México',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('de9e2068-a559-4e13-81c5-da6648685fc3','9080eb9e-0a93-497e-8a89-b751972d6cc2',1,3,'Argentina',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('d541b92c-2a02-46c6-8bd8-1fb3bf8beb02',1,'como-se-llama-el-primer-album-de-bad-bunny','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('780aaa56-0d35-4d87-afde-0df731917012','d541b92c-2a02-46c6-8bd8-1fb3bf8beb02','es','¿Cómo se llama el primer álbum de Bad Bunny?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9a6cf9b7-263b-46e5-b208-3ca4fe94c632','d541b92c-2a02-46c6-8bd8-1fb3bf8beb02',1,0,'YHLQMDLG',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8a71ce58-0ce1-4511-a560-6d0d03289f37','d541b92c-2a02-46c6-8bd8-1fb3bf8beb02',1,1,'Un Verano Sin Ti',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ba07a066-26d6-417b-a37b-5c26b4220baf','d541b92c-2a02-46c6-8bd8-1fb3bf8beb02',1,2,'X 100PRE',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5917e5bc-7661-41f6-8c3d-618d6ce6b737','d541b92c-2a02-46c6-8bd8-1fb3bf8beb02',1,3,'El Último Tour del Mundo',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('d9837f1b-242a-49f7-8996-ef6dc41c990f',1,'en-que-ano-gano-billie-eilish-su-primer-grammy-a-album-del-ano','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('9eedf8ad-99e2-49b3-acf7-cebe39ab4f95','d9837f1b-242a-49f7-8996-ef6dc41c990f','es','¿En qué año ganó Billie Eilish su primer Grammy a Álbum del Año?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('05424356-eaac-4a41-ae85-2529ab284f95','d9837f1b-242a-49f7-8996-ef6dc41c990f',1,0,'2019',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('fc1dd0cd-7ef1-4f53-b157-0cbf4b4a9bfb','d9837f1b-242a-49f7-8996-ef6dc41c990f',1,1,'2020',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d00155f9-5c13-4abc-b35d-74041752f8ff','d9837f1b-242a-49f7-8996-ef6dc41c990f',1,2,'2021',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('fbb34db7-c81f-4a4b-96aa-d5f95410e386','d9837f1b-242a-49f7-8996-ef6dc41c990f',1,3,'2022',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('555ac268-b2fa-4ab0-8684-6f2ced39b51c',1,'cuantos-grammys-tiene-beyonce-record-historico-hasta-2024','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('88c045b6-9195-4e68-a70d-dee82075fe92','555ac268-b2fa-4ab0-8684-6f2ced39b51c','es','¿Cuántos Grammys tiene Beyoncé (récord histórico, hasta 2024)?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('20182b4e-0943-4262-ade8-b3b0d5730459','555ac268-b2fa-4ab0-8684-6f2ced39b51c',1,0,'25',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('fa69b345-fb17-4066-831c-6af61a87043a','555ac268-b2fa-4ab0-8684-6f2ced39b51c',1,1,'28',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('cbd7b09b-702e-43db-9ab0-82d934be12bb','555ac268-b2fa-4ab0-8684-6f2ced39b51c',1,2,'30',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8c621539-4349-4eb0-b92b-4742125ac56a','555ac268-b2fa-4ab0-8684-6f2ced39b51c',1,3,'32',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('7a0d9fdc-3b9a-41e9-ba82-75f9abb5dd58',1,'de-que-pais-es-el-cantante-rauw-alejandro','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('88af323e-ded2-42c7-9187-bb1873aff480','7a0d9fdc-3b9a-41e9-ba82-75f9abb5dd58','es','¿De qué país es el cantante Rauw Alejandro?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a484fee0-c3aa-4db6-a363-2f320245e8a7','7a0d9fdc-3b9a-41e9-ba82-75f9abb5dd58',1,0,'Colombia',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('174083bc-5949-4ab1-90ce-c9a8abd92eed','7a0d9fdc-3b9a-41e9-ba82-75f9abb5dd58',1,1,'Puerto Rico',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('dabb51a3-79f6-47fc-866f-01e5b488b306','7a0d9fdc-3b9a-41e9-ba82-75f9abb5dd58',1,2,'Rep. Dominicana',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3babc927-f680-4161-8dcf-f8196c91879b','7a0d9fdc-3b9a-41e9-ba82-75f9abb5dd58',1,3,'México',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('5840ed3a-d174-4bc7-9ace-92f310d53d61',1,'en-que-ano-se-formo-el-grupo-bts','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('25f8e1c8-1806-4e34-b5d0-bac22bc367dd','5840ed3a-d174-4bc7-9ace-92f310d53d61','es','¿En qué año se formó el grupo BTS?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('42ee885d-8f5b-4ddf-8330-74ed86174519','5840ed3a-d174-4bc7-9ace-92f310d53d61',1,0,'2011',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f44516ee-ac93-4691-ad70-c4090ccc03c6','5840ed3a-d174-4bc7-9ace-92f310d53d61',1,1,'2012',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7cb52ca7-eaee-4074-874c-31110a8a357d','5840ed3a-d174-4bc7-9ace-92f310d53d61',1,2,'2013',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('98095026-4307-44da-86d2-6dacfc479a4c','5840ed3a-d174-4bc7-9ace-92f310d53d61',1,3,'2014',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('405d1cfc-14db-4323-94c6-4b054187f8a2',1,'cuantos-albumes-de-estudio-tiene-taylor-swift-hasta-2024','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('34abd033-124b-4607-8239-8b9f90a94217','405d1cfc-14db-4323-94c6-4b054187f8a2','es','¿Cuántos álbumes de estudio tiene Taylor Swift (hasta 2024)?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('fef38fc6-c723-4ce4-87ed-0a98e43748e1','405d1cfc-14db-4323-94c6-4b054187f8a2',1,0,'8',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('932843e2-2f05-4ccf-ae33-e64c59c6a3c8','405d1cfc-14db-4323-94c6-4b054187f8a2',1,1,'9',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('94ea06de-1ec4-4ecd-a30f-184f3dd9a9f9','405d1cfc-14db-4323-94c6-4b054187f8a2',1,2,'10',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('17bba060-8d3b-4703-af43-68c8a1e363d1','405d1cfc-14db-4323-94c6-4b054187f8a2',1,3,'11',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('e51a09bd-e037-4311-8df1-a4019155f916',1,'que-significa-yhlqmdlg-el-album-de-bad-bunny','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('8ba70003-3191-492f-a24a-31aa405bbcae','e51a09bd-e037-4311-8df1-a4019155f916','es','¿Qué significa ''YHLQMDLG'', el álbum de Bad Bunny?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e506e80b-1703-4922-a823-175cf0c51b8b','e51a09bd-e037-4311-8df1-a4019155f916',1,0,'Yo Hago Lo Que Me Da La Gana',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('67cf08f9-32a2-47b2-97bc-cf0c516ab5f3','e51a09bd-e037-4311-8df1-a4019155f916',1,1,'Yo Hago Letras Que Me Dan La Gloria',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('01383e59-6a37-49c8-b4dc-e93019515136','e51a09bd-e037-4311-8df1-a4019155f916',1,2,'Yes He Likes Queen',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7d1f75c1-cbdd-4cbb-a295-97bcb5c05046','e51a09bd-e037-4311-8df1-a4019155f916',1,3,'Yendo Hacia La Quinta',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('05b4ce6f-161c-4b81-9c9a-7b93a3a37674',1,'en-que-ano-se-estreno-la-cancion-despacito-de-luis-fonsi','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('dfd4a6bf-586c-4871-a25b-14d0d2ddf775','05b4ce6f-161c-4b81-9c9a-7b93a3a37674','es','¿En qué año se estrenó la canción ''Despacito'' de Luis Fonsi?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f0c4b8f3-c1e9-4597-a9e1-2038753f48b6','05b4ce6f-161c-4b81-9c9a-7b93a3a37674',1,0,'2016',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d25fadc9-8ea0-41c8-ad55-33d5266429f8','05b4ce6f-161c-4b81-9c9a-7b93a3a37674',1,1,'2017',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('69eecbfd-12de-4609-82d3-840e737ea827','05b4ce6f-161c-4b81-9c9a-7b93a3a37674',1,2,'2018',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ae2ec4fe-257e-4ad2-8ea7-9d22ab5f3daa','05b4ce6f-161c-4b81-9c9a-7b93a3a37674',1,3,'2019',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('b5bc6861-d5ac-417f-9daf-43299b386cd3',1,'cuantos-integrantes-tenia-el-grupo-nsync','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('bfaef142-d304-40c1-8859-4747d84595d8','b5bc6861-d5ac-417f-9daf-43299b386cd3','es','¿Cuántos integrantes tenía el grupo NSYNC?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8b4fc3d5-f8e8-4526-bfbd-38a28d67a5c5','b5bc6861-d5ac-417f-9daf-43299b386cd3',1,0,'4',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('148ef912-058c-49cf-a26f-f653e54da730','b5bc6861-d5ac-417f-9daf-43299b386cd3',1,1,'5',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('fc283222-b15d-4abc-98dc-3d193da4d321','b5bc6861-d5ac-417f-9daf-43299b386cd3',1,2,'6',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d89079a9-4e0f-49f1-8f93-a24519980c16','b5bc6861-d5ac-417f-9daf-43299b386cd3',1,3,'7',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('1d462d35-4f89-4f90-903b-687e7f22fece',1,'de-que-pais-es-el-grupo-musical-mana','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('cef6b6ea-8a9d-48c1-bc0a-d27b92609656','1d462d35-4f89-4f90-903b-687e7f22fece','es','¿De qué país es el grupo musical ''Maná''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('20ab4f88-c6c4-4638-8e96-a8eebb9c85d8','1d462d35-4f89-4f90-903b-687e7f22fece',1,0,'Argentina',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f1d62fb9-f4d6-48d5-9b7a-bbabae2da7db','1d462d35-4f89-4f90-903b-687e7f22fece',1,1,'España',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7b629f70-26db-4f38-b6b1-61ebaa60d3c9','1d462d35-4f89-4f90-903b-687e7f22fece',1,2,'Colombia',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c0c19184-7ca6-4831-838b-16687dbb3bc8','1d462d35-4f89-4f90-903b-687e7f22fece',1,3,'México',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('e92742a5-66b3-4372-84ac-33311adc3caa',1,'que-instrumento-toca-principalmente-taylor-swift','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('7ad44316-fca3-453a-9619-e6db222fd800','e92742a5-66b3-4372-84ac-33311adc3caa','es','¿Qué instrumento toca principalmente Taylor Swift?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('79a92f89-78c7-41a5-9d49-57bec1db2c79','e92742a5-66b3-4372-84ac-33311adc3caa',1,0,'Piano',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5705b21d-c17f-4640-b065-6f16b8accb58','e92742a5-66b3-4372-84ac-33311adc3caa',1,1,'Violín',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('49488076-69ab-44c7-af0a-661e7994e6bc','e92742a5-66b3-4372-84ac-33311adc3caa',1,2,'Guitarra',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ba53d21f-4e94-4c97-865a-bc4d239d580f','e92742a5-66b3-4372-84ac-33311adc3caa',1,3,'Bajo',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('e6a1aec8-4e22-4977-b5eb-92d1b998a001',1,'de-que-pais-es-la-cantante-tini-stoessel','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('08335013-be06-418d-9aa9-3643b5aec76b','e6a1aec8-4e22-4977-b5eb-92d1b998a001','es','¿De qué país es la cantante Tini Stoessel?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3262e6c4-2270-4ea2-bff6-54db35fa9220','e6a1aec8-4e22-4977-b5eb-92d1b998a001',1,0,'Colombia',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('bd8be2fc-3840-4f78-bf89-8ebd1a6aa728','e6a1aec8-4e22-4977-b5eb-92d1b998a001',1,1,'Uruguay',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7991020f-9652-4714-a986-cabe2a870fbd','e6a1aec8-4e22-4977-b5eb-92d1b998a001',1,2,'Argentina',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('42f49c67-179d-4f0e-9eed-0b4b4f6a4fe3','e6a1aec8-4e22-4977-b5eb-92d1b998a001',1,3,'Chile',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('fab246fa-3300-4858-84cf-0e993265b30f',1,'en-que-ano-lanzo-justin-bieber-la-cancion-baby','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('902f69ce-3ae9-4bd2-98ed-c3b37280fe1f','fab246fa-3300-4858-84cf-0e993265b30f','es','¿En qué año lanzó Justin Bieber la canción ''Baby''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('fcb48800-1d78-47b9-8a86-940213a2c8d5','fab246fa-3300-4858-84cf-0e993265b30f',1,0,'2008',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a694c8c7-e72d-4bf6-a213-d85f94e32169','fab246fa-3300-4858-84cf-0e993265b30f',1,1,'2009',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b6aae2d3-0b65-43d0-b225-f0fc5848a90a','fab246fa-3300-4858-84cf-0e993265b30f',1,2,'2010',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b3355143-e67c-4a07-a4ea-0a3406b7363b','fab246fa-3300-4858-84cf-0e993265b30f',1,3,'2011',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('27cef332-85b5-4777-be76-c5f90ea544ae',1,'en-que-ano-empezo-spotify-como-servicio-de-streaming','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('ffdae007-36fc-48e7-822c-810b038ebbbe','27cef332-85b5-4777-be76-c5f90ea544ae','es','¿En qué año empezó Spotify como servicio de streaming?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('34740d55-41c0-43ae-b552-362ed4d7a03b','27cef332-85b5-4777-be76-c5f90ea544ae',1,0,'2006',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8d23501d-ed2b-4d27-88a0-7732b97aedf5','27cef332-85b5-4777-be76-c5f90ea544ae',1,1,'2007',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7ba8cd78-9b8e-4f28-ace4-830a15891acb','27cef332-85b5-4777-be76-c5f90ea544ae',1,2,'2008',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7a3ed00c-c5a6-4e40-80a7-a3f859261dde','27cef332-85b5-4777-be76-c5f90ea544ae',1,3,'2009',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('cce27440-d704-4376-bcef-5423ad562956',1,'de-que-pais-es-el-cantante-myke-towers','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('3b3761d5-9507-428a-85d8-9ea47d10897f','cce27440-d704-4376-bcef-5423ad562956','es','¿De qué país es el cantante Myke Towers?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('502101d9-7905-48c4-839f-e5c1581b7c0a','cce27440-d704-4376-bcef-5423ad562956',1,0,'Colombia',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ff7cf9d0-ce81-4bbf-94ae-be4fcf2c3b93','cce27440-d704-4376-bcef-5423ad562956',1,1,'México',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('03ab17d4-21f1-486a-81ee-471975a60962','cce27440-d704-4376-bcef-5423ad562956',1,2,'Puerto Rico',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d4a259ad-e1ed-40d2-bd80-6eca0cda6b65','cce27440-d704-4376-bcef-5423ad562956',1,3,'Rep. Dominicana',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('c8d46113-1d19-409a-8cd8-16a76b347585',1,'cual-es-el-numero-atomico-del-carbono-en-la-tabla-periodica','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('12141461-5c8d-42aa-a572-8510bb8271d7','c8d46113-1d19-409a-8cd8-16a76b347585','es','¿Cuál es el número atómico del carbono en la tabla periódica?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('90186417-0cd3-4647-9625-81d2eb1c008e','c8d46113-1d19-409a-8cd8-16a76b347585',1,0,'4',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7796c317-6f43-437d-aea4-8d8e3f8c00e1','c8d46113-1d19-409a-8cd8-16a76b347585',1,1,'6',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f8059e26-bf55-44f2-916d-0f7fa89e8fb9','c8d46113-1d19-409a-8cd8-16a76b347585',1,2,'8',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a7f79873-a4e9-4b56-bbe7-fec1e92f849a','c8d46113-1d19-409a-8cd8-16a76b347585',1,3,'12',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('ae947ee5-17a6-4eff-b8fc-1ded356958b2',1,'que-organo-del-cuerpo-humano-produce-la-insulina','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('d498a2aa-bd6e-492d-b159-d34e829f66e5','ae947ee5-17a6-4eff-b8fc-1ded356958b2','es','¿Qué órgano del cuerpo humano produce la insulina?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('59fe9675-0918-43ae-a024-1685eba64827','ae947ee5-17a6-4eff-b8fc-1ded356958b2',1,0,'Hígado',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('0d993493-602a-4f0c-8ea7-73b1cbfc2bf7','ae947ee5-17a6-4eff-b8fc-1ded356958b2',1,1,'Riñón',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8e466326-2ff6-48d8-9338-c22006b90135','ae947ee5-17a6-4eff-b8fc-1ded356958b2',1,2,'Páncreas',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c0db505f-3617-44b8-8ae6-11f565d5bb0f','ae947ee5-17a6-4eff-b8fc-1ded356958b2',1,3,'Bazo',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('3428d39e-c8f8-4969-9a2a-8f631fdea66b',1,'cuanto-tarda-la-luz-en-llegar-de-la-luna-a-la-tierra','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('17e61185-83e8-4e59-a412-05275f34d4d9','3428d39e-c8f8-4969-9a2a-8f631fdea66b','es','¿Cuánto tarda la luz en llegar de la Luna a la Tierra?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('2a1ee3cb-d6f3-42ef-8434-91050a270f6a','3428d39e-c8f8-4969-9a2a-8f631fdea66b',1,0,'0.1 segundos',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4168237c-bf23-4a3f-8376-143b460263a5','3428d39e-c8f8-4969-9a2a-8f631fdea66b',1,1,'1.3 segundos',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a9aed7d6-bce8-4b3d-8aac-9fa335bd2e0f','3428d39e-c8f8-4969-9a2a-8f631fdea66b',1,2,'5 segundos',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1d5996cd-faf7-4963-bb1c-f713a5783aaf','3428d39e-c8f8-4969-9a2a-8f631fdea66b',1,3,'10 segundos',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('bfd98b3e-328d-4271-8a50-eab3f9423dd8',1,'cual-es-el-elemento-mas-abundante-en-el-universo','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('c18648a7-f77b-462d-8b2d-8203d121fae7','bfd98b3e-328d-4271-8a50-eab3f9423dd8','es','¿Cuál es el elemento más abundante en el universo?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('cf5094c3-9872-46fe-b355-55e924d14bd3','bfd98b3e-328d-4271-8a50-eab3f9423dd8',1,0,'Helio',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6d6746dc-b7c1-476f-8733-0f3c8a5ef1c5','bfd98b3e-328d-4271-8a50-eab3f9423dd8',1,1,'Hidrógeno',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4df9f826-a749-4a5b-8e56-781ed1b9a083','bfd98b3e-328d-4271-8a50-eab3f9423dd8',1,2,'Oxígeno',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6ec97eec-be5f-4dc4-aec0-2dc36f5277d5','bfd98b3e-328d-4271-8a50-eab3f9423dd8',1,3,'Carbono',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('1d861d1e-3296-4ebd-9b19-54e5ff8161b3',1,'cuantas-neuronas-tiene-el-cerebro-humano-aproximadamente','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('ea38b7d9-59b9-46c4-b93d-d985615ab0bc','1d861d1e-3296-4ebd-9b19-54e5ff8161b3','es','¿Cuántas neuronas tiene el cerebro humano aproximadamente?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('43c25f6a-111d-4893-a99d-9ca927b6df54','1d861d1e-3296-4ebd-9b19-54e5ff8161b3',1,0,'10 mil millones',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('dc13e7a0-be6a-452e-abbc-07c57ee53445','1d861d1e-3296-4ebd-9b19-54e5ff8161b3',1,1,'50 mil millones',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('dfd2c17b-f437-4f4f-beb0-3b87ee47073a','1d861d1e-3296-4ebd-9b19-54e5ff8161b3',1,2,'86 mil millones',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6b0e6747-4163-4b82-b71c-41a76935d2e9','1d861d1e-3296-4ebd-9b19-54e5ff8161b3',1,3,'200 mil millones',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('fbc742a2-26a8-44a6-9abc-eeeab108ac60',1,'que-animal-tiene-la-mordida-mas-fuerte-del-mundo','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('2aefcfab-c940-4dd9-8c72-2e6fb7237b18','fbc742a2-26a8-44a6-9abc-eeeab108ac60','es','¿Qué animal tiene la mordida más fuerte del mundo?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ab9c095b-02e6-4727-8d6d-03c80754ab33','fbc742a2-26a8-44a6-9abc-eeeab108ac60',1,0,'León',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f2e2b67b-e743-4817-812d-f3fedfe4e5d7','fbc742a2-26a8-44a6-9abc-eeeab108ac60',1,1,'Tiburón blanco',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a380af12-0613-4b44-aab3-45d7755fa1d0','fbc742a2-26a8-44a6-9abc-eeeab108ac60',1,2,'Hiena manchada',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ef77c161-31ca-4866-abc3-72ed9bf93f5b','fbc742a2-26a8-44a6-9abc-eeeab108ac60',1,3,'Cocodrilo del Nilo',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('bd999052-abbb-49c3-92f5-1f8cdf97c4f5',1,'cuantos-huesos-tiene-el-pie-humano','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('1b3e6039-fc49-4578-8fb7-1ef12c5912cc','bd999052-abbb-49c3-92f5-1f8cdf97c4f5','es','¿Cuántos huesos tiene el pie humano?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8fa8f13d-702e-4a66-8f09-50ee68805c10','bd999052-abbb-49c3-92f5-1f8cdf97c4f5',1,0,'20',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('874f3870-8e70-401f-924c-f311f4033bb9','bd999052-abbb-49c3-92f5-1f8cdf97c4f5',1,1,'23',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e38c58f4-d217-4350-a588-899f910a0401','bd999052-abbb-49c3-92f5-1f8cdf97c4f5',1,2,'26',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('48a26c3b-e62c-47b9-8c32-d53402abe296','bd999052-abbb-49c3-92f5-1f8cdf97c4f5',1,3,'30',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('5bda2674-5930-4a2d-9117-01b206de3a20',1,'cual-es-la-velocidad-del-sonido-en-el-aire-aproximadamente','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('68f913fd-f35a-4c28-b6dd-6ea02ab97f41','5bda2674-5930-4a2d-9117-01b206de3a20','es','¿Cuál es la velocidad del sonido en el aire aproximadamente?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('918b3af7-bde1-4461-8dba-825b92101d81','5bda2674-5930-4a2d-9117-01b206de3a20',1,0,'200 m/s',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f50f34c7-9989-4d09-ab01-4eea7776be91','5bda2674-5930-4a2d-9117-01b206de3a20',1,1,'343 m/s',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('63bf3c36-598d-4273-847e-a5d70b766293','5bda2674-5930-4a2d-9117-01b206de3a20',1,2,'500 m/s',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('98c679d9-cd16-47a0-82da-aca03cb1f0d5','5bda2674-5930-4a2d-9117-01b206de3a20',1,3,'1000 m/s',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('f4ffb4b6-865e-48ac-9e98-7a308e11f9d3',1,'cuantos-planetas-del-sistema-solar-tienen-anillos','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('874821db-2eea-42b9-83aa-b8651aaa9338','f4ffb4b6-865e-48ac-9e98-7a308e11f9d3','es','¿Cuántos planetas del sistema solar tienen anillos?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('66f3667d-348c-4a31-b47c-43347f609c39','f4ffb4b6-865e-48ac-9e98-7a308e11f9d3',1,0,'1',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('52c9aa8d-1f5e-4631-8f6d-d9fc50cad075','f4ffb4b6-865e-48ac-9e98-7a308e11f9d3',1,1,'2',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('fb324643-aa17-4767-b5bf-fd268fc18171','f4ffb4b6-865e-48ac-9e98-7a308e11f9d3',1,2,'3',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('07892e3e-0666-455b-82c4-7901b060151c','f4ffb4b6-865e-48ac-9e98-7a308e11f9d3',1,3,'4',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('9e9121c0-b7c7-4a17-ae32-f4a5b77ddc69',1,'cual-es-el-metal-mas-conductor-de-electricidad','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('2d4d47bb-a60a-4bf8-83d5-e34d1e110384','9e9121c0-b7c7-4a17-ae32-f4a5b77ddc69','es','¿Cuál es el metal más conductor de electricidad?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('491445a0-ab2d-4126-8d91-b234c96b2ad6','9e9121c0-b7c7-4a17-ae32-f4a5b77ddc69',1,0,'Oro',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a2f2a9fe-6850-47ef-86f8-120d754f2105','9e9121c0-b7c7-4a17-ae32-f4a5b77ddc69',1,1,'Cobre',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('0cb637be-120e-45aa-95b4-bc6be6e8bc48','9e9121c0-b7c7-4a17-ae32-f4a5b77ddc69',1,2,'Plata',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('58d0a9a9-12bf-4df8-9628-514163fd80cf','9e9121c0-b7c7-4a17-ae32-f4a5b77ddc69',1,3,'Aluminio',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('a8a528a5-0bd5-4054-a3e6-6e7ebcb4fada',1,'cual-es-el-gas-predominante-en-la-atmosfera-de-marte','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('293a50aa-bd80-41d2-8ac0-5c31abfc78c2','a8a528a5-0bd5-4054-a3e6-6e7ebcb4fada','es','¿Cuál es el gas predominante en la atmósfera de Marte?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f7b35814-1fd2-499b-93e6-d2ee41b1b6cf','a8a528a5-0bd5-4054-a3e6-6e7ebcb4fada',1,0,'Nitrógeno',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e3b1c122-3ecb-46d6-b835-852864b2a312','a8a528a5-0bd5-4054-a3e6-6e7ebcb4fada',1,1,'Oxígeno',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b5a4c613-7b41-4b57-bfd9-f543dbc22c68','a8a528a5-0bd5-4054-a3e6-6e7ebcb4fada',1,2,'Dióxido de carbono',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('16eeb75c-4746-4943-87f5-6d5ba99fb44a','a8a528a5-0bd5-4054-a3e6-6e7ebcb4fada',1,3,'Argón',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('a39737bb-d3e2-42e3-939d-a67fd04c4f19',1,'cuantos-dientes-de-leche-tiene-un-nino','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('ea2e330d-0215-4079-a1f9-b0dc0da8f274','a39737bb-d3e2-42e3-939d-a67fd04c4f19','es','¿Cuántos dientes de leche tiene un niño?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1193f5bd-556d-4882-b8fd-b32f2c339844','a39737bb-d3e2-42e3-939d-a67fd04c4f19',1,0,'16',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7b7337f4-9556-4b69-9bff-ead9062a45d2','a39737bb-d3e2-42e3-939d-a67fd04c4f19',1,1,'18',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('90c3f624-2828-4a50-8bd6-59f003410c31','a39737bb-d3e2-42e3-939d-a67fd04c4f19',1,2,'20',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6842aae9-9c22-4c70-8324-f6ad873f1d64','a39737bb-d3e2-42e3-939d-a67fd04c4f19',1,3,'22',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('3d21c37a-22a8-4268-b1cb-2a32cd85042a',1,'cual-es-el-metal-mas-pesado-de-la-tabla-periodica','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('caa68a18-f215-43b9-bb68-1a8bb1a6502a','3d21c37a-22a8-4268-b1cb-2a32cd85042a','es','¿Cuál es el metal más pesado de la tabla periódica?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b3a6a35a-5f13-442b-ab8b-a791a3df5d86','3d21c37a-22a8-4268-b1cb-2a32cd85042a',1,0,'Plomo',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9ffb58af-2080-4818-a46b-a4d2c354b345','3d21c37a-22a8-4268-b1cb-2a32cd85042a',1,1,'Oro',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('99121b88-e838-412f-8b0b-089e05be4a31','3d21c37a-22a8-4268-b1cb-2a32cd85042a',1,2,'Mercurio',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5840dcb2-035f-4bf6-81ad-b00fa5f7d750','3d21c37a-22a8-4268-b1cb-2a32cd85042a',1,3,'Osmio',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('97485c1a-bbe1-4374-b8bd-9562aed8e99b',1,'que-planeta-tarda-mas-en-dar-una-vuelta-al-sol','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('6b468bd1-03fa-4f81-86aa-308164b3510e','97485c1a-bbe1-4374-b8bd-9562aed8e99b','es','¿Qué planeta tarda más en dar una vuelta al Sol?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('823d955b-3e45-4f58-9651-1982a26b770f','97485c1a-bbe1-4374-b8bd-9562aed8e99b',1,0,'Saturno',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a072a2ed-596d-4fd2-b5d9-825f6c919fd0','97485c1a-bbe1-4374-b8bd-9562aed8e99b',1,1,'Urano',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('179213b7-21c9-49a9-829b-3537daf0b89b','97485c1a-bbe1-4374-b8bd-9562aed8e99b',1,2,'Neptuno',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8cfcb3ab-1430-489d-a5fc-72d85a63701d','97485c1a-bbe1-4374-b8bd-9562aed8e99b',1,3,'Plutón',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('56394974-4c7d-48ff-bffe-8931c9ee461d',1,'cuantos-lobulos-tiene-el-pulmon-derecho-humano','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('3efdc456-e1e9-4035-b48c-00036f201348','56394974-4c7d-48ff-bffe-8931c9ee461d','es','¿Cuántos lóbulos tiene el pulmón derecho humano?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('47741844-727e-47d1-a105-d8cbaf538ff8','56394974-4c7d-48ff-bffe-8931c9ee461d',1,0,'2',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1e51c004-9aa0-4d4f-ba45-3f97ceb6a96e','56394974-4c7d-48ff-bffe-8931c9ee461d',1,1,'3',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('41139534-c180-4031-878e-52347f39dd44','56394974-4c7d-48ff-bffe-8931c9ee461d',1,2,'4',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3852ab55-4438-4df0-ac7f-7acd87e6ae7b','56394974-4c7d-48ff-bffe-8931c9ee461d',1,3,'5',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('8b50cbbf-ca83-4f28-8ef6-9a7e58545175',1,'que-tipo-de-estrella-es-nuestro-sol-segun-su-clasificacion','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('92b14e5d-7624-4f0d-836b-cb8e06eb5cd7','8b50cbbf-ca83-4f28-8ef6-9a7e58545175','es','¿Qué tipo de estrella es nuestro Sol según su clasificación?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b0649fc0-7f02-465c-bea0-afa5c6ba14df','8b50cbbf-ca83-4f28-8ef6-9a7e58545175',1,0,'Supergigante azul',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('822d8040-af19-4a35-8c58-04080732d930','8b50cbbf-ca83-4f28-8ef6-9a7e58545175',1,1,'Gigante roja',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5d86897d-30c9-4efb-b2bd-8e30ba4cac10','8b50cbbf-ca83-4f28-8ef6-9a7e58545175',1,2,'Enana amarilla',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d4f6b7e2-ea62-44af-abf5-ae7913044675','8b50cbbf-ca83-4f28-8ef6-9a7e58545175',1,3,'Enana blanca',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('6aa04da7-6232-4af9-a0e8-e8ac5074ba63',1,'cuantos-cromosomas-tiene-una-persona-con-sindrome-de-down','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('035095d1-7105-4651-a6f2-674745db04c9','6aa04da7-6232-4af9-a0e8-e8ac5074ba63','es','¿Cuántos cromosomas tiene una persona con Síndrome de Down?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ef6a1282-c4ec-4950-a773-59fd73329329','6aa04da7-6232-4af9-a0e8-e8ac5074ba63',1,0,'44',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6d125501-102e-4f14-99fc-570a2fdb83b1','6aa04da7-6232-4af9-a0e8-e8ac5074ba63',1,1,'45',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9d648995-67dd-45bf-9c82-a1998407ee28','6aa04da7-6232-4af9-a0e8-e8ac5074ba63',1,2,'46',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('990f9326-e919-43b8-9579-510a9bf1873a','6aa04da7-6232-4af9-a0e8-e8ac5074ba63',1,3,'47',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('1b544385-4d8e-4c35-8137-10213920bcdf',1,'a-cuantos-kmh-puede-volar-una-paloma-mensajera','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('d74a1691-4cca-4dc4-a2dd-c3e02905db00','1b544385-4d8e-4c35-8137-10213920bcdf','es','¿A cuántos km/h puede volar una paloma mensajera?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9c2228d7-7dcf-4ce8-9ec8-068f6b240388','1b544385-4d8e-4c35-8137-10213920bcdf',1,0,'30 km/h',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('907bf647-5c23-40eb-b9d4-5e1d8cd61326','1b544385-4d8e-4c35-8137-10213920bcdf',1,1,'60 km/h',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3bd4aa3b-10b6-40a1-a249-a7f3fa866cd7','1b544385-4d8e-4c35-8137-10213920bcdf',1,2,'100 km/h',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d3987a8d-e27d-4c71-8611-27c18d4a1d45','1b544385-4d8e-4c35-8137-10213920bcdf',1,3,'150 km/h',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('fdb48162-cc22-4899-9b10-d18f0f0140ea',1,'en-que-ano-gano-argentina-su-primer-mundial-de-futbol','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('b023ea4f-bc5a-4b8f-9526-df0d967eb1ea','fdb48162-cc22-4899-9b10-d18f0f0140ea','es','¿En qué año ganó Argentina su primer Mundial de Fútbol?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('2d7fc698-ccbf-4219-a779-bb02bcc0343b','fdb48162-cc22-4899-9b10-d18f0f0140ea',1,0,'1974',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('37429484-0b64-4d96-83c9-b7aefd517dcf','fdb48162-cc22-4899-9b10-d18f0f0140ea',1,1,'1978',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e36f5d60-a1e2-4052-9975-90a0a758818a','fdb48162-cc22-4899-9b10-d18f0f0140ea',1,2,'1982',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('463a4ca0-6ce9-4d8d-b105-9ba0d0ecdd91','fdb48162-cc22-4899-9b10-d18f0f0140ea',1,3,'1986',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('7b093074-b614-46cc-929e-f056695b0cd5',1,'cuantos-mundiales-gano-alemania','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('23498979-29fa-4ef6-8b4e-545e54d3c5a6','7b093074-b614-46cc-929e-f056695b0cd5','es','¿Cuántos mundiales ganó Alemania?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('334065e6-cc91-4a81-88a8-95515d93a8f9','7b093074-b614-46cc-929e-f056695b0cd5',1,0,'3',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('853f2fc1-f7d7-4cff-aa72-7b3cadb7b2f9','7b093074-b614-46cc-929e-f056695b0cd5',1,1,'4',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('643be0a8-a6a4-43a7-9f19-3e4e306c6211','7b093074-b614-46cc-929e-f056695b0cd5',1,2,'5',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('73855fdf-0eba-424a-b3b2-efd7963adef8','7b093074-b614-46cc-929e-f056695b0cd5',1,3,'6',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('3b34e6e1-1efb-42b1-952d-8bbe1c9832f7',1,'quien-gano-la-bota-de-oro-del-mundial-2022-mas-goles','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('79179dd5-e78e-4fd9-9fee-12f1fdf877ba','3b34e6e1-1efb-42b1-952d-8bbe1c9832f7','es','¿Quién ganó la Bota de Oro del Mundial 2022 (más goles)?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e05933bd-a7e4-4a24-aa07-f64446b29aab','3b34e6e1-1efb-42b1-952d-8bbe1c9832f7',1,0,'Messi',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('000d0d51-ffc9-4c8d-a4d3-adec160a07a2','3b34e6e1-1efb-42b1-952d-8bbe1c9832f7',1,1,'Mbappé',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c785697e-d34f-4b08-957d-434b95a72846','3b34e6e1-1efb-42b1-952d-8bbe1c9832f7',1,2,'Benzema',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1d9970df-0272-49e9-b2d3-caf17b629394','3b34e6e1-1efb-42b1-952d-8bbe1c9832f7',1,3,'Neymar',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('d80d2387-76cf-44d4-a1b1-520124385b01',1,'en-que-ano-nacio-lionel-messi','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('c773d0e6-eeae-4aaa-a2b9-cc98b08e4dc8','d80d2387-76cf-44d4-a1b1-520124385b01','es','¿En qué año nació Lionel Messi?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3be8ba60-613f-4e4c-adc9-227fc9e3ab16','d80d2387-76cf-44d4-a1b1-520124385b01',1,0,'1985',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7754f62a-659a-4853-91f5-a707f9b210a3','d80d2387-76cf-44d4-a1b1-520124385b01',1,1,'1986',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3b934d64-21a6-4fc0-9854-c71fbee5d904','d80d2387-76cf-44d4-a1b1-520124385b01',1,2,'1987',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('07f584bf-d661-44e6-aef8-d1a3070c6b1a','d80d2387-76cf-44d4-a1b1-520124385b01',1,3,'1988',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('87dadc6e-bbff-4de5-b06e-4132acf8d1d1',1,'cuantos-mundiales-jugo-diego-maradona-como-jugador','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('4e57ddc0-8643-4dd3-86e7-5edb800e0444','87dadc6e-bbff-4de5-b06e-4132acf8d1d1','es','¿Cuántos Mundiales jugó Diego Maradona como jugador?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('35341b52-1e90-43b6-b639-485dfd5e4f8d','87dadc6e-bbff-4de5-b06e-4132acf8d1d1',1,0,'3',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e521f88b-f8bc-4950-92c6-b40ff94602d1','87dadc6e-bbff-4de5-b06e-4132acf8d1d1',1,1,'4',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('fa56223e-dda0-4716-90eb-a3b739ebd79d','87dadc6e-bbff-4de5-b06e-4132acf8d1d1',1,2,'5',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('09baef7d-a577-48f7-b5e0-6f824eeb5a1b','87dadc6e-bbff-4de5-b06e-4132acf8d1d1',1,3,'6',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('1a2097b1-4f74-48a0-ab7f-fbf20d705ff4',1,'en-que-estadio-se-jugo-la-final-del-mundial-qatar-2022','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('ce933034-72c0-404b-9550-4b446241ba91','1a2097b1-4f74-48a0-ab7f-fbf20d705ff4','es','¿En qué estadio se jugó la final del Mundial Qatar 2022?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5a28d24a-2960-4321-afd2-8b3f308c199c','1a2097b1-4f74-48a0-ab7f-fbf20d705ff4',1,0,'Al Bayt Stadium',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d2232208-0302-4cab-be86-6621ad4d4e76','1a2097b1-4f74-48a0-ab7f-fbf20d705ff4',1,1,'Lusail Stadium',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3ea89658-69bd-4794-9bb0-e97ac15ab451','1a2097b1-4f74-48a0-ab7f-fbf20d705ff4',1,2,'Education City',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('0ebca845-ef5f-4767-aa91-8e5e92aad1c6','1a2097b1-4f74-48a0-ab7f-fbf20d705ff4',1,3,'Al Thumama',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('bd87bbc6-ff01-43ad-99bc-1791da9afeab',1,'cuantos-titulos-de-copa-america-gano-argentina-hasta-2024','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('ea1306e4-10cc-4fc2-ad5b-8a15d809a131','bd87bbc6-ff01-43ad-99bc-1791da9afeab','es','¿Cuántos títulos de Copa América ganó Argentina (hasta 2024)?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5b5e809d-f74b-48e6-8097-26cb2ee5936d','bd87bbc6-ff01-43ad-99bc-1791da9afeab',1,0,'14',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a2a4be39-78eb-4d33-a8f6-f51a41b22d74','bd87bbc6-ff01-43ad-99bc-1791da9afeab',1,1,'15',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4fc34b5c-6c99-4378-97e2-b7ccd9b716d2','bd87bbc6-ff01-43ad-99bc-1791da9afeab',1,2,'16',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('12d7086f-dd2d-4fc4-95b7-4a8ed6c4fb98','bd87bbc6-ff01-43ad-99bc-1791da9afeab',1,3,'17',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('cde82dc2-f08f-4139-beb4-caa7b7dec8a4',1,'cuantos-titulos-de-champions-league-gano-cristiano-ronaldo','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('2c42c83b-a34a-488f-b1f6-d8ee0d1fc0d8','cde82dc2-f08f-4139-beb4-caa7b7dec8a4','es','¿Cuántos títulos de Champions League ganó Cristiano Ronaldo?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a7a7d231-d344-4248-ae83-508cabd50981','cde82dc2-f08f-4139-beb4-caa7b7dec8a4',1,0,'3',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('0953038b-d631-4a96-83c8-8a45ac1eaa67','cde82dc2-f08f-4139-beb4-caa7b7dec8a4',1,1,'4',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('011cd1da-0555-4513-a3e9-5e0b9653b5fb','cde82dc2-f08f-4139-beb4-caa7b7dec8a4',1,2,'5',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ee78347b-e2dc-4cd7-9c50-04f0b376c493','cde82dc2-f08f-4139-beb4-caa7b7dec8a4',1,3,'6',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('6af20048-cf25-4cb8-80f3-cbafa6048e3d',1,'en-que-club-argentino-jugo-maradona-mas-tiempo','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('3e72222d-ef8b-40fa-b53c-e3e392267af8','6af20048-cf25-4cb8-80f3-cbafa6048e3d','es','¿En qué club argentino jugó Maradona más tiempo?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d7586255-4e74-4e19-acaa-2e5e2f1afb22','6af20048-cf25-4cb8-80f3-cbafa6048e3d',1,0,'River Plate',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('21c25970-cda8-4723-83ee-4c6ac904267f','6af20048-cf25-4cb8-80f3-cbafa6048e3d',1,1,'Boca Juniors',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('98748dd5-daa2-4b5c-b589-d8b8b12ed283','6af20048-cf25-4cb8-80f3-cbafa6048e3d',1,2,'Racing Club',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('30313fac-39d4-4a25-babf-089b3f7f2bd6','6af20048-cf25-4cb8-80f3-cbafa6048e3d',1,3,'Independiente',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('eefbfd50-c8f4-4bf9-a754-f2f040b1c1ab',1,'cuantos-equipos-tiene-la-nba-actualmente','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('76b38e33-a341-41be-a0b7-1ca0ab091b94','eefbfd50-c8f4-4bf9-a754-f2f040b1c1ab','es','¿Cuántos equipos tiene la NBA actualmente?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f159d537-fa6f-4ee9-b875-51c78dc6772b','eefbfd50-c8f4-4bf9-a754-f2f040b1c1ab',1,0,'28',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c74722c5-cfb1-49c1-b74b-53d942f08a72','eefbfd50-c8f4-4bf9-a754-f2f040b1c1ab',1,1,'29',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4f273ef3-2650-4ba7-8762-b2d5dc6f2382','eefbfd50-c8f4-4bf9-a754-f2f040b1c1ab',1,2,'30',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('bd1abdac-ed32-4cab-96dd-6f1b0ec7452e','eefbfd50-c8f4-4bf9-a754-f2f040b1c1ab',1,3,'32',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('544689a9-a1c7-45f6-ae62-c8daac2dedef',1,'cuantas-medallas-de-oro-gano-michael-phelps-en-juegos-olimpicos','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('b9cf5052-83b2-4d89-a507-3f107da4bc94','544689a9-a1c7-45f6-ae62-c8daac2dedef','es','¿Cuántas medallas de oro ganó Michael Phelps en Juegos Olímpicos?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('32167456-c433-40ae-b1d9-8b60f5797df4','544689a9-a1c7-45f6-ae62-c8daac2dedef',1,0,'18',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('99faf0ea-b714-4550-a3f4-9294b6a0a2ba','544689a9-a1c7-45f6-ae62-c8daac2dedef',1,1,'20',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('883561de-07a8-4917-a914-e45579b96fde','544689a9-a1c7-45f6-ae62-c8daac2dedef',1,2,'23',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f507152d-73aa-4cc1-8af9-69d9379dbff4','544689a9-a1c7-45f6-ae62-c8daac2dedef',1,3,'25',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('e545d3f9-ecc9-4480-87ea-a7a0765dc193',1,'que-deporte-invento-james-naismith','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('95741a20-58fe-419e-b429-bf0a57246f91','e545d3f9-ecc9-4480-87ea-a7a0765dc193','es','¿Qué deporte inventó James Naismith?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8f610499-e232-4772-9552-524cbaba222a','e545d3f9-ecc9-4480-87ea-a7a0765dc193',1,0,'Béisbol',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ee1f5b0c-0ff3-4fad-80cd-4e3810232392','e545d3f9-ecc9-4480-87ea-a7a0765dc193',1,1,'Básquetbol',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('dab5b050-ab3a-4d23-986e-6c927bbfd32e','e545d3f9-ecc9-4480-87ea-a7a0765dc193',1,2,'Voleibol',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('407a3fd2-f562-49b6-a86d-6d0bf8806fe9','e545d3f9-ecc9-4480-87ea-a7a0765dc193',1,3,'Handball',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('9e4d2d2b-2909-4222-8b4c-ed5916622e23',1,'en-que-ano-fueron-los-primeros-juegos-olimpicos-modernos','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('e157a6f1-ad77-4ce0-a3cf-a0265b3106c3','9e4d2d2b-2909-4222-8b4c-ed5916622e23','es','¿En qué año fueron los primeros Juegos Olímpicos modernos?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('23bc5e05-6b96-4148-ae71-3e88b39c09f6','9e4d2d2b-2909-4222-8b4c-ed5916622e23',1,0,'1892',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5d9f810a-0264-4932-8242-6708b2582e5a','9e4d2d2b-2909-4222-8b4c-ed5916622e23',1,1,'1896',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3345ead4-9788-43e5-a8ff-7e9ee7c88449','9e4d2d2b-2909-4222-8b4c-ed5916622e23',1,2,'1900',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6d9783bd-a232-484f-b1ca-fc12cbc51bd3','9e4d2d2b-2909-4222-8b4c-ed5916622e23',1,3,'1904',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('5035201a-c299-4938-9b48-379c605bdbda',1,'en-que-ano-fue-inaugurado-el-canal-de-panama','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('b78e6370-e14c-4b65-a2ad-50eb452fdf7f','5035201a-c299-4938-9b48-379c605bdbda','es','¿En qué año fue inaugurado el Canal de Panamá?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('30fdc326-5aaf-4834-a690-414e2eb2fe37','5035201a-c299-4938-9b48-379c605bdbda',1,0,'1910',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('df868554-a8d7-4066-af38-c6bdfadcd369','5035201a-c299-4938-9b48-379c605bdbda',1,1,'1914',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6804ea63-2969-4d7b-9dfa-bda1748d3747','5035201a-c299-4938-9b48-379c605bdbda',1,2,'1920',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f20dae83-a33e-4732-81c5-1e7808209845','5035201a-c299-4938-9b48-379c605bdbda',1,3,'1924',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('d29578fc-67d9-4a62-acf2-3c4fd6b13d76',1,'cuantos-sets-gana-primero-en-un-partido-de-voleibol-masculino-maximo','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('0ecb271c-e2b9-4d11-8a44-ed8332fe73fb','d29578fc-67d9-4a62-acf2-3c4fd6b13d76','es','¿Cuántos sets gana primero en un partido de vóleibol masculino (máximo)?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('14aa8997-f39d-4612-a933-13ed49fa04bd','d29578fc-67d9-4a62-acf2-3c4fd6b13d76',1,0,'3',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c4ecf96e-d84e-42f7-9227-2f3fac033aa9','d29578fc-67d9-4a62-acf2-3c4fd6b13d76',1,1,'4',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4ccedb09-c06c-439f-a026-dc974e95b0ac','d29578fc-67d9-4a62-acf2-3c4fd6b13d76',1,2,'5',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ff8444c2-3223-4855-8a82-f5f4220d5a97','d29578fc-67d9-4a62-acf2-3c4fd6b13d76',1,3,'6',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('95e80d76-5e69-4cbd-913c-dd7aadedb67b',1,'en-que-pais-se-invento-el-rugby','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('c036240b-63c3-4d5f-b08d-95f1d765bc79','95e80d76-5e69-4cbd-913c-dd7aadedb67b','es','¿En qué país se inventó el rugby?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('fd547479-163d-41a0-8de7-1d505dca21a1','95e80d76-5e69-4cbd-913c-dd7aadedb67b',1,0,'Irlanda',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('dde4ce83-e89c-4616-a25c-ae543ae9dbea','95e80d76-5e69-4cbd-913c-dd7aadedb67b',1,1,'Australia',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1257af52-341b-4e4e-9b82-12c83e3ad805','95e80d76-5e69-4cbd-913c-dd7aadedb67b',1,2,'Inglaterra',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ce1c8d5b-b61a-4eb4-8d61-3007747d562c','95e80d76-5e69-4cbd-913c-dd7aadedb67b',1,3,'Nueva Zelanda',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('e242dd45-ecf2-4521-9ea3-6358af6ddde4',1,'cuantos-puntos-vale-la-conversion-despues-de-un-try-en-rugby','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('6e1384f1-f7cd-4230-a6ef-a38e059f09f6','e242dd45-ecf2-4521-9ea3-6358af6ddde4','es','¿Cuántos puntos vale la conversión después de un try en rugby?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f02f0a8b-b381-4edd-9cec-03042a6f8193','e242dd45-ecf2-4521-9ea3-6358af6ddde4',1,0,'1',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1138284f-c78d-4a15-be40-3f79952c1ee1','e242dd45-ecf2-4521-9ea3-6358af6ddde4',1,1,'2',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7b31d088-493b-41cf-854c-0428a1531890','e242dd45-ecf2-4521-9ea3-6358af6ddde4',1,2,'3',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('92f5ac86-e943-4440-b054-de3913d78c52','e242dd45-ecf2-4521-9ea3-6358af6ddde4',1,3,'4',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('788a2559-cb1d-4997-acce-0eaf9b16c961',1,'cuantos-jueces-puntuan-en-un-partido-de-boxeo-profesional','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('a7d4e1b5-2e5b-4b4e-bc39-0efdd8ae09e0','788a2559-cb1d-4997-acce-0eaf9b16c961','es','¿Cuántos jueces puntúan en un partido de boxeo profesional?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('468a26d3-5fee-441d-accd-040d6a65b7a1','788a2559-cb1d-4997-acce-0eaf9b16c961',1,0,'2',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('350cfd49-9763-4c5d-8051-8be49f69ab29','788a2559-cb1d-4997-acce-0eaf9b16c961',1,1,'3',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('017d74eb-b2c5-459d-b006-e8d2b299399f','788a2559-cb1d-4997-acce-0eaf9b16c961',1,2,'4',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('732e0c18-0e27-4960-bbb2-0c33ad5ef5e6','788a2559-cb1d-4997-acce-0eaf9b16c961',1,3,'5',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('ce9fc988-bfd8-45a1-b358-eea2306871a4',1,'en-que-pais-se-invento-el-judo','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('c36520bd-5a12-41c5-964d-d7c0bc99b369','ce9fc988-bfd8-45a1-b358-eea2306871a4','es','¿En qué país se inventó el judo?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d0a2c311-dd0a-436c-b4fb-21b7fa140838','ce9fc988-bfd8-45a1-b358-eea2306871a4',1,0,'China',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e2f8b436-4f34-42d8-8cf5-eefade128de3','ce9fc988-bfd8-45a1-b358-eea2306871a4',1,1,'Corea del Sur',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('65475c81-96be-4e66-b395-265f2c60bdd4','ce9fc988-bfd8-45a1-b358-eea2306871a4',1,2,'Japón',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('de1ba568-d1ae-432e-bf0c-ea6106cd2b6e','ce9fc988-bfd8-45a1-b358-eea2306871a4',1,3,'Mongolia',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('46f0ad68-f23e-47e6-9b9a-c55afcad084a',1,'cuantos-equipos-habia-en-la-champions-league-formato-hasta-202324','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('ab2dc61f-13fa-4aaf-82fd-cc076c692537','46f0ad68-f23e-47e6-9b9a-c55afcad084a','es','¿Cuántos equipos había en la Champions League (formato hasta 2023/24)?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('0df20bc3-6f67-45ff-9257-54489042f35b','46f0ad68-f23e-47e6-9b9a-c55afcad084a',1,0,'24',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f824f752-4869-4f3e-854a-aafb6f46367a','46f0ad68-f23e-47e6-9b9a-c55afcad084a',1,1,'28',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('228451d6-5c6e-4ef0-bc16-67cff4de9b19','46f0ad68-f23e-47e6-9b9a-c55afcad084a',1,2,'32',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('feb0b9c6-13ba-43e7-abc2-a1337c476161','46f0ad68-f23e-47e6-9b9a-c55afcad084a',1,3,'36',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('a72d71b0-03f9-414a-97ed-04e9910a548a',1,'que-significa-ram-en-informatica','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('7d618300-4d1c-419d-861e-6b9a883b3396','a72d71b0-03f9-414a-97ed-04e9910a548a','es','¿Qué significa ''RAM'' en informática?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e1f55959-55fb-4e66-8f24-a97f2eb6e71e','a72d71b0-03f9-414a-97ed-04e9910a548a',1,0,'Random Access Memory',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d0e2b989-77df-4a77-b4a3-4f5ada2b649a','a72d71b0-03f9-414a-97ed-04e9910a548a',1,1,'Read And More',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('364e7822-392e-4d78-b732-03b339899c0f','a72d71b0-03f9-414a-97ed-04e9910a548a',1,2,'Rapid Application Mode',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('966cb90e-c2ab-42f5-904e-a00a5a8c374d','a72d71b0-03f9-414a-97ed-04e9910a548a',1,3,'Remote Access Management',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('f64bf3b2-2c02-4d28-9920-d6438325a717',1,'en-que-ano-se-fundo-microsoft','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('fc30eba4-1ae0-48ef-8b94-18fab3141bc4','f64bf3b2-2c02-4d28-9920-d6438325a717','es','¿En qué año se fundó Microsoft?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e5a1a460-0a8f-4f31-a581-aff56d63e5af','f64bf3b2-2c02-4d28-9920-d6438325a717',1,0,'1973',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('bff816e5-81d4-4df5-95e7-5dc8d19efbb6','f64bf3b2-2c02-4d28-9920-d6438325a717',1,1,'1975',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('81fbae54-d466-4aac-b6d8-b75d5e3d9335','f64bf3b2-2c02-4d28-9920-d6438325a717',1,2,'1977',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ff67af76-788c-4bce-87ac-3cbdd2d7643c','f64bf3b2-2c02-4d28-9920-d6438325a717',1,3,'1979',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('4bec6ca1-c250-4d05-8cf6-1d9a48bfbee5',1,'quien-cofundo-microsoft-junto-a-bill-gates','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('e6f7e38d-f6d4-49d1-8fe0-22813b4405a4','4bec6ca1-c250-4d05-8cf6-1d9a48bfbee5','es','¿Quién cofundó Microsoft junto a Bill Gates?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f9e47cde-aa43-4f57-9ead-4f63fe6f550f','4bec6ca1-c250-4d05-8cf6-1d9a48bfbee5',1,0,'Steve Ballmer',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e5118638-c141-4fd3-a775-21e1e24085a0','4bec6ca1-c250-4d05-8cf6-1d9a48bfbee5',1,1,'Paul Allen',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('31fbb302-131b-4eb9-b9ae-f76e61f4291e','4bec6ca1-c250-4d05-8cf6-1d9a48bfbee5',1,2,'Satya Nadella',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('645ccfde-442a-4593-b589-9581e0897519','4bec6ca1-c250-4d05-8cf6-1d9a48bfbee5',1,3,'Gordon Moore',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('5fe70c12-53c0-4a66-810e-891a90eddcf4',1,'en-que-ano-se-envio-el-primer-correo-electronico','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('24ef45eb-59d6-4d22-a9cb-868e18ec17a7','5fe70c12-53c0-4a66-810e-891a90eddcf4','es','¿En qué año se envió el primer correo electrónico?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('bf2f0b7b-0353-4070-a4ef-f2a4b0cb4963','5fe70c12-53c0-4a66-810e-891a90eddcf4',1,0,'1969',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e768d47c-0447-4de9-9399-6ffd2655cf0f','5fe70c12-53c0-4a66-810e-891a90eddcf4',1,1,'1971',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1d46a63c-89bf-44b4-a008-5fcc31b1c52e','5fe70c12-53c0-4a66-810e-891a90eddcf4',1,2,'1973',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b5c11b1a-e3d8-4508-9f2c-a81f6e58de35','5fe70c12-53c0-4a66-810e-891a90eddcf4',1,3,'1975',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('fed86933-0002-4226-bbea-6e994d6ffc98',1,'que-significa-pdf','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('09224bd0-0ffb-4af2-9a97-ee8ee5c72b6b','fed86933-0002-4226-bbea-6e994d6ffc98','es','¿Qué significa ''PDF''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7c49040d-7191-4f2c-9adb-c44e3593b76b','fed86933-0002-4226-bbea-6e994d6ffc98',1,0,'Portable Document Format',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('833314ee-d369-4de5-90d8-07f0deb558fc','fed86933-0002-4226-bbea-6e994d6ffc98',1,1,'Print Document File',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('74ed46de-c3b2-4736-8804-c9d3fe9ec8cd','fed86933-0002-4226-bbea-6e994d6ffc98',1,2,'Personal Data Format',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('19e5ff17-01eb-4d71-a564-3d8e271a849d','fed86933-0002-4226-bbea-6e994d6ffc98',1,3,'Processing Digital File',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('97126408-b5ce-4338-8821-e2c575e83ae7',1,'cuantos-idiomas-soporta-google-translate-aproximadamente','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('19d7d165-462e-48f9-8fe0-cb6c923a2327','97126408-b5ce-4338-8821-e2c575e83ae7','es','¿Cuántos idiomas soporta Google Translate aproximadamente?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('812e97d2-2d1e-442b-a543-e567a2c9b307','97126408-b5ce-4338-8821-e2c575e83ae7',1,0,'50',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('585fc78d-36e0-46c7-a6e5-76b17372b3c0','97126408-b5ce-4338-8821-e2c575e83ae7',1,1,'75',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('bf35a114-7654-440b-a39c-99f6809e4248','97126408-b5ce-4338-8821-e2c575e83ae7',1,2,'100',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('619b0dca-dd80-4a1f-b906-2e263eda130c','97126408-b5ce-4338-8821-e2c575e83ae7',1,3,'Más de 130',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('47075ba8-79f9-4223-9480-422560f1122f',1,'en-que-ano-salio-windows-10','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('fb9d6ed7-28a0-4fbc-abdd-72a9a112c956','47075ba8-79f9-4223-9480-422560f1122f','es','¿En qué año salió Windows 10?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('74e250b5-16d4-4629-a8dd-9e785fa2f598','47075ba8-79f9-4223-9480-422560f1122f',1,0,'2013',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8f04be2b-56e5-4616-9185-13b2ec23e0e0','47075ba8-79f9-4223-9480-422560f1122f',1,1,'2014',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('15a84cbd-0f3d-425f-8c30-6bcfa86e7450','47075ba8-79f9-4223-9480-422560f1122f',1,2,'2015',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6b8b62ce-9d86-47bd-bfa9-a42c9fbd4d18','47075ba8-79f9-4223-9480-422560f1122f',1,3,'2016',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('f94e73d2-65f9-46c3-8334-6cec9e9b694d',1,'que-empresa-creo-el-sistema-operativo-ios','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('d841baa0-f526-4a4f-8460-83c4c2081988','f94e73d2-65f9-46c3-8334-6cec9e9b694d','es','¿Qué empresa creó el sistema operativo iOS?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3d757550-f943-44e8-8c31-712a44cca939','f94e73d2-65f9-46c3-8334-6cec9e9b694d',1,0,'Samsung',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9aef107e-c108-4024-a303-7640ae2e7b49','f94e73d2-65f9-46c3-8334-6cec9e9b694d',1,1,'Google',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b38f2b85-6187-46eb-91d7-055ed5268fb4','f94e73d2-65f9-46c3-8334-6cec9e9b694d',1,2,'Apple',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7f2a4c97-e1b5-4d84-9b7a-0efe59019d7c','f94e73d2-65f9-46c3-8334-6cec9e9b694d',1,3,'Microsoft',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('f8f6636f-06f6-4d79-bb08-22eeef373adc',1,'cuantos-usuarios-tiene-whatsapp-aproximadamente','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('eb0c8be3-7e1c-4a36-9b79-bfb0f4e6ca93','f8f6636f-06f6-4d79-bb08-22eeef373adc','es','¿Cuántos usuarios tiene WhatsApp aproximadamente?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('cab26a1f-123c-499a-9652-44668841bad3','f8f6636f-06f6-4d79-bb08-22eeef373adc',1,0,'500 millones',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('aee5616c-68ef-422f-846e-2ac00aeab5fa','f8f6636f-06f6-4d79-bb08-22eeef373adc',1,1,'1 mil millones',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('13b9582b-eb4a-4418-a8f2-be067ca91fcf','f8f6636f-06f6-4d79-bb08-22eeef373adc',1,2,'1.5 mil millones',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('68ca9325-bb77-416f-ba27-f40718ee1713','f8f6636f-06f6-4d79-bb08-22eeef373adc',1,3,'Más de 2 mil millones',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('b1f8765d-eff0-4192-97d3-9113f24e7102',1,'en-que-ano-lanzo-netflix-su-servicio-de-streaming-no-dvd','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('278b7104-297a-49a4-8e28-31507a14b36f','b1f8765d-eff0-4192-97d3-9113f24e7102','es','¿En qué año lanzó Netflix su servicio de streaming (no DVD)?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d9b1c87c-4453-4c8f-8b97-7cbe0248d714','b1f8765d-eff0-4192-97d3-9113f24e7102',1,0,'2005',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('64635ced-6137-466a-bdd0-603bf416ea76','b1f8765d-eff0-4192-97d3-9113f24e7102',1,1,'2006',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('917d39b7-34b6-4a31-b769-155e8c19749d','b1f8765d-eff0-4192-97d3-9113f24e7102',1,2,'2007',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('77ddcb4b-4311-4110-ae86-6512d71f93bf','b1f8765d-eff0-4192-97d3-9113f24e7102',1,3,'2008',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('c9b2224a-6041-477c-b36a-94e7fc8d78e3',1,'que-significa-vpn','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('51b29e9a-e5bf-4934-99b0-9bda7cffa715','c9b2224a-6041-477c-b36a-94e7fc8d78e3','es','¿Qué significa ''VPN''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('31bf87c0-ed4f-46d1-88dc-40e85043a1c4','c9b2224a-6041-477c-b36a-94e7fc8d78e3',1,0,'Virtual Private Network',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9710a7a9-ab1a-459a-a0d0-c48c37e1e6fd','c9b2224a-6041-477c-b36a-94e7fc8d78e3',1,1,'Verified Public Node',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a3f264fb-991d-4657-b707-e2dfec452b2d','c9b2224a-6041-477c-b36a-94e7fc8d78e3',1,2,'Very Personal Network',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b6627980-4dff-46c7-9ab1-45f6b758feb6','c9b2224a-6041-477c-b36a-94e7fc8d78e3',1,3,'Video Processing Navigation',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('a31d08a0-670d-47f3-b61e-ef580fd29535',1,'en-que-ano-se-fundo-twitter','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('6ac62645-acc7-4da2-8d72-6d77040834ae','a31d08a0-670d-47f3-b61e-ef580fd29535','es','¿En qué año se fundó Twitter?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5112c32e-cb40-4cc7-8278-97704b98a788','a31d08a0-670d-47f3-b61e-ef580fd29535',1,0,'2004',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('77f1717a-8ab6-46a3-ac34-3ae9f23e8507','a31d08a0-670d-47f3-b61e-ef580fd29535',1,1,'2005',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d554ebed-ac28-496d-a740-abd866cb464c','a31d08a0-670d-47f3-b61e-ef580fd29535',1,2,'2006',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a796a0db-aac0-4513-889f-368c5d5e68ba','a31d08a0-670d-47f3-b61e-ef580fd29535',1,3,'2007',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('888d83bf-12cf-4ce4-996b-2f94a9e5ed72',1,'que-significa-cpu','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('fbbe5378-719f-43dd-aef6-3e228dee7adc','888d83bf-12cf-4ce4-996b-2f94a9e5ed72','es','¿Qué significa ''CPU''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('457d5500-de60-4214-aade-2fe82fd1b20b','888d83bf-12cf-4ce4-996b-2f94a9e5ed72',1,0,'Central Processing Unit',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1bb7aa97-f4c2-48f4-bc80-d9fa5cbf3324','888d83bf-12cf-4ce4-996b-2f94a9e5ed72',1,1,'Computer Power Usage',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('116efa25-e529-469c-a029-c2db7bdfb7d2','888d83bf-12cf-4ce4-996b-2f94a9e5ed72',1,2,'Central Program Unit',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('bca0a484-7267-4aad-8eab-8e38e559ab14','888d83bf-12cf-4ce4-996b-2f94a9e5ed72',1,3,'Computing Process Utility',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('8c501d83-2464-4e04-a85a-b594850c64bf',1,'en-que-ano-se-lanzo-el-primer-telefono-con-android-htc-dream','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('059ed820-01f9-4a06-a512-9ef7e03c4d44','8c501d83-2464-4e04-a85a-b594850c64bf','es','¿En qué año se lanzó el primer teléfono con Android (HTC Dream)?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7c0b36ac-82d9-4d36-ab9d-fab9f5b4ee3c','8c501d83-2464-4e04-a85a-b594850c64bf',1,0,'2006',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9518c119-669d-40fb-aac6-cccee6a9820d','8c501d83-2464-4e04-a85a-b594850c64bf',1,1,'2007',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4a885e1c-881e-43aa-aca5-e431f33ac28d','8c501d83-2464-4e04-a85a-b594850c64bf',1,2,'2008',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('79ebdf25-9e07-44be-9741-b3dc6950ff72','8c501d83-2464-4e04-a85a-b594850c64bf',1,3,'2009',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('72675bb9-191b-40a3-a70e-297f9d966ca1',1,'cuantos-presidentes-tuvo-argentina-en-diciembre-de-2001','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('9527f402-89a9-4ad3-8b1c-f943e96e26c5','72675bb9-191b-40a3-a70e-297f9d966ca1','es','¿Cuántos presidentes tuvo Argentina en diciembre de 2001?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e155801c-fbbc-47dc-8f4c-a96e0ecad4f1','72675bb9-191b-40a3-a70e-297f9d966ca1',1,0,'2',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('07268e6a-7571-44c4-99b2-b2cce65cefe7','72675bb9-191b-40a3-a70e-297f9d966ca1',1,1,'3',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('82084e31-2b23-4ae5-aabc-44d80db7a231','72675bb9-191b-40a3-a70e-297f9d966ca1',1,2,'4',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('af2ec544-1868-473e-925c-53b4fa18db44','72675bb9-191b-40a3-a70e-297f9d966ca1',1,3,'5',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('213250cd-8dfc-49f1-99cc-745145230e7e',1,'en-que-ano-ocurrio-la-guerra-de-malvinas','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('28fcc6b8-6276-42ec-b755-d358b340a7fa','213250cd-8dfc-49f1-99cc-745145230e7e','es','¿En qué año ocurrió la Guerra de Malvinas?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7208b7f3-0c1d-44e8-aff9-4e00fddb02c2','213250cd-8dfc-49f1-99cc-745145230e7e',1,0,'1978',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('12bcb770-32e7-4932-b757-036d085aec99','213250cd-8dfc-49f1-99cc-745145230e7e',1,1,'1980',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b9952fbd-dc92-4b34-b343-4aa7669e7929','213250cd-8dfc-49f1-99cc-745145230e7e',1,2,'1982',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('487b8778-e1e7-40e9-aba5-3446b47ef67a','213250cd-8dfc-49f1-99cc-745145230e7e',1,3,'1984',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('fb0ce062-9c55-4425-a523-8f9635caf2bc',1,'cuantas-provincias-tiene-argentina','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('c38d2997-40c0-4fea-a81b-1848baf42537','fb0ce062-9c55-4425-a523-8f9635caf2bc','es','¿Cuántas provincias tiene Argentina?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('fc83595e-be92-4ee5-842e-f3d554b97479','fb0ce062-9c55-4425-a523-8f9635caf2bc',1,0,'22',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8547bd7d-42c3-4103-a24d-ac994fc97424','fb0ce062-9c55-4425-a523-8f9635caf2bc',1,1,'23',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e8e6d127-035a-47f9-996e-c6b274980af7','fb0ce062-9c55-4425-a523-8f9635caf2bc',1,2,'24',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('bc09f8e3-07ad-44d5-ab24-e4c7a2486b00','fb0ce062-9c55-4425-a523-8f9635caf2bc',1,3,'25',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('0edb0925-f6d6-48b4-a412-ef1fbd36f922',1,'cual-es-el-rio-mas-largo-de-argentina','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('56bdce12-7ddf-48a7-8a39-82c8f9af4e1c','0edb0925-f6d6-48b4-a412-ef1fbd36f922','es','¿Cuál es el río más largo de Argentina?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('58321c15-f7b8-4019-a9c2-c31d6b4230c9','0edb0925-f6d6-48b4-a412-ef1fbd36f922',1,0,'Río Uruguay',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('614ffa75-a425-4422-a05b-f8da8c9fad82','0edb0925-f6d6-48b4-a412-ef1fbd36f922',1,1,'Río de la Plata',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9aeeccc3-803c-4975-8c4e-2704d53149df','0edb0925-f6d6-48b4-a412-ef1fbd36f922',1,2,'Río Paraná',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('20aae1e5-1ba2-467a-896f-7871ab5700dd','0edb0925-f6d6-48b4-a412-ef1fbd36f922',1,3,'Río Negro',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('a1cfbc7b-32d3-4efc-83c9-fcdab40c99fb',1,'cuanto-mide-el-cerro-aconcagua','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('ae8882ec-ba49-44fb-b07c-34b68b2aa86c','a1cfbc7b-32d3-4efc-83c9-fcdab40c99fb','es','¿Cuánto mide el Cerro Aconcagua?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d19f118a-79d6-4f84-a62c-c5c5b4ff1557','a1cfbc7b-32d3-4efc-83c9-fcdab40c99fb',1,0,'5.961 m',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b2babcf4-c81d-4a20-a053-2f58ae6fe591','a1cfbc7b-32d3-4efc-83c9-fcdab40c99fb',1,1,'6.461 m',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b5a829f8-e67a-46c9-8369-4cdba4989fc5','a1cfbc7b-32d3-4efc-83c9-fcdab40c99fb',1,2,'6.961 m',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a1734b12-678a-4278-b253-55a9a2dd3844','a1cfbc7b-32d3-4efc-83c9-fcdab40c99fb',1,3,'7.461 m',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('682b8e26-b3f1-403e-a1fb-a42c7047c570',1,'cual-es-el-deporte-nacional-oficial-de-argentina','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('dbcff65d-45b1-4dee-819e-ccf1281574c3','682b8e26-b3f1-403e-a1fb-a42c7047c570','es','¿Cuál es el deporte nacional oficial de Argentina?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6e1a4809-2cf1-40ed-aec8-1a9c23c50030','682b8e26-b3f1-403e-a1fb-a42c7047c570',1,0,'Fútbol',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e44b52f3-930b-4ffa-935b-73a51a842649','682b8e26-b3f1-403e-a1fb-a42c7047c570',1,1,'Hockey',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('10aa549e-f6b7-4d0d-8d3e-b3795eedee6e','682b8e26-b3f1-403e-a1fb-a42c7047c570',1,2,'Pato',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3b2a0878-1a9b-4ca3-b00e-88e667e6d211','682b8e26-b3f1-403e-a1fb-a42c7047c570',1,3,'Rugby',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('5a04dbbc-1867-453b-89f7-605bfc0da3ff',1,'cuantos-titulos-de-copa-libertadores-gano-boca-juniors','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('e65bb1d9-e734-4903-b6a5-c020e51b8bc6','5a04dbbc-1867-453b-89f7-605bfc0da3ff','es','¿Cuántos títulos de Copa Libertadores ganó Boca Juniors?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1f2324bc-3cf8-428d-a968-35465b686d19','5a04dbbc-1867-453b-89f7-605bfc0da3ff',1,0,'4',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c32414ac-2079-4e81-8ad0-dd47436b7031','5a04dbbc-1867-453b-89f7-605bfc0da3ff',1,1,'5',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('663ac3a7-da12-4610-a852-0e0121c05f2e','5a04dbbc-1867-453b-89f7-605bfc0da3ff',1,2,'6',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ee50cb89-6e81-46f6-a525-fa277119a2f7','5a04dbbc-1867-453b-89f7-605bfc0da3ff',1,3,'7',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('315a0e56-8834-4d09-84f0-e7ad930054e4',1,'en-que-ciudad-nacio-el-papa-francisco','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('626befa8-2d43-44d8-92a9-4512bb4e41c5','315a0e56-8834-4d09-84f0-e7ad930054e4','es','¿En qué ciudad nació el Papa Francisco?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d40db03e-b8a0-4824-8f72-33a103d4d4a9','315a0e56-8834-4d09-84f0-e7ad930054e4',1,0,'Córdoba',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('bb082b80-1ff1-4d29-9030-fc65b051922c','315a0e56-8834-4d09-84f0-e7ad930054e4',1,1,'Rosario',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('88bf5b9a-bf67-472b-88e5-3b5ba48bf404','315a0e56-8834-4d09-84f0-e7ad930054e4',1,2,'Buenos Aires',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5759b2a3-26b5-4f95-b0f1-26adec98e62a','315a0e56-8834-4d09-84f0-e7ad930054e4',1,3,'La Plata',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('25517815-2fd6-4093-b8d8-e2a3952fb924',1,'en-que-ano-fue-fundada-la-ciudad-de-buenos-aires-segunda-fundacion-definiti','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('77f3b28c-f0bf-4441-801e-7bc4f39d0dc0','25517815-2fd6-4093-b8d8-e2a3952fb924','es','¿En qué año fue fundada la ciudad de Buenos Aires (segunda fundación definitiva)?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b492e9bb-40d5-4ef9-a2bf-893777d68d48','25517815-2fd6-4093-b8d8-e2a3952fb924',1,0,'1536',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3e18a8b8-8f7e-46d7-97b9-b0156d58bf3c','25517815-2fd6-4093-b8d8-e2a3952fb924',1,1,'1580',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f118c83b-4d34-4160-befe-4e40c1eab035','25517815-2fd6-4093-b8d8-e2a3952fb924',1,2,'1600',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('35b38478-0563-48e5-a699-bd51afe4d6d7','25517815-2fd6-4093-b8d8-e2a3952fb924',1,3,'1620',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('a49bfd81-ac99-491b-93cd-e1e3ee79c12d',1,'cual-es-la-segunda-ciudad-mas-poblada-de-argentina','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('26a3df57-b88e-4ca0-8ae5-34c374206c69','a49bfd81-ac99-491b-93cd-e1e3ee79c12d','es','¿Cuál es la segunda ciudad más poblada de Argentina?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1704a316-24db-45c6-a9c7-1c2d5b0c4319','a49bfd81-ac99-491b-93cd-e1e3ee79c12d',1,0,'Rosario',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('98879a31-530d-4944-83bb-b3db29cabebf','a49bfd81-ac99-491b-93cd-e1e3ee79c12d',1,1,'Córdoba',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('10ff550d-9e53-46df-9490-8b4fbabcb7a0','a49bfd81-ac99-491b-93cd-e1e3ee79c12d',1,2,'Mendoza',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8a95f929-d6ad-4b65-ac78-b4419448713d','a49bfd81-ac99-491b-93cd-e1e3ee79c12d',1,3,'La Plata',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('1d4ae28e-d6f9-4792-9c61-9c2a492bd920',1,'en-que-paises-esta-el-lago-titicaca','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('5c367247-6168-4d70-9882-16f1874b5621','1d4ae28e-d6f9-4792-9c61-9c2a492bd920','es','¿En qué países está el lago Titicaca?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1d9a8fa2-cbc2-45d1-913a-29f96560aafb','1d4ae28e-d6f9-4792-9c61-9c2a492bd920',1,0,'Argentina y Chile',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4c8f9f19-0fb2-4f67-bb9e-2f38d373881e','1d4ae28e-d6f9-4792-9c61-9c2a492bd920',1,1,'Bolivia y Perú',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b42aee96-8d60-497e-9cbe-afcb0c23ad7a','1d4ae28e-d6f9-4792-9c61-9c2a492bd920',1,2,'Colombia y Venezuela',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f57a2021-54d3-4431-88f2-867e56b67adc','1d4ae28e-d6f9-4792-9c61-9c2a492bd920',1,3,'Ecuador y Perú',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('7c355ca7-cc4b-4fdb-8c42-75ac41158896',1,'cuantos-idiomas-oficiales-tiene-bolivia','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('bc1e4bbb-c087-4811-a351-c433cc1bcae9','7c355ca7-cc4b-4fdb-8c42-75ac41158896','es','¿Cuántos idiomas oficiales tiene Bolivia?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b45b47c6-90c1-482b-8e93-679abaa638d0','7c355ca7-cc4b-4fdb-8c42-75ac41158896',1,0,'3',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('49c0770e-e360-4644-be7c-7703cdcd4de7','7c355ca7-cc4b-4fdb-8c42-75ac41158896',1,1,'12',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e3817c11-c18d-4c02-8586-2b4ded5cded6','7c355ca7-cc4b-4fdb-8c42-75ac41158896',1,2,'25',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('619754ec-6746-4301-8dc1-d9abf62685de','7c355ca7-cc4b-4fdb-8c42-75ac41158896',1,3,'37',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('4f64d2c9-7f5d-40bb-8250-b9b3759de981',1,'cual-es-la-moneda-de-brasil','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('dcd502c6-92a4-4d54-94b3-afb1f9f6df79','4f64d2c9-7f5d-40bb-8250-b9b3759de981','es','¿Cuál es la moneda de Brasil?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('226085d1-42c7-4e49-8aa0-feec79c2bc2e','4f64d2c9-7f5d-40bb-8250-b9b3759de981',1,0,'Peso',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('32367f5a-de1c-48d9-93a0-2fe0e77cf026','4f64d2c9-7f5d-40bb-8250-b9b3759de981',1,1,'Real',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4dd9a158-f84f-495a-ad1a-fa78be0281e7','4f64d2c9-7f5d-40bb-8250-b9b3759de981',1,2,'Bolívar',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('2e7538e3-e0a5-431c-beed-10ecdfccfeca','4f64d2c9-7f5d-40bb-8250-b9b3759de981',1,3,'Sol',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('249d1f7c-1af4-48e3-9102-eb42a905b016',1,'cual-es-el-pais-mas-grande-de-america-latina','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('a3fe1e7f-7b38-43af-89b5-78ee17174bf3','249d1f7c-1af4-48e3-9102-eb42a905b016','es','¿Cuál es el país más grande de América Latina?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('78f044bf-fe53-4bd5-9df8-d69ab1b2a511','249d1f7c-1af4-48e3-9102-eb42a905b016',1,0,'Argentina',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e20862e4-ec97-4842-820c-5d9fde79cc26','249d1f7c-1af4-48e3-9102-eb42a905b016',1,1,'México',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('bfb1b381-d326-42fc-a5e9-f3f0ec06c581','249d1f7c-1af4-48e3-9102-eb42a905b016',1,2,'Brasil',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ade6fe15-6757-45f8-8707-5853ab1bf2c6','249d1f7c-1af4-48e3-9102-eb42a905b016',1,3,'Colombia',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('b395374e-b601-42e9-901f-cbcf5ea0ce58',1,'en-cuantos-paises-latinoamericanos-el-espanol-es-idioma-oficial','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('17619174-49f7-4dfb-ac3e-5cc58d07ed43','b395374e-b601-42e9-901f-cbcf5ea0ce58','es','¿En cuántos países latinoamericanos el español es idioma oficial?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('dd87d4aa-fffa-404c-afc7-94462269aad8','b395374e-b601-42e9-901f-cbcf5ea0ce58',1,0,'15',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a5c73c6b-25d3-4f5c-9c6b-47ce8edb2ea9','b395374e-b601-42e9-901f-cbcf5ea0ce58',1,1,'18',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1695fbef-d484-4234-b8b8-492fa2fb94ad','b395374e-b601-42e9-901f-cbcf5ea0ce58',1,2,'20',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3dda8bb3-dbd9-49a3-82aa-eb55acb7491c','b395374e-b601-42e9-901f-cbcf5ea0ce58',1,3,'22',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('6c1879c4-efc2-410c-a689-03a3cef40561',1,'en-que-ano-cayo-el-imperio-romano-de-occidente','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('f437ead4-0a56-4ed0-9041-a8a51fe3525f','6c1879c4-efc2-410c-a689-03a3cef40561','es','¿En qué año cayó el Imperio Romano de Occidente?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f7a30ba0-6a7b-4281-ad78-66810cd514e5','6c1879c4-efc2-410c-a689-03a3cef40561',1,0,'410',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a7626d2a-6a33-4eab-9a54-853d6ff27418','6c1879c4-efc2-410c-a689-03a3cef40561',1,1,'476',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('373d9c3e-d757-408a-b8bc-da581d40760e','6c1879c4-efc2-410c-a689-03a3cef40561',1,2,'500',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('0cf71a4c-d9b7-4d56-b0cd-7fab42b28b04','6c1879c4-efc2-410c-a689-03a3cef40561',1,3,'527',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('16d3b8e3-1ab5-491d-bd77-79635f58039d',1,'cual-es-el-pais-mas-pequeno-del-mundo','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('6cd6f179-494e-4771-ac45-6ad7cbc8fdc1','16d3b8e3-1ab5-491d-bd77-79635f58039d','es','¿Cuál es el país más pequeño del mundo?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b2717b2c-c1dd-4ed0-89d6-8670898069ef','16d3b8e3-1ab5-491d-bd77-79635f58039d',1,0,'Monaco',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('03ed2eb0-3f54-40f8-83ce-8eb1c79969e5','16d3b8e3-1ab5-491d-bd77-79635f58039d',1,1,'Liechtenstein',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('abcd6805-f8de-44fe-b12c-cedb5a0eb889','16d3b8e3-1ab5-491d-bd77-79635f58039d',1,2,'San Marino',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ee38f9bc-11c1-489d-97a6-e000b25e535b','16d3b8e3-1ab5-491d-bd77-79635f58039d',1,3,'Ciudad del Vaticano',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('fcc05d99-95f1-4a1e-abf5-f3e179f46e12',1,'cuantos-paises-tiene-el-continente-asiatico','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('d8c43b63-c1e8-4ba0-ad2a-84a30c1edfc0','fcc05d99-95f1-4a1e-abf5-f3e179f46e12','es','¿Cuántos países tiene el continente asiático?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e049c8e6-16ef-442c-b7f1-a019baa4d072','fcc05d99-95f1-4a1e-abf5-f3e179f46e12',1,0,'40',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3071bded-a7fc-400c-97cc-8163f2d6c1d2','fcc05d99-95f1-4a1e-abf5-f3e179f46e12',1,1,'44',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4c1180d3-e4dd-49ab-a6ac-d0f1f9b89665','fcc05d99-95f1-4a1e-abf5-f3e179f46e12',1,2,'48',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3d43cde6-6566-4f2f-b9b9-6757c024ab9e','fcc05d99-95f1-4a1e-abf5-f3e179f46e12',1,3,'54',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('518cd564-429c-44e0-ab7c-35b935b68d94',1,'en-que-ano-fue-completado-el-coliseo-romano','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('2eeded25-b348-4dcc-9aa6-5a9c3e1961ab','518cd564-429c-44e0-ab7c-35b935b68d94','es','¿En qué año fue completado el Coliseo Romano?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('13ff0da3-c893-4f42-8628-11d69353a221','518cd564-429c-44e0-ab7c-35b935b68d94',1,0,'50 d.C.',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7e027c5f-5797-492b-b0ee-0fc27cd73ad0','518cd564-429c-44e0-ab7c-35b935b68d94',1,1,'70 d.C.',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9b44f8d7-d7ce-4e26-950e-caa5f621e135','518cd564-429c-44e0-ab7c-35b935b68d94',1,2,'80 d.C.',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('084a56b5-1fb3-4229-a4a7-79bd31246b43','518cd564-429c-44e0-ab7c-35b935b68d94',1,3,'100 d.C.',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('4a70fbd0-981a-4aa3-a645-92ee4b6e8994',1,'cuantos-anos-duro-la-segunda-guerra-mundial','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('67bc351f-89fa-465d-b6e5-26c33563716b','4a70fbd0-981a-4aa3-a645-92ee4b6e8994','es','¿Cuántos años duró la Segunda Guerra Mundial?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9a04289f-77ba-400b-9ca8-7a9059bda2af','4a70fbd0-981a-4aa3-a645-92ee4b6e8994',1,0,'4',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('395c033c-cd73-493a-9192-3dbf7d154616','4a70fbd0-981a-4aa3-a645-92ee4b6e8994',1,1,'5',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('28a2509e-3d06-402a-941e-28dda34955eb','4a70fbd0-981a-4aa3-a645-92ee4b6e8994',1,2,'6',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e1f7bb20-2670-4fc6-82c0-c7630304b50f','4a70fbd0-981a-4aa3-a645-92ee4b6e8994',1,3,'7',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('4025071f-ddbb-4038-96f1-bfc2882ed22f',1,'cual-es-el-lago-mas-profundo-del-mundo','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('5b6ba388-2ba0-48b5-a7eb-2993545cabc0','4025071f-ddbb-4038-96f1-bfc2882ed22f','es','¿Cuál es el lago más profundo del mundo?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8d746566-97f3-413d-8c36-fc890ecb5815','4025071f-ddbb-4038-96f1-bfc2882ed22f',1,0,'Lago Titicaca',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('69be6481-0f45-42d4-a166-8e31f5fcc23f','4025071f-ddbb-4038-96f1-bfc2882ed22f',1,1,'Lago Superior',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9a9551bd-fe9f-41ca-8bbd-c63dccea736f','4025071f-ddbb-4038-96f1-bfc2882ed22f',1,2,'Lago Baikal',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('77c27327-9f23-4009-9839-410b066c77f1','4025071f-ddbb-4038-96f1-bfc2882ed22f',1,3,'Mar Caspio',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('b25bdcae-7d2e-4f64-bdb0-f9901de39f03',1,'en-que-ano-llego-cristobal-colon-a-america','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('0c0a91ce-65a4-425a-81d4-e22e57b5a289','b25bdcae-7d2e-4f64-bdb0-f9901de39f03','es','¿En qué año llegó Cristóbal Colón a América?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('99b4a704-7607-4f45-95f9-76440e38933d','b25bdcae-7d2e-4f64-bdb0-f9901de39f03',1,0,'1490',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e3046cd4-9fcb-453d-9205-ba2d481720e7','b25bdcae-7d2e-4f64-bdb0-f9901de39f03',1,1,'1491',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4004d57e-3b80-49b5-bacb-7052abb62ead','b25bdcae-7d2e-4f64-bdb0-f9901de39f03',1,2,'1492',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5020d181-12e6-4ac9-88f3-e3d93b903e98','b25bdcae-7d2e-4f64-bdb0-f9901de39f03',1,3,'1493',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('85026ee9-fedb-467f-b425-d35d8218fbff',1,'en-que-ano-empezo-la-primera-guerra-mundial','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('f1bcad56-b6a4-4a84-932b-a9bae7bc31be','85026ee9-fedb-467f-b425-d35d8218fbff','es','¿En qué año empezó la Primera Guerra Mundial?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('59006695-7eb0-47be-bf36-97d1e0a496e8','85026ee9-fedb-467f-b425-d35d8218fbff',1,0,'1912',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('34c46904-cd9a-49eb-8da2-c5efa8a56907','85026ee9-fedb-467f-b425-d35d8218fbff',1,1,'1913',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('48fa1a9d-8cfc-4e2e-8b74-c2767847a2d6','85026ee9-fedb-467f-b425-d35d8218fbff',1,2,'1914',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ea2a5529-d3e0-4cbc-8656-a928d14a2227','85026ee9-fedb-467f-b425-d35d8218fbff',1,3,'1915',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('a84ffe2a-7280-4d2d-9776-aa1cbdeb3b58',1,'en-que-ano-termino-la-segunda-guerra-mundial','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('2beaf1e6-952a-47bd-96a0-c3451906832b','a84ffe2a-7280-4d2d-9776-aa1cbdeb3b58','es','¿En qué año terminó la Segunda Guerra Mundial?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3a27796e-1131-41b0-b82e-bcf0e33a6a0c','a84ffe2a-7280-4d2d-9776-aa1cbdeb3b58',1,0,'1944',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d796c1fe-13da-48fd-9e13-1aed6565c245','a84ffe2a-7280-4d2d-9776-aa1cbdeb3b58',1,1,'1945',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c480f045-d7a2-48a9-beff-56ae2e2afb16','a84ffe2a-7280-4d2d-9776-aa1cbdeb3b58',1,2,'1946',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b23f4d96-1bcf-4594-a7f2-1a92aca5d7a3','a84ffe2a-7280-4d2d-9776-aa1cbdeb3b58',1,3,'1947',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('fd660b4e-dacc-4a22-b02b-bf0d2f95a1a0',1,'cual-es-el-desierto-mas-caliente-y-grande-del-mundo','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('4e6ff435-8c3e-4218-b819-cd40e84117db','fd660b4e-dacc-4a22-b02b-bf0d2f95a1a0','es','¿Cuál es el desierto más caliente y grande del mundo?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9ed4928f-5908-4ab0-97be-31a25e200fc4','fd660b4e-dacc-4a22-b02b-bf0d2f95a1a0',1,0,'Sahara',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1a2ab5c3-db8d-4773-85d5-c1ee49d7c706','fd660b4e-dacc-4a22-b02b-bf0d2f95a1a0',1,1,'Gobi',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('252af0c4-f790-41bf-bb96-506d7048fbfd','fd660b4e-dacc-4a22-b02b-bf0d2f95a1a0',1,2,'Atacama',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5f447ae9-535b-4979-ac0a-4e69a1956e0e','fd660b4e-dacc-4a22-b02b-bf0d2f95a1a0',1,3,'Arábigo',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('25fbe9a4-1559-453c-832a-03ba4b6be471',1,'en-que-ano-fue-construida-la-torre-eiffel','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('07b836e4-e988-4ac3-b75f-3b751161b0c4','25fbe9a4-1559-453c-832a-03ba4b6be471','es','¿En qué año fue construida la Torre Eiffel?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('40de959b-b904-48f2-9db2-e7054b3fcada','25fbe9a4-1559-453c-832a-03ba4b6be471',1,0,'1885',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b0031c76-6769-4e14-be92-7b6cd209c677','25fbe9a4-1559-453c-832a-03ba4b6be471',1,1,'1887',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b8521843-ddd0-4802-a59c-ada6da290359','25fbe9a4-1559-453c-832a-03ba4b6be471',1,2,'1889',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ca8d7ba2-496f-489a-bf86-662569e7b787','25fbe9a4-1559-453c-832a-03ba4b6be471',1,3,'1891',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('33512024-b34d-4384-a3da-6caf780421fb',1,'cuantos-metros-de-altura-tiene-la-torre-eiffel-con-antena','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('d5280fd5-a45c-45b0-8986-8498ccb84f96','33512024-b34d-4384-a3da-6caf780421fb','es','¿Cuántos metros de altura tiene la Torre Eiffel (con antena)?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ce62d1a9-6d45-486c-b42e-8f5bcdef23fe','33512024-b34d-4384-a3da-6caf780421fb',1,0,'250 m',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('43773912-a080-4ec9-b087-87fcac712875','33512024-b34d-4384-a3da-6caf780421fb',1,1,'300 m',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1156f072-7436-446a-832b-5f6c89535cc1','33512024-b34d-4384-a3da-6caf780421fb',1,2,'330 m',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6247067d-54b5-4a13-a836-34c3f075cea2','33512024-b34d-4384-a3da-6caf780421fb',1,3,'400 m',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('591b536a-0bbf-4f89-9cad-283d08de6cd9',1,'cuantos-paises-tiene-oceania','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('69fec895-5efb-46c2-a648-c74744ab161b','591b536a-0bbf-4f89-9cad-283d08de6cd9','es','¿Cuántos países tiene Oceanía?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('fa1eec4e-fad8-4a37-866a-2aa03e183192','591b536a-0bbf-4f89-9cad-283d08de6cd9',1,0,'8',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('62b1a738-2ed4-4e9c-89e3-d645a09c15da','591b536a-0bbf-4f89-9cad-283d08de6cd9',1,1,'10',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('66b1da92-2034-4f38-a825-cff81c5c9599','591b536a-0bbf-4f89-9cad-283d08de6cd9',1,2,'14',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('fed87733-670b-4837-b8dd-c33565c0da7d','591b536a-0bbf-4f89-9cad-283d08de6cd9',1,3,'20',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('7efc84a0-d930-4ea5-bdd6-6522c6c6fcbc',1,'en-que-ano-fue-la-revolucion-francesa','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('29c3016c-764e-4e2a-8ef8-3d721c46bf36','7efc84a0-d930-4ea5-bdd6-6522c6c6fcbc','es','¿En qué año fue la Revolución Francesa?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('251e69de-2812-473d-99bf-53cd0b7e674f','7efc84a0-d930-4ea5-bdd6-6522c6c6fcbc',1,0,'1785',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('921380e7-85f6-45ef-a0cf-a8ae3d7ca8d4','7efc84a0-d930-4ea5-bdd6-6522c6c6fcbc',1,1,'1787',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('decffa04-8565-4cc8-a570-8a5ff7dd85b3','7efc84a0-d930-4ea5-bdd6-6522c6c6fcbc',1,2,'1789',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('614fea55-feba-477c-aad3-2f0d7125263f','7efc84a0-d930-4ea5-bdd6-6522c6c6fcbc',1,3,'1791',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('352cb83a-f9c1-4458-8a5c-b463f215f96d',1,'cual-es-la-capital-de-canada','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('52d6d918-e7b9-4192-b7f7-b6742854f50f','352cb83a-f9c1-4458-8a5c-b463f215f96d','es','¿Cuál es la capital de Canadá?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ad09620f-9eb8-41c8-b35f-5bf65d97239a','352cb83a-f9c1-4458-8a5c-b463f215f96d',1,0,'Toronto',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('537e981a-ea0f-4623-968d-346c7126d604','352cb83a-f9c1-4458-8a5c-b463f215f96d',1,1,'Vancouver',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('077466f9-e8e5-4437-955d-3f2e5b635243','352cb83a-f9c1-4458-8a5c-b463f215f96d',1,2,'Montreal',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ad38fa21-156d-440d-876e-749679f7c5f2','352cb83a-f9c1-4458-8a5c-b463f215f96d',1,3,'Ottawa',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('adca7ee1-32d7-458f-bc5f-ea7b1bdfba58',1,'en-que-ano-fue-asesinado-abraham-lincoln','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('730298f4-9302-432b-83fd-3a754ae6ca1a','adca7ee1-32d7-458f-bc5f-ea7b1bdfba58','es','¿En qué año fue asesinado Abraham Lincoln?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('887fcbc8-258e-425c-83f1-29d2742eb231','adca7ee1-32d7-458f-bc5f-ea7b1bdfba58',1,0,'1863',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('38f8131e-1b45-40f4-b74d-1de0ae67ec94','adca7ee1-32d7-458f-bc5f-ea7b1bdfba58',1,1,'1864',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('0e7b4659-7fa2-4d1b-9ca7-6e12a6d67521','adca7ee1-32d7-458f-bc5f-ea7b1bdfba58',1,2,'1865',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4e4bb786-c4dc-4d30-89ce-ab288a9af829','adca7ee1-32d7-458f-bc5f-ea7b1bdfba58',1,3,'1866',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('15be87c3-5dd3-4f93-99f2-aa2a4f77d496',1,'cuantos-paises-tiene-europa-aproximadamente','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('24e63a1d-4a54-400f-b720-686ab1b3a202','15be87c3-5dd3-4f93-99f2-aa2a4f77d496','es','¿Cuántos países tiene Europa aproximadamente?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a9295fd0-68b0-4658-99a9-2b3a82996901','15be87c3-5dd3-4f93-99f2-aa2a4f77d496',1,0,'35',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1264f252-f86b-49a7-be84-8eae7e30d27a','15be87c3-5dd3-4f93-99f2-aa2a4f77d496',1,1,'40',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1d3bfc44-402c-45d3-8c55-1abb4f867e2c','15be87c3-5dd3-4f93-99f2-aa2a4f77d496',1,2,'44',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e0796300-6799-4274-a74b-6c66a71e917e','15be87c3-5dd3-4f93-99f2-aa2a4f77d496',1,3,'50',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('ca121e00-30d5-4be1-8eac-04547a1d4d68',1,'en-que-ano-empezo-la-revolucion-rusa','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('2f744dac-9c42-42e4-95d6-86d9fb1ac842','ca121e00-30d5-4be1-8eac-04547a1d4d68','es','¿En qué año empezó la Revolución Rusa?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('fc3c175a-3fe1-4041-96ed-82667e4ea874','ca121e00-30d5-4be1-8eac-04547a1d4d68',1,0,'1914',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8fe4b47e-fbcc-4b61-b0c5-61652076023a','ca121e00-30d5-4be1-8eac-04547a1d4d68',1,1,'1915',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ec1b2f94-db5d-4cdb-b093-c9f8b344c0dc','ca121e00-30d5-4be1-8eac-04547a1d4d68',1,2,'1917',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('2dfce1ce-ad82-44c1-9437-3047e98fe486','ca121e00-30d5-4be1-8eac-04547a1d4d68',1,3,'1919',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('16af1213-5660-4491-a083-813e8ec9b818',1,'cuantos-anos-goberno-napoleon-bonaparte-francia-aproximadamente','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('b77139f4-70ff-4384-b3d5-5d16e0f39786','16af1213-5660-4491-a083-813e8ec9b818','es','¿Cuántos años gobernó Napoleón Bonaparte Francia aproximadamente?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6cea2cf3-b2ff-4642-8be5-8602043d040a','16af1213-5660-4491-a083-813e8ec9b818',1,0,'5',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5d6344c5-500c-42fd-b1f6-786883b25400','16af1213-5660-4491-a083-813e8ec9b818',1,1,'10',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d372d066-5269-432e-8908-ea425b88b173','16af1213-5660-4491-a083-813e8ec9b818',1,2,'15',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ab20dd19-8e34-434a-9457-390ec6cd85c7','16af1213-5660-4491-a083-813e8ec9b818',1,3,'20',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('59dc5a1b-47a8-4e4a-8208-09303178dad5',1,'en-que-continente-esta-turquia-mayoria-de-su-territorio','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('960337cc-a527-4db4-a07b-7a0cbe12c6a3','59dc5a1b-47a8-4e4a-8208-09303178dad5','es','¿En qué continente está Turquía (mayoría de su territorio)?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c2431990-5247-4609-b7d5-a24b5d103335','59dc5a1b-47a8-4e4a-8208-09303178dad5',1,0,'Europa',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('22b86864-0d92-451f-a358-2136b40231a5','59dc5a1b-47a8-4e4a-8208-09303178dad5',1,1,'Asia',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a37d84f4-e56a-4702-8397-03b45587e231','59dc5a1b-47a8-4e4a-8208-09303178dad5',1,2,'Está dividida entre Europa y Asia',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e7c8ec5a-4d9b-432a-a452-8a2b6f440300','59dc5a1b-47a8-4e4a-8208-09303178dad5',1,3,'África',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('ddcad488-3e64-452e-8af3-4d23cf8e486c',1,'cuantos-bits-tenia-la-primera-playstation-de-sony','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('94cd0236-3ca3-4a8c-a3ff-710492e9cd2a','ddcad488-3e64-452e-8af3-4d23cf8e486c','es','¿Cuántos bits tenía la primera PlayStation de Sony?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4956a776-5af4-45dd-8df6-188bf920490c','ddcad488-3e64-452e-8af3-4d23cf8e486c',1,0,'16 bits',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f9a794f3-db24-4d27-a750-bd8cbdd8aa48','ddcad488-3e64-452e-8af3-4d23cf8e486c',1,1,'32 bits',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ed26d5ff-d2f5-4951-8315-7bac335cd995','ddcad488-3e64-452e-8af3-4d23cf8e486c',1,2,'64 bits',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7966af25-559c-46c2-aec7-4f2fb964efb2','ddcad488-3e64-452e-8af3-4d23cf8e486c',1,3,'128 bits',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('8d745a55-9532-4fbf-aeff-3ebd536d4eba',1,'que-juego-popularizo-el-genero-battle-royale','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('c893c433-3cd2-48c1-9831-cfdaf1568799','8d745a55-9532-4fbf-aeff-3ebd536d4eba','es','¿Qué juego popularizó el género ''battle royale''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('11e2cf60-a0d9-468c-96a5-fad4a76c1121','8d745a55-9532-4fbf-aeff-3ebd536d4eba',1,0,'Fortnite',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e03b81fa-99ac-4ae1-972c-6490aac0db9b','8d745a55-9532-4fbf-aeff-3ebd536d4eba',1,1,'PUBG (PlayerUnknown''s Battlegrounds)',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('058a6689-5997-4b39-9973-592d66ade8f9','8d745a55-9532-4fbf-aeff-3ebd536d4eba',1,2,'H1Z1',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e4aaa364-0a01-46ed-b36a-f6d5104b2681','8d745a55-9532-4fbf-aeff-3ebd536d4eba',1,3,'Apex Legends',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('b417cf33-0ffd-49f8-949e-8202aa29f17b',1,'como-se-llama-el-protagonista-de-hollow-knight','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('2a710d98-603a-47f6-a95d-dd3e6e71b910','b417cf33-0ffd-49f8-949e-8202aa29f17b','es','¿Cómo se llama el protagonista de ''Hollow Knight''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e400d3bd-da61-4455-99d0-0a36d12e554e','b417cf33-0ffd-49f8-949e-8202aa29f17b',1,0,'Knight',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b1fff98b-e225-41c3-8228-21b11110d20b','b417cf33-0ffd-49f8-949e-8202aa29f17b',1,1,'The Knight',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('947a8244-7821-45f2-ac65-9e5aa97d9f0c','b417cf33-0ffd-49f8-949e-8202aa29f17b',1,2,'Hornet',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('601f8786-a6ad-481a-a7c2-50761ad222d8','b417cf33-0ffd-49f8-949e-8202aa29f17b',1,3,'Grimm',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('90d266fa-7dba-4969-ae75-603f2e5eb15a',1,'en-que-ano-salio-stardew-valley','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('b935750f-f9f0-4a6d-a868-232988afcfc0','90d266fa-7dba-4969-ae75-603f2e5eb15a','es','¿En qué año salió ''Stardew Valley''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('06dd9d3d-55fd-4234-845a-c65deafc9e4f','90d266fa-7dba-4969-ae75-603f2e5eb15a',1,0,'2014',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('608c8c98-9510-4e36-9468-86ea663ba1d8','90d266fa-7dba-4969-ae75-603f2e5eb15a',1,1,'2015',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('09c253ca-19bb-43ec-96b7-1c9df96aa01f','90d266fa-7dba-4969-ae75-603f2e5eb15a',1,2,'2016',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f1db79c1-bcb4-42f2-a807-2772eb4eccb8','90d266fa-7dba-4969-ae75-603f2e5eb15a',1,3,'2017',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('715af5a3-7222-46a5-9a06-7b915941b9d9',1,'cuantos-jugadores-soporta-minecraft-en-un-servidor-multijugador-online','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('72501995-0f7b-4b7a-af04-8fb8395d169b','715af5a3-7222-46a5-9a06-7b915941b9d9','es','¿Cuántos jugadores soporta Minecraft en un servidor multijugador online?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c1e6e63b-5926-4e6b-83f1-7d87ffd43f9c','715af5a3-7222-46a5-9a06-7b915941b9d9',1,0,'Solo 4',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('61e8c91e-1976-4dd1-ab2b-70450ac90162','715af5a3-7222-46a5-9a06-7b915941b9d9',1,1,'Solo 8',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('abf260e1-da7f-457c-91f4-7d156a9197ef','715af5a3-7222-46a5-9a06-7b915941b9d9',1,2,'Hasta 20',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c97df16f-3f6d-472c-8138-fc2f8bbab8c9','715af5a3-7222-46a5-9a06-7b915941b9d9',1,3,'Miles (depende del servidor)',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('ab89954e-a54c-4cfd-80c7-2d8f5da09e98',1,'cuantos-jugadores-simultaneos-record-tuvo-gta-online-en-steam','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('c7b0c685-fbac-4a59-a2d4-9c0d3ce34ef8','ab89954e-a54c-4cfd-80c7-2d8f5da09e98','es','¿Cuántos jugadores simultáneos récord tuvo GTA Online en Steam?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('30e0a445-a574-40f5-8603-9975681c348d','ab89954e-a54c-4cfd-80c7-2d8f5da09e98',1,0,'50.000',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8c8bb188-ac09-4ae0-882e-2be1928623e5','ab89954e-a54c-4cfd-80c7-2d8f5da09e98',1,1,'100.000',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('22f17562-f6b7-4add-a0c3-ade34a9a8541','ab89954e-a54c-4cfd-80c7-2d8f5da09e98',1,2,'150.000',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('378cc9ab-615c-4d45-8d94-134a7b692c19','ab89954e-a54c-4cfd-80c7-2d8f5da09e98',1,3,'364.548',true,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('dd7fa090-ae09-4f0c-ad1f-a915b4dac2ec',1,'cuantas-estrellas-maximas-tiene-el-sistema-de-busqueda-en-gta','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('69e806a8-ad15-4299-b9fa-e3f024af001a','dd7fa090-ae09-4f0c-ad1f-a915b4dac2ec','es','¿Cuántas estrellas máximas tiene el sistema de búsqueda en GTA?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('55db0e6d-3349-4796-ba01-3c0cd7aeb4b7','dd7fa090-ae09-4f0c-ad1f-a915b4dac2ec',1,0,'4',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e46775e3-361e-43b0-9839-52cb26340da1','dd7fa090-ae09-4f0c-ad1f-a915b4dac2ec',1,1,'5',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('0805ecf7-5ea1-4909-814f-ecdb0adb90e5','dd7fa090-ae09-4f0c-ad1f-a915b4dac2ec',1,2,'6',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('502db6d6-79aa-4a7f-b73b-da6798f2ad67','dd7fa090-ae09-4f0c-ad1f-a915b4dac2ec',1,3,'7',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('fc29d113-af6a-4030-a1c9-5578f1649f87',1,'que-empresa-desarrollo-el-juego-stardew-valley','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('b9b4edc8-a203-4a93-9361-8477f859a5cc','fc29d113-af6a-4030-a1c9-5578f1649f87','es','¿Qué empresa desarrolló el juego ''Stardew Valley''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('90fdb6e7-3102-451d-bd63-03ee024e3a28','fc29d113-af6a-4030-a1c9-5578f1649f87',1,0,'Nintendo',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f604b929-c267-4913-9ec5-62d72dd0d1a7','fc29d113-af6a-4030-a1c9-5578f1649f87',1,1,'Un desarrollador solo (ConcernedApe)',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('0ec295e4-d923-4ef3-b4cb-57838a7bb04e','fc29d113-af6a-4030-a1c9-5578f1649f87',1,2,'EA Games',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a0a2f778-71a2-4cab-bc0c-8a9d10bb2bfb','fc29d113-af6a-4030-a1c9-5578f1649f87',1,3,'Ubisoft',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('147af21f-a01a-4590-bde7-08fc9c66f140',1,'cual-fue-el-primer-juego-de-la-saga-the-legend-of-zelda','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('be4040d2-b5e7-45fe-81e9-eecb5cc2ca84','147af21f-a01a-4590-bde7-08fc9c66f140','es','¿Cuál fue el primer juego de la saga ''The Legend of Zelda''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7fbb45c9-0bb1-4388-a70a-79690533315c','147af21f-a01a-4590-bde7-08fc9c66f140',1,0,'Ocarina of Time',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('405cd102-57c0-4b85-9d04-9be281c9c70f','147af21f-a01a-4590-bde7-08fc9c66f140',1,1,'A Link to the Past',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a1c63671-81bf-4477-93b7-46ed334f2f78','147af21f-a01a-4590-bde7-08fc9c66f140',1,2,'The Legend of Zelda (1986)',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('38a44674-6b7e-4e3d-a62a-f995de356a41','147af21f-a01a-4590-bde7-08fc9c66f140',1,3,'Twilight Princess',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('a628ee65-91a0-4f69-aa59-aff40cf6fcdb',1,'cuantos-jugadores-puede-tener-un-clan-en-clash-of-clans','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('5802f43b-8c2a-4481-945f-683a99e1f365','a628ee65-91a0-4f69-aa59-aff40cf6fcdb','es','¿Cuántos jugadores puede tener un clan en Clash of Clans?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f5a37308-161d-40f0-be52-bb00924e7a37','a628ee65-91a0-4f69-aa59-aff40cf6fcdb',1,0,'30',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7d49e14f-d24d-45e7-be58-bcdf9ddb2796','a628ee65-91a0-4f69-aa59-aff40cf6fcdb',1,1,'40',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3808c8c6-06e0-48a9-ab34-16fdd72f3b92','a628ee65-91a0-4f69-aa59-aff40cf6fcdb',1,2,'50',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1ba6d76f-039f-4e30-ba10-da5bcc499157','a628ee65-91a0-4f69-aa59-aff40cf6fcdb',1,3,'60',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('518f7ff5-8fc3-4347-830e-dd06310a70ae',1,'cual-es-el-tipo-de-fruta-del-diablo-que-tiene-kizaru-en-one-piece','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('9c6b8378-9ccc-4349-b691-cf811c6ddc03','518f7ff5-8fc3-4347-830e-dd06310a70ae','es','¿Cuál es el tipo de Fruta del Diablo que tiene Kizaru en One Piece?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9b4a5b8b-73f6-484c-aa7f-41904ed488ec','518f7ff5-8fc3-4347-830e-dd06310a70ae',1,0,'Magma',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('cc28c3f6-b74f-492f-a445-681d46ab641c','518f7ff5-8fc3-4347-830e-dd06310a70ae',1,1,'Luz',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a909f8e1-c43e-4c11-ba10-10158516425a','518f7ff5-8fc3-4347-830e-dd06310a70ae',1,2,'Hielo',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('cacc6626-1778-4290-aa9f-ce0aa5b0515e','518f7ff5-8fc3-4347-830e-dd06310a70ae',1,3,'Oscuridad',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('c0abb31b-555e-4d44-a53a-319e5f82311b',1,'cuantos-anos-tiene-naruto-uzumaki-al-inicio-de-la-serie-original','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('7fbb4b2e-0a5f-40e9-b000-3f2f42f1cf42','c0abb31b-555e-4d44-a53a-319e5f82311b','es','¿Cuántos años tiene Naruto Uzumaki al inicio de la serie original?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e1f83e92-758d-4d88-bbe9-d885f3c2dc9c','c0abb31b-555e-4d44-a53a-319e5f82311b',1,0,'10',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3e1f785e-cc4d-4104-9f2d-ed2a50f84726','c0abb31b-555e-4d44-a53a-319e5f82311b',1,1,'11',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('24f9b0bc-4441-4a8a-84ca-039e975e06b4','c0abb31b-555e-4d44-a53a-319e5f82311b',1,2,'12',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a54fe2f7-e183-4e27-a604-8a8bf8a56493','c0abb31b-555e-4d44-a53a-319e5f82311b',1,3,'13',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('a7422dda-af0f-44b4-8ddf-2db11b15d37a',1,'que-poder-tiene-ace-hermano-de-luffy-en-one-piece','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('f0f8b0f5-bf11-46a1-a449-83851c20402a','a7422dda-af0f-44b4-8ddf-2db11b15d37a','es','¿Qué poder tiene Ace (hermano de Luffy) en One Piece?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b9eee3d1-e0e2-4614-9033-673c95e763e4','a7422dda-af0f-44b4-8ddf-2db11b15d37a',1,0,'Fuego',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('911f5cb2-02c5-48a3-9c04-73aaad58b590','a7422dda-af0f-44b4-8ddf-2db11b15d37a',1,1,'Hielo',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b9dd4c26-5224-4e9b-a0e3-2da07c72b708','a7422dda-af0f-44b4-8ddf-2db11b15d37a',1,2,'Electricidad',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('735c3c5a-1868-4b10-8583-516aa081dce8','a7422dda-af0f-44b4-8ddf-2db11b15d37a',1,3,'Oscuridad',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('7891f7ce-74b6-462d-b14b-2649b8f4f9e1',1,'en-que-ano-empezo-el-anime-de-my-hero-academia-1','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('37208bcd-cc78-43b0-94f4-88d31d2b5148','7891f7ce-74b6-462d-b14b-2649b8f4f9e1','es','¿En qué año empezó el anime de My Hero Academia?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f3d27dd1-c001-4b7f-b7c8-cd0969637502','7891f7ce-74b6-462d-b14b-2649b8f4f9e1',1,0,'2014',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c0be3a26-40ff-4aef-93f7-96b5f9aaf964','7891f7ce-74b6-462d-b14b-2649b8f4f9e1',1,1,'2015',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b37961af-9737-4ab7-897e-d6db26ef14db','7891f7ce-74b6-462d-b14b-2649b8f4f9e1',1,2,'2016',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f7d85ce5-d918-4668-9d40-fe3fd3a70868','7891f7ce-74b6-462d-b14b-2649b8f4f9e1',1,3,'2017',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('ed765e6b-3d19-4d7d-a156-81b665b8019d',1,'cuantos-kage-hay-en-el-mundo-de-naruto','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('3556ea25-d90b-48e4-a80e-9529352d8489','ed765e6b-3d19-4d7d-a156-81b665b8019d','es','¿Cuántos Kage hay en el mundo de Naruto?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9c8d2ab5-1895-4389-9d4c-bc6399fc04ca','ed765e6b-3d19-4d7d-a156-81b665b8019d',1,0,'4',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('579635a8-ea5f-492e-8aed-350210032925','ed765e6b-3d19-4d7d-a156-81b665b8019d',1,1,'5',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4128ff22-c62d-410c-bcde-09780f2b815c','ed765e6b-3d19-4d7d-a156-81b665b8019d',1,2,'6',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('af7b54f1-5c2c-4f2c-82b0-7ad840707552','ed765e6b-3d19-4d7d-a156-81b665b8019d',1,3,'7',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('f7adbfd0-e010-47db-9046-908927598cc6',1,'cuantas-temporadas-tiene-narcos-mexico','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('0f2835f1-3a73-4cba-868f-14f3b37cc803','f7adbfd0-e010-47db-9046-908927598cc6','es','¿Cuántas temporadas tiene ''Narcos: México''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('885561cd-7e66-4e2a-8964-e315d0f433b8','f7adbfd0-e010-47db-9046-908927598cc6',1,0,'2',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3afdc45a-ab55-4f3c-a0a1-73477f01c847','f7adbfd0-e010-47db-9046-908927598cc6',1,1,'3',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9993f36f-a35d-4adc-964e-d2a20e07a4b3','f7adbfd0-e010-47db-9046-908927598cc6',1,2,'4',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9ddebaa5-2e7a-4d0c-920d-845bc4e456ee','f7adbfd0-e010-47db-9046-908927598cc6',1,3,'5',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('24e381f1-643f-46fe-b464-945b9db11590',1,'cuantos-asaltos-realiza-el-profesor-en-la-casa-de-papel','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('c179fbdb-eec7-432d-ae52-4e1b01c66e47','24e381f1-643f-46fe-b464-945b9db11590','es','¿Cuántos asaltos realiza ''El Profesor'' en La Casa de Papel?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('69c307ad-14aa-4216-82b6-483c1663f459','24e381f1-643f-46fe-b464-945b9db11590',1,0,'1',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4c3e1404-d077-4318-aec1-b66ad549ee77','24e381f1-643f-46fe-b464-945b9db11590',1,1,'2',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('76a9b4b3-9819-4236-81d9-3d795c3e4cf6','24e381f1-643f-46fe-b464-945b9db11590',1,2,'3',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('01aed29b-10f4-42ea-93a4-7bbb92ce0770','24e381f1-643f-46fe-b464-945b9db11590',1,3,'4',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('afa81676-286d-43ea-8646-bd85628ffa08',1,'cuantas-peliculas-tiene-la-saga-de-fast-furious-hasta-2023','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('a22865be-0bc3-41da-8069-7f2f4632c76f','afa81676-286d-43ea-8646-bd85628ffa08','es','¿Cuántas películas tiene la saga de ''Fast & Furious'' hasta 2023?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('cfb0f495-1fa3-4415-91a3-15687fe62145','afa81676-286d-43ea-8646-bd85628ffa08',1,0,'8',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('42bc5b4a-edda-487d-9a83-97a25dcde329','afa81676-286d-43ea-8646-bd85628ffa08',1,1,'9',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('fc1e51f6-83c6-42bf-a6b9-1fb4dc26c146','afa81676-286d-43ea-8646-bd85628ffa08',1,2,'10',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('38dcf312-1e91-457b-80e6-762c9387c96d','afa81676-286d-43ea-8646-bd85628ffa08',1,3,'11',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('68bfcc5f-24d2-4958-a8c0-e23d974be41d',1,'en-que-ano-se-estreno-la-serie-cobra-kai','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('e25c46ba-6034-416c-8511-cfdb5c44c8b0','68bfcc5f-24d2-4958-a8c0-e23d974be41d','es','¿En qué año se estrenó la serie ''Cobra Kai''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4b078a07-b128-473f-a7c8-6092e6c38e9d','68bfcc5f-24d2-4958-a8c0-e23d974be41d',1,0,'2016',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9b8fc0be-3c37-4c65-8ec6-17af39e4f2d3','68bfcc5f-24d2-4958-a8c0-e23d974be41d',1,1,'2017',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('136a00af-1212-4171-9658-cd6c5876ffdc','68bfcc5f-24d2-4958-a8c0-e23d974be41d',1,2,'2018',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('2e48191d-7457-4c29-8426-feab79b24ae1','68bfcc5f-24d2-4958-a8c0-e23d974be41d',1,3,'2019',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('390c73d9-a1d7-465f-b11f-73aa1aac8817',1,'cuantas-peliculas-tiene-la-saga-de-mision-imposible-hasta-2023','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('c4b52536-5eb2-46b1-abf7-43bcad69852d','390c73d9-a1d7-465f-b11f-73aa1aac8817','es','¿Cuántas películas tiene la saga de ''Misión Imposible'' hasta 2023?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8536ace1-de70-4088-a372-89fb4a7a180e','390c73d9-a1d7-465f-b11f-73aa1aac8817',1,0,'5',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('677f2318-0856-43f7-8b9a-b66addae6f31','390c73d9-a1d7-465f-b11f-73aa1aac8817',1,1,'6',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('0c704e67-4465-48ea-8513-a69e35675b84','390c73d9-a1d7-465f-b11f-73aa1aac8817',1,2,'7',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3404d8a9-099c-4d50-8537-02d1ae0dae59','390c73d9-a1d7-465f-b11f-73aa1aac8817',1,3,'8',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('ff203ae8-651e-4a63-9c44-97488bb86826',1,'de-que-ciudad-colombiana-es-el-cantante-j-balvin','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('486b31ca-3d1f-4945-856a-7910adfffe61','ff203ae8-651e-4a63-9c44-97488bb86826','es','¿De qué ciudad colombiana es el cantante J Balvin?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('66a31157-98f8-48f1-b60f-0bb965e7da04','ff203ae8-651e-4a63-9c44-97488bb86826',1,0,'Bogotá',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e0d85fbb-4a37-420b-b827-e43cbf36164f','ff203ae8-651e-4a63-9c44-97488bb86826',1,1,'Cali',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4bb248e1-c70e-486e-bee2-8777281581d1','ff203ae8-651e-4a63-9c44-97488bb86826',1,2,'Medellín',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('35fe6584-f977-4077-82a3-ab2adbeeb358','ff203ae8-651e-4a63-9c44-97488bb86826',1,3,'Barranquilla',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('58cd6711-a124-43a4-b415-101e0e6feaab',1,'cuantos-albumes-de-estudio-tiene-bad-bunny-hasta-2024','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('19492bca-e7a1-469a-a19f-0fbd21deba37','58cd6711-a124-43a4-b415-101e0e6feaab','es','¿Cuántos álbumes de estudio tiene Bad Bunny hasta 2024?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('36e9102c-4e92-4879-a3ac-83497071e25c','58cd6711-a124-43a4-b415-101e0e6feaab',1,0,'3',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('cd542b55-2fa5-4055-9e5f-0e8ab8ae48b4','58cd6711-a124-43a4-b415-101e0e6feaab',1,1,'4',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('050e0cd7-1e1c-4e78-af2c-29fbc82089a1','58cd6711-a124-43a4-b415-101e0e6feaab',1,2,'5',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('51cb239a-b308-4397-b9c4-7663a9a8b5d0','58cd6711-a124-43a4-b415-101e0e6feaab',1,3,'6',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('f23ed734-cecf-48e8-9a59-e447be7bbdf2',1,'que-instrumento-es-mas-antiguo-la-guitarra-o-el-violin','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('e85b688d-8213-470e-9428-7cd894931c1c','f23ed734-cecf-48e8-9a59-e447be7bbdf2','es','¿Qué instrumento es más antiguo: la guitarra o el violín?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('02dd0481-436f-4216-8edd-3b995e9748b8','f23ed734-cecf-48e8-9a59-e447be7bbdf2',1,0,'La guitarra',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ffb05afe-e97b-4fdc-b493-4028ad459ced','f23ed734-cecf-48e8-9a59-e447be7bbdf2',1,1,'El violín',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8303ca57-2c44-4833-beeb-5d4024f9c5fd','f23ed734-cecf-48e8-9a59-e447be7bbdf2',1,2,'Tienen la misma edad',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('01418196-365a-4d55-8f71-2a613ef592c2','f23ed734-cecf-48e8-9a59-e447be7bbdf2',1,3,'Ninguno existe antes del siglo XV',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('1154a587-6bc9-460c-b18e-2eaeec7f99b9',1,'de-que-pais-es-la-cantante-karol-g','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('5d67425c-46ef-4a91-8840-1f906529702f','1154a587-6bc9-460c-b18e-2eaeec7f99b9','es','¿De qué país es la cantante Karol G?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a0ddb10a-a4eb-46a1-a076-6c1b7df166c8','1154a587-6bc9-460c-b18e-2eaeec7f99b9',1,0,'Venezuela',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c98b48c8-05d6-47f1-8649-4eb593f62123','1154a587-6bc9-460c-b18e-2eaeec7f99b9',1,1,'Colombia',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4572eee0-e0b8-445b-8321-e460c356d5f2','1154a587-6bc9-460c-b18e-2eaeec7f99b9',1,2,'México',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a5985ca2-8781-454e-b675-e2da08d7a62a','1154a587-6bc9-460c-b18e-2eaeec7f99b9',1,3,'Puerto Rico',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('e9c3d251-20b0-4a96-b1c7-b40f92a5c1fc',1,'cuantos-litros-de-sangre-tiene-el-cuerpo-humano-adulto-aproximadamente','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('afabbfd9-1a1c-44fd-bbbf-dfbc95dd19e8','e9c3d251-20b0-4a96-b1c7-b40f92a5c1fc','es','¿Cuántos litros de sangre tiene el cuerpo humano adulto aproximadamente?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('1f2e79fb-558b-4e5d-a7bb-0715504f387e','e9c3d251-20b0-4a96-b1c7-b40f92a5c1fc',1,0,'3-4 litros',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3073192a-6de9-43b7-ba55-7f443deb40fa','e9c3d251-20b0-4a96-b1c7-b40f92a5c1fc',1,1,'5-6 litros',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a170c6bc-3ed5-4566-a93e-5c91d235a2cf','e9c3d251-20b0-4a96-b1c7-b40f92a5c1fc',1,2,'7-8 litros',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('501600cd-066e-40d0-858e-57cc6c3f5ed6','e9c3d251-20b0-4a96-b1c7-b40f92a5c1fc',1,3,'9-10 litros',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('0d6b0cb2-80d2-45b0-bb68-e247bafa5e8d',1,'a-cuantos-grados-centigrados-se-derrite-el-hierro','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('927470b7-3ec6-4193-adf7-bba988297dae','0d6b0cb2-80d2-45b0-bb68-e247bafa5e8d','es','¿A cuántos grados centígrados se derrite el hierro?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('79174876-b4a9-4d84-b385-a41f0fbcbcf6','0d6b0cb2-80d2-45b0-bb68-e247bafa5e8d',1,0,'800°C',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5a3d8ac6-973b-4ac9-92c6-231e4cbfef08','0d6b0cb2-80d2-45b0-bb68-e247bafa5e8d',1,1,'1100°C',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('18778b74-f967-4473-9288-cfe2c7469d03','0d6b0cb2-80d2-45b0-bb68-e247bafa5e8d',1,2,'1538°C',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3e8f8309-f1d0-45ed-9504-f6ae3c6eafc1','0d6b0cb2-80d2-45b0-bb68-e247bafa5e8d',1,3,'2000°C',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('c395ae69-6fcd-4ed4-9334-ecb10bb3f387',1,'cuantos-huesos-tiene-la-mano-humana','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('5ce124eb-75fd-4db5-926a-9c47ab503d60','c395ae69-6fcd-4ed4-9334-ecb10bb3f387','es','¿Cuántos huesos tiene la mano humana?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3bea5ef9-79ca-4286-b9d2-ef72c6ec4470','c395ae69-6fcd-4ed4-9334-ecb10bb3f387',1,0,'20',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5a64d236-1ce8-497d-aa35-7fa4982d389d','c395ae69-6fcd-4ed4-9334-ecb10bb3f387',1,1,'24',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('451e0d5e-f47c-4e4a-a9da-686f3df41f8a','c395ae69-6fcd-4ed4-9334-ecb10bb3f387',1,2,'27',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('fc28d68c-798e-4c26-8b48-5147b9c79ae4','c395ae69-6fcd-4ed4-9334-ecb10bb3f387',1,3,'30',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('c93a8fc3-6e4e-4642-a938-3d875314fa6a',1,'cuanto-mide-el-diametro-de-la-tierra-aproximadamente','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('e36ebda4-13ea-479b-a67c-74e81b977d3e','c93a8fc3-6e4e-4642-a938-3d875314fa6a','es','¿Cuánto mide el diámetro de la Tierra aproximadamente?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('014c839c-0bb6-4caf-b01c-fb2e761bb0a6','c93a8fc3-6e4e-4642-a938-3d875314fa6a',1,0,'6.371 km',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('84cb226a-36eb-4882-9cd3-282f7bb3d45d','c93a8fc3-6e4e-4642-a938-3d875314fa6a',1,1,'12.742 km',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('88658353-85ee-49cf-9833-8aa3b32485c5','c93a8fc3-6e4e-4642-a938-3d875314fa6a',1,2,'40.075 km',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('643b674a-2a04-4ab9-b57c-3a304f29009c','c93a8fc3-6e4e-4642-a938-3d875314fa6a',1,3,'384.400 km',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('db4dbcd0-af88-4042-9939-f6bb8effcd42',1,'en-que-deporte-se-usa-el-termino-hat-trick','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('664e9277-9a05-491e-9621-5fb8a2141010','db4dbcd0-af88-4042-9939-f6bb8effcd42','es','¿En qué deporte se usa el término ''hat-trick''?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a17ba9e2-8fac-495d-a4b4-f3c529c0b875','db4dbcd0-af88-4042-9939-f6bb8effcd42',1,0,'Solo en fútbol',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('27bdae55-6537-4948-881a-dd97a50db929','db4dbcd0-af88-4042-9939-f6bb8effcd42',1,1,'Solo en hockey',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('81eede03-bb7e-4434-bade-c059c724ac3a','db4dbcd0-af88-4042-9939-f6bb8effcd42',1,2,'En varios deportes (fútbol, hockey, críquet)',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9054efa6-15c0-43c0-a578-37b52c888f72','db4dbcd0-af88-4042-9939-f6bb8effcd42',1,3,'Solo en béisbol',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('f6d42a16-fb7e-416b-901b-940fcf8f7371',1,'cuantos-puntos-vale-un-tiro-de-3-en-basquetbol','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('3740d722-89cf-4117-a1ad-1da94c544c3e','f6d42a16-fb7e-416b-901b-940fcf8f7371','es','¿Cuántos puntos vale un tiro de 3 en básquetbol?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('98efa64a-2434-4d6f-ab37-c3c28f550262','f6d42a16-fb7e-416b-901b-940fcf8f7371',1,0,'2',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c336e3df-fb34-449a-be1a-4a69474b4a5b','f6d42a16-fb7e-416b-901b-940fcf8f7371',1,1,'3',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5e2619b8-5856-4da2-9d7f-4ef996ed1df1','f6d42a16-fb7e-416b-901b-940fcf8f7371',1,2,'4',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('bded7f77-7da6-4f02-a8b5-f3f892471aa9','f6d42a16-fb7e-416b-901b-940fcf8f7371',1,3,'5',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('4631b2b3-d0be-4ad9-b5b3-eea529c37542',1,'cuantos-metros-tiene-una-vuelta-a-la-pista-de-atletismo-estandar','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('aeb4b07a-8829-4b54-9148-c41906e8b257','4631b2b3-d0be-4ad9-b5b3-eea529c37542','es','¿Cuántos metros tiene una vuelta a la pista de atletismo estándar?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('62bf93c7-1f2c-4c8a-a187-f990faaa55fb','4631b2b3-d0be-4ad9-b5b3-eea529c37542',1,0,'200 metros',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('83579726-4986-44ec-a6a7-01bffa84020b','4631b2b3-d0be-4ad9-b5b3-eea529c37542',1,1,'300 metros',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9ecc3a73-bdfe-4092-b205-69ab7341a5d9','4631b2b3-d0be-4ad9-b5b3-eea529c37542',1,2,'400 metros',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('b4bb487c-3592-4902-b3bd-4f0b8c30e03f','4631b2b3-d0be-4ad9-b5b3-eea529c37542',1,3,'500 metros',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('3f22e401-649e-445e-83d0-ead7560eea88',1,'en-que-ano-fueron-los-primeros-juegos-paralimpicos','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('b80a5d9a-22d7-4e5b-857b-0fbdec5b3240','3f22e401-649e-445e-83d0-ead7560eea88','es','¿En qué año fueron los primeros Juegos Paralímpicos?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4aaaac54-55f3-4633-9195-8ceea94dc4ef','3f22e401-649e-445e-83d0-ead7560eea88',1,0,'1948',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('cd344aa2-a321-4c3e-9959-42d1765d839b','3f22e401-649e-445e-83d0-ead7560eea88',1,1,'1952',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('42badab4-f139-4ca0-83c7-39dc2ae53fc8','3f22e401-649e-445e-83d0-ead7560eea88',1,2,'1960',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('df294080-8ff4-47a9-82fd-5c3067493f4b','3f22e401-649e-445e-83d0-ead7560eea88',1,3,'1968',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('5b9ea18f-54bb-4fcd-b277-dcf04e624043',1,'cuantos-jugadores-tiene-un-equipo-de-beisbol-en-cancha','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('160fc925-0b22-41a6-a4bc-5d9225b06f73','5b9ea18f-54bb-4fcd-b277-dcf04e624043','es','¿Cuántos jugadores tiene un equipo de béisbol en cancha?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f1d65eae-d11a-4ead-8b58-8de11f811368','5b9ea18f-54bb-4fcd-b277-dcf04e624043',1,0,'7',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('dfb58197-e731-483b-8f0e-2ba85ba6be10','5b9ea18f-54bb-4fcd-b277-dcf04e624043',1,1,'8',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('5f223650-653f-4116-bee1-ad1d944358d0','5b9ea18f-54bb-4fcd-b277-dcf04e624043',1,2,'9',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3aecadf1-e9c8-4af8-bb95-54c52b1ce7f2','5b9ea18f-54bb-4fcd-b277-dcf04e624043',1,3,'10',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('9f35db26-07e0-43d5-ae11-1656e7547513',1,'cuantos-caracteres-maximo-permite-un-nombre-de-usuario-en-instagram','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('f47629f0-c043-46c7-b931-1984896dfd9a','9f35db26-07e0-43d5-ae11-1656e7547513','es','¿Cuántos caracteres máximo permite un nombre de usuario en Instagram?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('641ee30c-a8e8-4f18-83a3-38f08f2e6df3','9f35db26-07e0-43d5-ae11-1656e7547513',1,0,'20',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('71ba6a92-6e59-45da-a8a9-52b239d4bf3f','9f35db26-07e0-43d5-ae11-1656e7547513',1,1,'25',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6cee7940-677e-4e65-8f4e-e6bc80090d79','9f35db26-07e0-43d5-ae11-1656e7547513',1,2,'30',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('6c3f5085-cb43-4fe3-b690-f2925067c465','9f35db26-07e0-43d5-ae11-1656e7547513',1,3,'40',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('9252a729-0006-4f38-bd93-1427e2f43b47',1,'que-significa-ux-en-diseno-digital','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('eacd9a0e-bc2b-4cff-a423-aefe3542ad19','9252a729-0006-4f38-bd93-1427e2f43b47','es','¿Qué significa ''UX'' en diseño digital?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('4974ff2d-4641-48a8-9109-fbaa248a0c1f','9252a729-0006-4f38-bd93-1427e2f43b47',1,0,'Ultra Experience',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('af6bf469-c4da-4ad3-85d6-9dbcc3527c0b','9252a729-0006-4f38-bd93-1427e2f43b47',1,1,'User Experience',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('aaef1743-3bc7-4ed3-9474-54b585fb60f3','9252a729-0006-4f38-bd93-1427e2f43b47',1,2,'Unified Exchange',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('85d5d96a-9515-4bca-872c-894f3c99f5a8','9252a729-0006-4f38-bd93-1427e2f43b47',1,3,'Universal Extension',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('f0893269-198a-474d-911f-bfc8cbd82071',1,'en-que-ano-se-fundo-reddit','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('3bd8abae-4d30-4414-bc90-923638f4cf75','f0893269-198a-474d-911f-bfc8cbd82071','es','¿En qué año se fundó Reddit?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('d8749ea1-b46c-41d7-98a5-91be0f80ab1e','f0893269-198a-474d-911f-bfc8cbd82071',1,0,'2003',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('823b8ff1-7f45-4965-b145-01245b9a1f77','f0893269-198a-474d-911f-bfc8cbd82071',1,1,'2005',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('2f410dd6-6805-4ac5-a331-e67b7082e877','f0893269-198a-474d-911f-bfc8cbd82071',1,2,'2007',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8985c285-a653-433d-90f0-486f1a1d9423','f0893269-198a-474d-911f-bfc8cbd82071',1,3,'2009',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('8d8dedf5-2b20-485c-96d5-1de28aee7bbb',1,'en-que-ano-se-fundo-el-club-atletico-boca-juniors','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('9f7c68c9-ca17-431e-ae6d-c99b686fca95','8d8dedf5-2b20-485c-96d5-1de28aee7bbb','es','¿En qué año se fundó el Club Atlético Boca Juniors?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f5e77085-6154-4371-bfbd-05a63f6a238e','8d8dedf5-2b20-485c-96d5-1de28aee7bbb',1,0,'1900',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7455b27f-39d7-4594-bcbc-7238f4611800','8d8dedf5-2b20-485c-96d5-1de28aee7bbb',1,1,'1905',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('9be758e2-2904-4816-915a-d0834b4486e9','8d8dedf5-2b20-485c-96d5-1de28aee7bbb',1,2,'1908',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('474bb88f-145c-41b0-9574-e984e5e18b46','8d8dedf5-2b20-485c-96d5-1de28aee7bbb',1,3,'1912',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('d12b4891-dad2-4b85-9c29-a41ec99a0f54',1,'cual-es-la-moneda-oficial-de-argentina','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('7f5118cb-10ca-49df-87d5-4e8dfd45daf5','d12b4891-dad2-4b85-9c29-a41ec99a0f54','es','¿Cuál es la moneda oficial de Argentina?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7ffd885c-00f5-4f61-88db-e8f911547256','d12b4891-dad2-4b85-9c29-a41ec99a0f54',1,0,'Austral',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('79d772c7-1c9b-4406-94da-927f0e9c53d3','d12b4891-dad2-4b85-9c29-a41ec99a0f54',1,1,'Peso Argentino',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('25c1dd46-75aa-4ec5-bd3a-8737c186dd00','d12b4891-dad2-4b85-9c29-a41ec99a0f54',1,2,'Real',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('013fea01-8192-4988-b8ef-c8b391cfe7e4','d12b4891-dad2-4b85-9c29-a41ec99a0f54',1,3,'Bolívar',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('e462dc73-db72-4448-bb35-29d56f91af23',1,'en-que-ano-se-fundo-la-onu-organizacion-de-naciones-unidas','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('bb3bec6d-de04-43ae-b304-e95715d514af','e462dc73-db72-4448-bb35-29d56f91af23','es','¿En qué año se fundó la ONU (Organización de Naciones Unidas)?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('97a94209-b924-4811-bafe-62fb0c5ba38a','e462dc73-db72-4448-bb35-29d56f91af23',1,0,'1943',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('fd412137-dd41-4fc6-8a84-abffa0f78500','e462dc73-db72-4448-bb35-29d56f91af23',1,1,'1944',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c733aa1c-ed63-494a-9dc4-c806dc8bcfd6','e462dc73-db72-4448-bb35-29d56f91af23',1,2,'1945',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('e4048af0-ee14-4b64-abb4-3013a6d04be2','e462dc73-db72-4448-bb35-29d56f91af23',1,3,'1946',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('64f5a39c-58da-4dd5-a6bf-fe88906a44dd',1,'cuantos-paises-firmaron-originalmente-la-onu','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('352fb98b-83b1-4519-9398-71310d3fafda','64f5a39c-58da-4dd5-a6bf-fe88906a44dd','es','¿Cuántos países firmaron originalmente la ONU?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('555359c0-deab-4aee-971a-300b3a6defbc','64f5a39c-58da-4dd5-a6bf-fe88906a44dd',1,0,'35',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('f0f1f551-03dd-4dda-89bf-e39f86938a8d','64f5a39c-58da-4dd5-a6bf-fe88906a44dd',1,1,'40',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('77f7e8e5-c69c-45b9-ae3c-e4e1c6004ec6','64f5a39c-58da-4dd5-a6bf-fe88906a44dd',1,2,'51',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('cf6d542c-e668-41d8-a431-aef832ff394a','64f5a39c-58da-4dd5-a6bf-fe88906a44dd',1,3,'60',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('f9c152ad-62aa-4a17-8421-ab10eacd2d43',1,'en-que-ano-piso-el-hombre-la-luna-por-primera-vez','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('848edc9a-825a-4f98-8e76-a32d20c39517','f9c152ad-62aa-4a17-8421-ab10eacd2d43','es','¿En qué año pisó el hombre la Luna por primera vez?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('92178ac3-1d52-4c15-a162-6f03eecd003c','f9c152ad-62aa-4a17-8421-ab10eacd2d43',1,0,'1965',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('18b89c83-b4e1-4b33-bc9d-86da5ba9ae20','f9c152ad-62aa-4a17-8421-ab10eacd2d43',1,1,'1967',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('7864f4e5-cce0-4c98-a5ca-996dc4f6a823','f9c152ad-62aa-4a17-8421-ab10eacd2d43',1,2,'1969',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('ceacc2ef-12fa-42db-9135-267b08023f3a','f9c152ad-62aa-4a17-8421-ab10eacd2d43',1,3,'1971',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('196a45df-a266-4355-8321-934d1c843bf3',1,'cuantos-metros-mide-la-gran-muralla-china-aproximadamente','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('d4e2faff-b887-46f5-a8b9-0fae0c038a29','196a45df-a266-4355-8321-934d1c843bf3','es','¿Cuántos metros mide la Gran Muralla China aproximadamente?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('2154bd5e-42e5-4bf5-8753-bae22b2618e9','196a45df-a266-4355-8321-934d1c843bf3',1,0,'5.000 km',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('a7c39eaf-154c-4ef9-858c-7a2631e2c83c','196a45df-a266-4355-8321-934d1c843bf3',1,1,'10.000 km',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('98d44929-738e-452a-8994-e471d8d4df68','196a45df-a266-4355-8321-934d1c843bf3',1,2,'21.000 km',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('c105fbed-c7a6-4b7c-be57-325f0a139c08','196a45df-a266-4355-8321-934d1c843bf3',1,3,'40.000 km',false,true,1.0,'{}');

INSERT INTO questions (id,version,slug,status,enabled,archived,answer_mode,created_by_type,default_duration_seconds,metadata) VALUES ('d6ea2f1f-1d32-494b-a0ef-1ca63332ce1a',1,'cuantos-anos-reino-cleopatra-en-egipto-aproximadamente','approved',true,false,'multiple_choice','human',10,'{}');
INSERT INTO question_translations (id,question_id,language,title,keywords) VALUES ('33e86eb9-33bb-44a3-b07e-41483ff2c7d9','d6ea2f1f-1d32-494b-a0ef-1ca63332ce1a','es','¿Cuántos años reinó Cleopatra en Egipto aproximadamente?','[]');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('3fb042e5-0d60-4c9f-8987-a7552b994b78','d6ea2f1f-1d32-494b-a0ef-1ca63332ce1a',1,0,'10 años',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('56960b1a-825c-4094-9b0b-4ada3f4a0d26','d6ea2f1f-1d32-494b-a0ef-1ca63332ce1a',1,1,'15 años',false,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('0c4e530f-f349-4502-b3c6-feb0d43b981f','d6ea2f1f-1d32-494b-a0ef-1ca63332ce1a',1,2,'21 años',true,true,1.0,'{}');
INSERT INTO answer_options (id,question_id,version,display_order,text,is_correct,enabled,weight,metadata) VALUES ('8174e2ee-4b21-4c7e-aca8-785b6ab64248','d6ea2f1f-1d32-494b-a0ef-1ca63332ce1a',1,3,'30 años',false,true,1.0,'{}');

-- Asignar tags a preguntas
INSERT INTO question_tags (question_id, tag_id) SELECT 'f86709f7-eae3-4de4-9374-8ecd82386e7c', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '0b8de970-bc0e-4ba8-8858-43239ff7e3e7', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '70750849-91b7-4cd9-ad52-1b07b14e702d', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '3c846436-e90b-4ca8-a60c-ca68a6c68492', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '916bf9b0-c1dd-45e2-8a03-0244818517ec', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '81a6c915-74d1-4eb5-a01d-5e96433b50bd', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'ccd46e0b-40ad-4378-9746-c2e5648e0244', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'ecd4b254-4d49-4ee5-955b-3705cfc518bf', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '65e32081-7caf-4621-9dff-1457ed223e3b', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '65e32081-7caf-4621-9dff-1457ed223e3b', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '68e23eee-2a73-4b3f-b746-495432095b1e', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '6fd99f78-99fc-4e1b-aca0-1059c9329b19', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '60d47f24-46ec-4eea-b2fd-94dd342c6042', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '33843aba-3eab-4109-9a0d-b651f326e605', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '56e758d1-a96f-4c36-98e4-49430716532d', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'c818e1b0-4d11-456e-a51d-1425e185884d', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'd03db57c-3c1d-4943-afce-88de4b921335', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '55e3abc6-7ac9-41c8-bd68-be6641dc95af', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '33bafa89-a71f-4b0a-adff-89af67a2372d', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'ce0e51ad-6675-4be2-8146-2cb98c738e4f', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'eb9000e5-b0ed-458b-bcd0-eec8c226024a', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '75a252ac-4a9b-46f7-ada8-6b27873ad7bd', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'ff2f827f-1c0e-472a-8f99-58aae2233c0f', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '7f856fee-4547-4ac5-a7b9-703851a76b94', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'a3e38d1c-141a-4d66-8ea0-8a778c3c594a', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'eaf963e8-2c41-4066-88ba-bc8242d66f11', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '4c59e986-d045-4d29-bcc9-49ef92205f98', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '92a3d297-bef0-46d3-a5bb-c74d7293a69c', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'c01fac9a-1b0d-43ac-bc68-2eda0dbfef4d', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '9be8de6d-f59e-49cf-ae47-8e1fe479b57a', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '10df9949-e3ea-4aec-b6cc-386ff8f9dbb2', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '7c9e5fc0-4576-4848-92c8-2c17b3bde991', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'a5e20185-5630-45d4-831d-4e6c1e751305', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '2c63ff05-981d-4cf1-85d7-a72fe79fb04c', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'ada74067-fbbe-4130-b4f6-1c838b9544d0', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '75232211-21f8-4eed-adaf-1b1e6e100d99', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'd41455ea-acb9-4b0c-a36f-3d56559989dc', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '78a4e7bf-2f67-4227-a5fe-ef37e6bd54e5', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '70271395-8b60-43b3-96b1-c331243f683e', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '73c11504-f564-4b31-94e9-97b3778ba4d8', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '609fe674-1b81-454f-b849-4dfd0c4d9cd7', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '8665e229-d4f8-4ff9-b77a-a41c71c24db8', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '1ee595d6-3036-4e61-9223-7ad548744b5b', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '0491db38-eecf-47e6-99d7-954ca60b84c1', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '75e99dda-eb87-46a3-91be-8da560d471bc', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '6fb07077-6662-4edc-8666-a1fac8a97e5a', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '1c5cc44b-574d-41c3-839c-fa8a77ad237d', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'cff15035-62c7-46b5-a222-d355d915cd9d', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'ef270d95-9b9b-4f08-b457-fd0680b00408', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '5f4538eb-8487-45a1-8ed6-ff946922b57f', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'e05d8bf1-a7ed-4cde-bf17-af8651dbff7d', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'f6cfa116-466d-4478-b055-7c5bf9f9b4b3', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '6d127c23-dcd7-4d26-9f03-eb4e8ea6f159', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'b7eb4296-a70f-41b2-93c3-cd7c30b1501a', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'd8eed3bb-5768-4cc7-9c8d-e7545e90f348', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '37b588b1-1484-48ba-84d5-7eb3ae717505', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'df4c4b5e-49cb-4ec2-805d-b3c94c2fece9', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '9080eb9e-0a93-497e-8a89-b751972d6cc2', id FROM tags WHERE slug = 'musica' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'd541b92c-2a02-46c6-8bd8-1fb3bf8beb02', id FROM tags WHERE slug = 'musica' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'd9837f1b-242a-49f7-8996-ef6dc41c990f', id FROM tags WHERE slug = 'musica' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '555ac268-b2fa-4ab0-8684-6f2ced39b51c', id FROM tags WHERE slug = 'musica' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '7a0d9fdc-3b9a-41e9-ba82-75f9abb5dd58', id FROM tags WHERE slug = 'musica' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '5840ed3a-d174-4bc7-9ace-92f310d53d61', id FROM tags WHERE slug = 'musica' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '405d1cfc-14db-4323-94c6-4b054187f8a2', id FROM tags WHERE slug = 'musica' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'e51a09bd-e037-4311-8df1-a4019155f916', id FROM tags WHERE slug = 'musica' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '05b4ce6f-161c-4b81-9c9a-7b93a3a37674', id FROM tags WHERE slug = 'musica' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'b5bc6861-d5ac-417f-9daf-43299b386cd3', id FROM tags WHERE slug = 'musica' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '1d462d35-4f89-4f90-903b-687e7f22fece', id FROM tags WHERE slug = 'musica' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'e92742a5-66b3-4372-84ac-33311adc3caa', id FROM tags WHERE slug = 'musica' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'e6a1aec8-4e22-4977-b5eb-92d1b998a001', id FROM tags WHERE slug = 'musica' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'fab246fa-3300-4858-84cf-0e993265b30f', id FROM tags WHERE slug = 'musica' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '27cef332-85b5-4777-be76-c5f90ea544ae', id FROM tags WHERE slug = 'musica' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '27cef332-85b5-4777-be76-c5f90ea544ae', id FROM tags WHERE slug = 'internet' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'cce27440-d704-4376-bcef-5423ad562956', id FROM tags WHERE slug = 'musica' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'c8d46113-1d19-409a-8cd8-16a76b347585', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'ae947ee5-17a6-4eff-b8fc-1ded356958b2', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '3428d39e-c8f8-4969-9a2a-8f631fdea66b', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'bfd98b3e-328d-4271-8a50-eab3f9423dd8', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '1d861d1e-3296-4ebd-9b19-54e5ff8161b3', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'fbc742a2-26a8-44a6-9abc-eeeab108ac60', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'bd999052-abbb-49c3-92f5-1f8cdf97c4f5', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '5bda2674-5930-4a2d-9117-01b206de3a20', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'f4ffb4b6-865e-48ac-9e98-7a308e11f9d3', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '9e9121c0-b7c7-4a17-ae32-f4a5b77ddc69', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'a8a528a5-0bd5-4054-a3e6-6e7ebcb4fada', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'a39737bb-d3e2-42e3-939d-a67fd04c4f19', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '3d21c37a-22a8-4268-b1cb-2a32cd85042a', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '97485c1a-bbe1-4374-b8bd-9562aed8e99b', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '56394974-4c7d-48ff-bffe-8931c9ee461d', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '8b50cbbf-ca83-4f28-8ef6-9a7e58545175', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '6aa04da7-6232-4af9-a0e8-e8ac5074ba63', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '1b544385-4d8e-4c35-8137-10213920bcdf', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'fdb48162-cc22-4899-9b10-d18f0f0140ea', id FROM tags WHERE slug = 'futbol' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'fdb48162-cc22-4899-9b10-d18f0f0140ea', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '7b093074-b614-46cc-929e-f056695b0cd5', id FROM tags WHERE slug = 'futbol' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '7b093074-b614-46cc-929e-f056695b0cd5', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '3b34e6e1-1efb-42b1-952d-8bbe1c9832f7', id FROM tags WHERE slug = 'futbol' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '3b34e6e1-1efb-42b1-952d-8bbe1c9832f7', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'd80d2387-76cf-44d4-a1b1-520124385b01', id FROM tags WHERE slug = 'futbol' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'd80d2387-76cf-44d4-a1b1-520124385b01', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '87dadc6e-bbff-4de5-b06e-4132acf8d1d1', id FROM tags WHERE slug = 'futbol' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '87dadc6e-bbff-4de5-b06e-4132acf8d1d1', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '1a2097b1-4f74-48a0-ab7f-fbf20d705ff4', id FROM tags WHERE slug = 'futbol' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '1a2097b1-4f74-48a0-ab7f-fbf20d705ff4', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'bd87bbc6-ff01-43ad-99bc-1791da9afeab', id FROM tags WHERE slug = 'futbol' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'bd87bbc6-ff01-43ad-99bc-1791da9afeab', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'cde82dc2-f08f-4139-beb4-caa7b7dec8a4', id FROM tags WHERE slug = 'futbol' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'cde82dc2-f08f-4139-beb4-caa7b7dec8a4', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '6af20048-cf25-4cb8-80f3-cbafa6048e3d', id FROM tags WHERE slug = 'futbol' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '6af20048-cf25-4cb8-80f3-cbafa6048e3d', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'eefbfd50-c8f4-4bf9-a754-f2f040b1c1ab', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '544689a9-a1c7-45f6-ae62-c8daac2dedef', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'e545d3f9-ecc9-4480-87ea-a7a0765dc193', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '9e4d2d2b-2909-4222-8b4c-ed5916622e23', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '5035201a-c299-4938-9b48-379c605bdbda', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '5035201a-c299-4938-9b48-379c605bdbda', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'd29578fc-67d9-4a62-acf2-3c4fd6b13d76', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '95e80d76-5e69-4cbd-913c-dd7aadedb67b', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'e242dd45-ecf2-4521-9ea3-6358af6ddde4', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '788a2559-cb1d-4997-acce-0eaf9b16c961', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'ce9fc988-bfd8-45a1-b358-eea2306871a4', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '46f0ad68-f23e-47e6-9b9a-c55afcad084a', id FROM tags WHERE slug = 'futbol' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '46f0ad68-f23e-47e6-9b9a-c55afcad084a', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'a72d71b0-03f9-414a-97ed-04e9910a548a', id FROM tags WHERE slug = 'internet' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'f64bf3b2-2c02-4d28-9920-d6438325a717', id FROM tags WHERE slug = 'internet' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '4bec6ca1-c250-4d05-8cf6-1d9a48bfbee5', id FROM tags WHERE slug = 'internet' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '5fe70c12-53c0-4a66-810e-891a90eddcf4', id FROM tags WHERE slug = 'internet' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'fed86933-0002-4226-bbea-6e994d6ffc98', id FROM tags WHERE slug = 'internet' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '97126408-b5ce-4338-8821-e2c575e83ae7', id FROM tags WHERE slug = 'internet' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '47075ba8-79f9-4223-9480-422560f1122f', id FROM tags WHERE slug = 'internet' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'f94e73d2-65f9-46c3-8334-6cec9e9b694d', id FROM tags WHERE slug = 'internet' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'f8f6636f-06f6-4d79-bb08-22eeef373adc', id FROM tags WHERE slug = 'internet' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'b1f8765d-eff0-4192-97d3-9113f24e7102', id FROM tags WHERE slug = 'internet' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'c9b2224a-6041-477c-b36a-94e7fc8d78e3', id FROM tags WHERE slug = 'internet' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'a31d08a0-670d-47f3-b61e-ef580fd29535', id FROM tags WHERE slug = 'internet' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '888d83bf-12cf-4ce4-996b-2f94a9e5ed72', id FROM tags WHERE slug = 'internet' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '8c501d83-2464-4e04-a85a-b594850c64bf', id FROM tags WHERE slug = 'internet' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '72675bb9-191b-40a3-a70e-297f9d966ca1', id FROM tags WHERE slug = 'ar' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '213250cd-8dfc-49f1-99cc-745145230e7e', id FROM tags WHERE slug = 'ar' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'fb0ce062-9c55-4425-a523-8f9635caf2bc', id FROM tags WHERE slug = 'ar' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '0edb0925-f6d6-48b4-a412-ef1fbd36f922', id FROM tags WHERE slug = 'ar' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'a1cfbc7b-32d3-4efc-83c9-fcdab40c99fb', id FROM tags WHERE slug = 'ar' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '682b8e26-b3f1-403e-a1fb-a42c7047c570', id FROM tags WHERE slug = 'ar' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '5a04dbbc-1867-453b-89f7-605bfc0da3ff', id FROM tags WHERE slug = 'ar' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '5a04dbbc-1867-453b-89f7-605bfc0da3ff', id FROM tags WHERE slug = 'futbol' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '315a0e56-8834-4d09-84f0-e7ad930054e4', id FROM tags WHERE slug = 'ar' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '25517815-2fd6-4093-b8d8-e2a3952fb924', id FROM tags WHERE slug = 'ar' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'a49bfd81-ac99-491b-93cd-e1e3ee79c12d', id FROM tags WHERE slug = 'ar' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '1d4ae28e-d6f9-4792-9c61-9c2a492bd920', id FROM tags WHERE slug = 'ar' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '7c355ca7-cc4b-4fdb-8c42-75ac41158896', id FROM tags WHERE slug = 'ar' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '4f64d2c9-7f5d-40bb-8250-b9b3759de981', id FROM tags WHERE slug = 'ar' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '249d1f7c-1af4-48e3-9102-eb42a905b016', id FROM tags WHERE slug = 'ar' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'b395374e-b601-42e9-901f-cbcf5ea0ce58', id FROM tags WHERE slug = 'ar' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '6c1879c4-efc2-410c-a689-03a3cef40561', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '16d3b8e3-1ab5-491d-bd77-79635f58039d', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '16d3b8e3-1ab5-491d-bd77-79635f58039d', id FROM tags WHERE slug = 'general' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'fcc05d99-95f1-4a1e-abf5-f3e179f46e12', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '518cd564-429c-44e0-ab7c-35b935b68d94', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '4a70fbd0-981a-4aa3-a645-92ee4b6e8994', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '4025071f-ddbb-4038-96f1-bfc2882ed22f', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'b25bdcae-7d2e-4f64-bdb0-f9901de39f03', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '85026ee9-fedb-467f-b425-d35d8218fbff', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'a84ffe2a-7280-4d2d-9776-aa1cbdeb3b58', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'fd660b4e-dacc-4a22-b02b-bf0d2f95a1a0', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '25fbe9a4-1559-453c-832a-03ba4b6be471', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '33512024-b34d-4384-a3da-6caf780421fb', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '591b536a-0bbf-4f89-9cad-283d08de6cd9', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '7efc84a0-d930-4ea5-bdd6-6522c6c6fcbc', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '352cb83a-f9c1-4458-8a5c-b463f215f96d', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '352cb83a-f9c1-4458-8a5c-b463f215f96d', id FROM tags WHERE slug = 'general' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'adca7ee1-32d7-458f-bc5f-ea7b1bdfba58', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '15be87c3-5dd3-4f93-99f2-aa2a4f77d496', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'ca121e00-30d5-4be1-8eac-04547a1d4d68', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '16af1213-5660-4491-a083-813e8ec9b818', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '59dc5a1b-47a8-4e4a-8208-09303178dad5', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '59dc5a1b-47a8-4e4a-8208-09303178dad5', id FROM tags WHERE slug = 'general' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'ddcad488-3e64-452e-8af3-4d23cf8e486c', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '8d745a55-9532-4fbf-aeff-3ebd536d4eba', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'b417cf33-0ffd-49f8-949e-8202aa29f17b', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '90d266fa-7dba-4969-ae75-603f2e5eb15a', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '715af5a3-7222-46a5-9a06-7b915941b9d9', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'ab89954e-a54c-4cfd-80c7-2d8f5da09e98', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'dd7fa090-ae09-4f0c-ad1f-a915b4dac2ec', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'fc29d113-af6a-4030-a1c9-5578f1649f87', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '147af21f-a01a-4590-bde7-08fc9c66f140', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'a628ee65-91a0-4f69-aa59-aff40cf6fcdb', id FROM tags WHERE slug = 'gaming' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '518f7ff5-8fc3-4347-830e-dd06310a70ae', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'c0abb31b-555e-4d44-a53a-319e5f82311b', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'a7422dda-af0f-44b4-8ddf-2db11b15d37a', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '7891f7ce-74b6-462d-b14b-2649b8f4f9e1', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'ed765e6b-3d19-4d7d-a156-81b665b8019d', id FROM tags WHERE slug = 'anime' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'f7adbfd0-e010-47db-9046-908927598cc6', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '24e381f1-643f-46fe-b464-945b9db11590', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'afa81676-286d-43ea-8646-bd85628ffa08', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '68bfcc5f-24d2-4958-a8c0-e23d974be41d', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '390c73d9-a1d7-465f-b11f-73aa1aac8817', id FROM tags WHERE slug = 'series' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'ff203ae8-651e-4a63-9c44-97488bb86826', id FROM tags WHERE slug = 'musica' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '58cd6711-a124-43a4-b415-101e0e6feaab', id FROM tags WHERE slug = 'musica' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'f23ed734-cecf-48e8-9a59-e447be7bbdf2', id FROM tags WHERE slug = 'musica' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '1154a587-6bc9-460c-b18e-2eaeec7f99b9', id FROM tags WHERE slug = 'musica' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'e9c3d251-20b0-4a96-b1c7-b40f92a5c1fc', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '0d6b0cb2-80d2-45b0-bb68-e247bafa5e8d', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'c395ae69-6fcd-4ed4-9334-ecb10bb3f387', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'c93a8fc3-6e4e-4642-a938-3d875314fa6a', id FROM tags WHERE slug = 'ciencia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'db4dbcd0-af88-4042-9939-f6bb8effcd42', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'db4dbcd0-af88-4042-9939-f6bb8effcd42', id FROM tags WHERE slug = 'futbol' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'f6d42a16-fb7e-416b-901b-940fcf8f7371', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '4631b2b3-d0be-4ad9-b5b3-eea529c37542', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '3f22e401-649e-445e-83d0-ead7560eea88', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '5b9ea18f-54bb-4fcd-b277-dcf04e624043', id FROM tags WHERE slug = 'deportes' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '9f35db26-07e0-43d5-ae11-1656e7547513', id FROM tags WHERE slug = 'internet' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '9252a729-0006-4f38-bd93-1427e2f43b47', id FROM tags WHERE slug = 'internet' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'f0893269-198a-474d-911f-bfc8cbd82071', id FROM tags WHERE slug = 'internet' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '8d8dedf5-2b20-485c-96d5-1de28aee7bbb', id FROM tags WHERE slug = 'ar' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '8d8dedf5-2b20-485c-96d5-1de28aee7bbb', id FROM tags WHERE slug = 'futbol' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'd12b4891-dad2-4b85-9c29-a41ec99a0f54', id FROM tags WHERE slug = 'ar' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'e462dc73-db72-4448-bb35-29d56f91af23', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '64f5a39c-58da-4dd5-a6bf-fe88906a44dd', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'f9c152ad-62aa-4a17-8421-ab10eacd2d43', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT '196a45df-a266-4355-8321-934d1c843bf3', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;
INSERT INTO question_tags (question_id, tag_id) SELECT 'd6ea2f1f-1d32-494b-a0ef-1ca63332ce1a', id FROM tags WHERE slug = 'historia' ON CONFLICT DO NOTHING;

INSERT INTO question_analytics (question_id,times_shown,times_answered,times_skipped,option_pick_rates,audience_difficulty_profiles,updated_at) SELECT id,0,0,0,'{}','{}',NOW() FROM questions WHERE id IN ('f86709f7-eae3-4de4-9374-8ecd82386e7c','0b8de970-bc0e-4ba8-8858-43239ff7e3e7','70750849-91b7-4cd9-ad52-1b07b14e702d','3c846436-e90b-4ca8-a60c-ca68a6c68492','916bf9b0-c1dd-45e2-8a03-0244818517ec','81a6c915-74d1-4eb5-a01d-5e96433b50bd','ccd46e0b-40ad-4378-9746-c2e5648e0244','ecd4b254-4d49-4ee5-955b-3705cfc518bf','65e32081-7caf-4621-9dff-1457ed223e3b','68e23eee-2a73-4b3f-b746-495432095b1e','6fd99f78-99fc-4e1b-aca0-1059c9329b19','60d47f24-46ec-4eea-b2fd-94dd342c6042','33843aba-3eab-4109-9a0d-b651f326e605','56e758d1-a96f-4c36-98e4-49430716532d','c818e1b0-4d11-456e-a51d-1425e185884d','d03db57c-3c1d-4943-afce-88de4b921335','55e3abc6-7ac9-41c8-bd68-be6641dc95af','33bafa89-a71f-4b0a-adff-89af67a2372d','ce0e51ad-6675-4be2-8146-2cb98c738e4f','eb9000e5-b0ed-458b-bcd0-eec8c226024a','75a252ac-4a9b-46f7-ada8-6b27873ad7bd','ff2f827f-1c0e-472a-8f99-58aae2233c0f','7f856fee-4547-4ac5-a7b9-703851a76b94','a3e38d1c-141a-4d66-8ea0-8a778c3c594a','eaf963e8-2c41-4066-88ba-bc8242d66f11','4c59e986-d045-4d29-bcc9-49ef92205f98','92a3d297-bef0-46d3-a5bb-c74d7293a69c','c01fac9a-1b0d-43ac-bc68-2eda0dbfef4d','9be8de6d-f59e-49cf-ae47-8e1fe479b57a','10df9949-e3ea-4aec-b6cc-386ff8f9dbb2','7c9e5fc0-4576-4848-92c8-2c17b3bde991','a5e20185-5630-45d4-831d-4e6c1e751305','2c63ff05-981d-4cf1-85d7-a72fe79fb04c','ada74067-fbbe-4130-b4f6-1c838b9544d0','75232211-21f8-4eed-adaf-1b1e6e100d99','d41455ea-acb9-4b0c-a36f-3d56559989dc','78a4e7bf-2f67-4227-a5fe-ef37e6bd54e5','70271395-8b60-43b3-96b1-c331243f683e','73c11504-f564-4b31-94e9-97b3778ba4d8','609fe674-1b81-454f-b849-4dfd0c4d9cd7','8665e229-d4f8-4ff9-b77a-a41c71c24db8','1ee595d6-3036-4e61-9223-7ad548744b5b','0491db38-eecf-47e6-99d7-954ca60b84c1','75e99dda-eb87-46a3-91be-8da560d471bc','6fb07077-6662-4edc-8666-a1fac8a97e5a','1c5cc44b-574d-41c3-839c-fa8a77ad237d','cff15035-62c7-46b5-a222-d355d915cd9d','ef270d95-9b9b-4f08-b457-fd0680b00408','5f4538eb-8487-45a1-8ed6-ff946922b57f','e05d8bf1-a7ed-4cde-bf17-af8651dbff7d','f6cfa116-466d-4478-b055-7c5bf9f9b4b3','6d127c23-dcd7-4d26-9f03-eb4e8ea6f159','b7eb4296-a70f-41b2-93c3-cd7c30b1501a','d8eed3bb-5768-4cc7-9c8d-e7545e90f348','37b588b1-1484-48ba-84d5-7eb3ae717505','df4c4b5e-49cb-4ec2-805d-b3c94c2fece9','9080eb9e-0a93-497e-8a89-b751972d6cc2','d541b92c-2a02-46c6-8bd8-1fb3bf8beb02','d9837f1b-242a-49f7-8996-ef6dc41c990f','555ac268-b2fa-4ab0-8684-6f2ced39b51c','7a0d9fdc-3b9a-41e9-ba82-75f9abb5dd58','5840ed3a-d174-4bc7-9ace-92f310d53d61','405d1cfc-14db-4323-94c6-4b054187f8a2','e51a09bd-e037-4311-8df1-a4019155f916','05b4ce6f-161c-4b81-9c9a-7b93a3a37674','b5bc6861-d5ac-417f-9daf-43299b386cd3','1d462d35-4f89-4f90-903b-687e7f22fece','e92742a5-66b3-4372-84ac-33311adc3caa','e6a1aec8-4e22-4977-b5eb-92d1b998a001','fab246fa-3300-4858-84cf-0e993265b30f','27cef332-85b5-4777-be76-c5f90ea544ae','cce27440-d704-4376-bcef-5423ad562956','c8d46113-1d19-409a-8cd8-16a76b347585','ae947ee5-17a6-4eff-b8fc-1ded356958b2','3428d39e-c8f8-4969-9a2a-8f631fdea66b','bfd98b3e-328d-4271-8a50-eab3f9423dd8','1d861d1e-3296-4ebd-9b19-54e5ff8161b3','fbc742a2-26a8-44a6-9abc-eeeab108ac60','bd999052-abbb-49c3-92f5-1f8cdf97c4f5','5bda2674-5930-4a2d-9117-01b206de3a20','f4ffb4b6-865e-48ac-9e98-7a308e11f9d3','9e9121c0-b7c7-4a17-ae32-f4a5b77ddc69','a8a528a5-0bd5-4054-a3e6-6e7ebcb4fada','a39737bb-d3e2-42e3-939d-a67fd04c4f19','3d21c37a-22a8-4268-b1cb-2a32cd85042a','97485c1a-bbe1-4374-b8bd-9562aed8e99b','56394974-4c7d-48ff-bffe-8931c9ee461d','8b50cbbf-ca83-4f28-8ef6-9a7e58545175','6aa04da7-6232-4af9-a0e8-e8ac5074ba63','1b544385-4d8e-4c35-8137-10213920bcdf','fdb48162-cc22-4899-9b10-d18f0f0140ea','7b093074-b614-46cc-929e-f056695b0cd5','3b34e6e1-1efb-42b1-952d-8bbe1c9832f7','d80d2387-76cf-44d4-a1b1-520124385b01','87dadc6e-bbff-4de5-b06e-4132acf8d1d1','1a2097b1-4f74-48a0-ab7f-fbf20d705ff4','bd87bbc6-ff01-43ad-99bc-1791da9afeab','cde82dc2-f08f-4139-beb4-caa7b7dec8a4','6af20048-cf25-4cb8-80f3-cbafa6048e3d','eefbfd50-c8f4-4bf9-a754-f2f040b1c1ab','544689a9-a1c7-45f6-ae62-c8daac2dedef','e545d3f9-ecc9-4480-87ea-a7a0765dc193','9e4d2d2b-2909-4222-8b4c-ed5916622e23','5035201a-c299-4938-9b48-379c605bdbda','d29578fc-67d9-4a62-acf2-3c4fd6b13d76','95e80d76-5e69-4cbd-913c-dd7aadedb67b','e242dd45-ecf2-4521-9ea3-6358af6ddde4','788a2559-cb1d-4997-acce-0eaf9b16c961','ce9fc988-bfd8-45a1-b358-eea2306871a4','46f0ad68-f23e-47e6-9b9a-c55afcad084a','a72d71b0-03f9-414a-97ed-04e9910a548a','f64bf3b2-2c02-4d28-9920-d6438325a717','4bec6ca1-c250-4d05-8cf6-1d9a48bfbee5','5fe70c12-53c0-4a66-810e-891a90eddcf4','fed86933-0002-4226-bbea-6e994d6ffc98','97126408-b5ce-4338-8821-e2c575e83ae7','47075ba8-79f9-4223-9480-422560f1122f','f94e73d2-65f9-46c3-8334-6cec9e9b694d','f8f6636f-06f6-4d79-bb08-22eeef373adc','b1f8765d-eff0-4192-97d3-9113f24e7102','c9b2224a-6041-477c-b36a-94e7fc8d78e3','a31d08a0-670d-47f3-b61e-ef580fd29535','888d83bf-12cf-4ce4-996b-2f94a9e5ed72','8c501d83-2464-4e04-a85a-b594850c64bf','72675bb9-191b-40a3-a70e-297f9d966ca1','213250cd-8dfc-49f1-99cc-745145230e7e','fb0ce062-9c55-4425-a523-8f9635caf2bc','0edb0925-f6d6-48b4-a412-ef1fbd36f922','a1cfbc7b-32d3-4efc-83c9-fcdab40c99fb','682b8e26-b3f1-403e-a1fb-a42c7047c570','5a04dbbc-1867-453b-89f7-605bfc0da3ff','315a0e56-8834-4d09-84f0-e7ad930054e4','25517815-2fd6-4093-b8d8-e2a3952fb924','a49bfd81-ac99-491b-93cd-e1e3ee79c12d','1d4ae28e-d6f9-4792-9c61-9c2a492bd920','7c355ca7-cc4b-4fdb-8c42-75ac41158896','4f64d2c9-7f5d-40bb-8250-b9b3759de981','249d1f7c-1af4-48e3-9102-eb42a905b016','b395374e-b601-42e9-901f-cbcf5ea0ce58','6c1879c4-efc2-410c-a689-03a3cef40561','16d3b8e3-1ab5-491d-bd77-79635f58039d','fcc05d99-95f1-4a1e-abf5-f3e179f46e12','518cd564-429c-44e0-ab7c-35b935b68d94','4a70fbd0-981a-4aa3-a645-92ee4b6e8994','4025071f-ddbb-4038-96f1-bfc2882ed22f','b25bdcae-7d2e-4f64-bdb0-f9901de39f03','85026ee9-fedb-467f-b425-d35d8218fbff','a84ffe2a-7280-4d2d-9776-aa1cbdeb3b58','fd660b4e-dacc-4a22-b02b-bf0d2f95a1a0','25fbe9a4-1559-453c-832a-03ba4b6be471','33512024-b34d-4384-a3da-6caf780421fb','591b536a-0bbf-4f89-9cad-283d08de6cd9','7efc84a0-d930-4ea5-bdd6-6522c6c6fcbc','352cb83a-f9c1-4458-8a5c-b463f215f96d','adca7ee1-32d7-458f-bc5f-ea7b1bdfba58','15be87c3-5dd3-4f93-99f2-aa2a4f77d496','ca121e00-30d5-4be1-8eac-04547a1d4d68','16af1213-5660-4491-a083-813e8ec9b818','59dc5a1b-47a8-4e4a-8208-09303178dad5','ddcad488-3e64-452e-8af3-4d23cf8e486c','8d745a55-9532-4fbf-aeff-3ebd536d4eba','b417cf33-0ffd-49f8-949e-8202aa29f17b','90d266fa-7dba-4969-ae75-603f2e5eb15a','715af5a3-7222-46a5-9a06-7b915941b9d9','ab89954e-a54c-4cfd-80c7-2d8f5da09e98','dd7fa090-ae09-4f0c-ad1f-a915b4dac2ec','fc29d113-af6a-4030-a1c9-5578f1649f87','147af21f-a01a-4590-bde7-08fc9c66f140','a628ee65-91a0-4f69-aa59-aff40cf6fcdb','518f7ff5-8fc3-4347-830e-dd06310a70ae','c0abb31b-555e-4d44-a53a-319e5f82311b','a7422dda-af0f-44b4-8ddf-2db11b15d37a','7891f7ce-74b6-462d-b14b-2649b8f4f9e1','ed765e6b-3d19-4d7d-a156-81b665b8019d','f7adbfd0-e010-47db-9046-908927598cc6','24e381f1-643f-46fe-b464-945b9db11590','afa81676-286d-43ea-8646-bd85628ffa08','68bfcc5f-24d2-4958-a8c0-e23d974be41d','390c73d9-a1d7-465f-b11f-73aa1aac8817','ff203ae8-651e-4a63-9c44-97488bb86826','58cd6711-a124-43a4-b415-101e0e6feaab','f23ed734-cecf-48e8-9a59-e447be7bbdf2','1154a587-6bc9-460c-b18e-2eaeec7f99b9','e9c3d251-20b0-4a96-b1c7-b40f92a5c1fc','0d6b0cb2-80d2-45b0-bb68-e247bafa5e8d','c395ae69-6fcd-4ed4-9334-ecb10bb3f387','c93a8fc3-6e4e-4642-a938-3d875314fa6a','db4dbcd0-af88-4042-9939-f6bb8effcd42','f6d42a16-fb7e-416b-901b-940fcf8f7371','4631b2b3-d0be-4ad9-b5b3-eea529c37542','3f22e401-649e-445e-83d0-ead7560eea88','5b9ea18f-54bb-4fcd-b277-dcf04e624043','9f35db26-07e0-43d5-ae11-1656e7547513','9252a729-0006-4f38-bd93-1427e2f43b47','f0893269-198a-474d-911f-bfc8cbd82071','8d8dedf5-2b20-485c-96d5-1de28aee7bbb','d12b4891-dad2-4b85-9c29-a41ec99a0f54','e462dc73-db72-4448-bb35-29d56f91af23','64f5a39c-58da-4dd5-a6bf-fe88906a44dd','f9c152ad-62aa-4a17-8421-ab10eacd2d43','196a45df-a266-4355-8321-934d1c843bf3','d6ea2f1f-1d32-494b-a0ef-1ca63332ce1a');

COMMIT;
