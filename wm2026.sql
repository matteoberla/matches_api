# SQL Inserimento Squadre e Partite (Fase a Gironi)


-- =========================
-- INSERIMENTO SQUADRE
-- =========================

INSERT INTO teams (name, iso, girone, breve) VALUES ('Messico', 'MX', 'A', 'MEX');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Sudafrica', 'ZA', 'A', 'RSA');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Corea del Sud', 'KR', 'A', 'KOR');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Repubblica Ceca', 'CZ', 'A', 'CZE');

INSERT INTO teams (name, iso, girone, breve) VALUES ('Canada', 'CA', 'B', 'CAN');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Qatar', 'QA', 'B', 'QAT');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Svizzera', 'CH', 'B', 'SUI');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Bosnia', 'BA', 'B', 'BIH');

INSERT INTO teams (name, iso, girone, breve) VALUES ('Brasile', 'BR', 'C', 'BRA');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Marocco', 'MA', 'C', 'MAR');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Haiti', 'HT', 'C', 'HAI');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Scozia', 'GB', 'C', 'SCO');

INSERT INTO teams (name, iso, girone, breve) VALUES ('Usa', 'US', 'D', 'USA');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Paraguay', 'PY', 'D', 'PAR');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Australia', 'AU', 'D', 'AUS');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Turchia', 'TR', 'D', 'TUR');

INSERT INTO teams (name, iso, girone, breve) VALUES ('Germania', 'DE', 'E', 'GER');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Curacao', 'CW', 'E', 'CUW');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Costa d''Avorio', 'CI', 'E', 'CIV');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Ecuador', 'EC', 'E', 'ECU');

INSERT INTO teams (name, iso, girone, breve) VALUES ('Olanda', 'NL', 'F', 'NED');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Giappone', 'JP', 'F', 'JPN');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Svezia', 'SE', 'F', 'SWE');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Tunisia', 'TN', 'F', 'TUN');

INSERT INTO teams (name, iso, girone, breve) VALUES ('Belgio', 'BE', 'G', 'BEL');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Egitto', 'EG', 'G', 'EGY');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Iran', 'IR', 'G', 'IRN');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Nuova Zelanda', 'NZ', 'G', 'NZL');

INSERT INTO teams (name, iso, girone, breve) VALUES ('Spagna', 'ES', 'H', 'ESP');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Capo Verde', 'CV', 'H', 'CPV');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Arabia Saudita', 'SA', 'H', 'KSA');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Uruguay', 'UY', 'H', 'URU');

INSERT INTO teams (name, iso, girone, breve) VALUES ('Francia', 'FR', 'I', 'FRA');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Senegal', 'SN', 'I', 'SEN');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Iraq', 'IQ', 'I', 'IRQ');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Norvegia', 'NO', 'I', 'NOR');

INSERT INTO teams (name, iso, girone, breve) VALUES ('Argentina', 'AR', 'J', 'ARG');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Algeria', 'DZ', 'J', 'ALG');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Austria', 'AT', 'J', 'AUT');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Giordania', 'JO', 'J', 'JOR');

INSERT INTO teams (name, iso, girone, breve) VALUES ('Portogallo', 'PT', 'K', 'POR');
INSERT INTO teams (name, iso, girone, breve) VALUES ('RD Congo', 'CD', 'K', 'COD');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Uzbekistan', 'UZ', 'K', 'UZB');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Colombia', 'CO', 'K', 'COL');

INSERT INTO teams (name, iso, girone, breve) VALUES ('Inghilterra', 'GB', 'L', 'ENG');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Croazia', 'HR', 'L', 'CRO');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Ghana', 'GH', 'L', 'GHA');
INSERT INTO teams (name, iso, girone, breve) VALUES ('Panama', 'PA', 'L', 'PAN');


-- =========================
-- INSERIMENTO PARTITE
-- =========================
-- Struttura:
-- INSERT INTO matches (date, id_team_1, id_team_2, fase)
-- VALUES ('YYYY-MM-DD HH:MM:SS',
--         (SELECT id FROM teams WHERE breve='XXX'),
--         (SELECT id FROM teams WHERE breve='YYY'),
--         1);

-- GRUPPO A
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-11 21:00:00',(SELECT id FROM teams WHERE breve='MEX'),(SELECT id FROM teams WHERE breve='RSA'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-12 04:00:00',(SELECT id FROM teams WHERE breve='KOR'),(SELECT id FROM teams WHERE breve='CZE'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-18 18:00:00',(SELECT id FROM teams WHERE breve='CZE'),(SELECT id FROM teams WHERE breve='RSA'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-19 03:00:00',(SELECT id FROM teams WHERE breve='MEX'),(SELECT id FROM teams WHERE breve='KOR'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-25 03:00:00',(SELECT id FROM teams WHERE breve='RSA'),(SELECT id FROM teams WHERE breve='KOR'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-25 03:00:00',(SELECT id FROM teams WHERE breve='CZE'),(SELECT id FROM teams WHERE breve='MEX'),1);

-- GRUPPO B
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-12 21:00:00',(SELECT id FROM teams WHERE breve='CAN'),(SELECT id FROM teams WHERE breve='BIH'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-13 21:00:00',(SELECT id FROM teams WHERE breve='SUI'),(SELECT id FROM teams WHERE breve='QAT'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-18 21:00:00',(SELECT id FROM teams WHERE breve='SUI'),(SELECT id FROM teams WHERE breve='BIH'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-20 00:00:00',(SELECT id FROM teams WHERE breve='CAN'),(SELECT id FROM teams WHERE breve='QAT'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-24 21:00:00',(SELECT id FROM teams WHERE breve='SUI'),(SELECT id FROM teams WHERE breve='CAN'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-24 21:00:00',(SELECT id FROM teams WHERE breve='BIH'),(SELECT id FROM teams WHERE breve='QAT'),1);

-- GRUPPO C
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-15 00:00:00',(SELECT id FROM teams WHERE breve='BRA'),(SELECT id FROM teams WHERE breve='MAR'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-14 03:00:00',(SELECT id FROM teams WHERE breve='HAI'),(SELECT id FROM teams WHERE breve='SCO'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-21 00:00:00',(SELECT id FROM teams WHERE breve='SCO'),(SELECT id FROM teams WHERE breve='MAR'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-20 03:00:00',(SELECT id FROM teams WHERE breve='BRA'),(SELECT id FROM teams WHERE breve='HAI'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-26 00:00:00',(SELECT id FROM teams WHERE breve='MAR'),(SELECT id FROM teams WHERE breve='HAI'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-26 00:00:00',(SELECT id FROM teams WHERE breve='SCO'),(SELECT id FROM teams WHERE breve='BRA'),1);

-- GRUPPO D
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-13 03:00:00',(SELECT id FROM teams WHERE breve='USA'),(SELECT id FROM teams WHERE breve='PAR'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-13 06:00:00',(SELECT id FROM teams WHERE breve='AUS'),(SELECT id FROM teams WHERE breve='TUR'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-19 06:00:00',(SELECT id FROM teams WHERE breve='TUR'),(SELECT id FROM teams WHERE breve='PAR'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-19 21:00:00',(SELECT id FROM teams WHERE breve='USA'),(SELECT id FROM teams WHERE breve='AUS'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-26 04:00:00',(SELECT id FROM teams WHERE breve='TUR'),(SELECT id FROM teams WHERE breve='USA'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-26 04:00:00',(SELECT id FROM teams WHERE breve='PAR'),(SELECT id FROM teams WHERE breve='AUS'),1);

-- GRUPPO E
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-14 19:00:00',(SELECT id FROM teams WHERE breve='GER'),(SELECT id FROM teams WHERE breve='CUW'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-14 22:00:00',(SELECT id FROM teams WHERE breve='CIV'),(SELECT id FROM teams WHERE breve='ECU'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-20 22:00:00',(SELECT id FROM teams WHERE breve='GER'),(SELECT id FROM teams WHERE breve='CIV'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-21 02:00:00',(SELECT id FROM teams WHERE breve='ECU'),(SELECT id FROM teams WHERE breve='CUW'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-25 22:00:00',(SELECT id FROM teams WHERE breve='CUW'),(SELECT id FROM teams WHERE breve='CIV'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-25 22:00:00',(SELECT id FROM teams WHERE breve='ECU'),(SELECT id FROM teams WHERE breve='GER'),1);

-- GRUPPO F
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-14 22:00:00',(SELECT id FROM teams WHERE breve='NED'),(SELECT id FROM teams WHERE breve='JPN'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-15 04:00:00',(SELECT id FROM teams WHERE breve='SWE'),(SELECT id FROM teams WHERE breve='TUN'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-20 06:00:00',(SELECT id FROM teams WHERE breve='TUN'),(SELECT id FROM teams WHERE breve='JPN'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-20 19:00:00',(SELECT id FROM teams WHERE breve='NED'),(SELECT id FROM teams WHERE breve='SWE'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-26 01:00:00',(SELECT id FROM teams WHERE breve='TUN'),(SELECT id FROM teams WHERE breve='NED'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-26 01:00:00',(SELECT id FROM teams WHERE breve='JPN'),(SELECT id FROM teams WHERE breve='SWE'),1);

-- GRUPPO G
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-15 21:00:00',(SELECT id FROM teams WHERE breve='BEL'),(SELECT id FROM teams WHERE breve='EGY'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-16 03:00:00',(SELECT id FROM teams WHERE breve='IRN'),(SELECT id FROM teams WHERE breve='NZL'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-21 21:00:00',(SELECT id FROM teams WHERE breve='BEL'),(SELECT id FROM teams WHERE breve='IRN'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-22 03:00:00',(SELECT id FROM teams WHERE breve='NZL'),(SELECT id FROM teams WHERE breve='EGY'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-27 05:00:00',(SELECT id FROM teams WHERE breve='NZL'),(SELECT id FROM teams WHERE breve='BEL'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-27 05:00:00',(SELECT id FROM teams WHERE breve='EGY'),(SELECT id FROM teams WHERE breve='IRN'),1);

-- GRUPPO H
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-15 18:00:00',(SELECT id FROM teams WHERE breve='ESP'),(SELECT id FROM teams WHERE breve='CPV'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-17 00:00:00',(SELECT id FROM teams WHERE breve='KSA'),(SELECT id FROM teams WHERE breve='URU'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-21 18:00:00',(SELECT id FROM teams WHERE breve='ESP'),(SELECT id FROM teams WHERE breve='KSA'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-23 00:00:00',(SELECT id FROM teams WHERE breve='URU'),(SELECT id FROM teams WHERE breve='CPV'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-27 02:00:00',(SELECT id FROM teams WHERE breve='CPV'),(SELECT id FROM teams WHERE breve='KSA'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-27 02:00:00',(SELECT id FROM teams WHERE breve='URU'),(SELECT id FROM teams WHERE breve='ESP'),1);

-- GRUPPO I
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-16 21:00:00',(SELECT id FROM teams WHERE breve='FRA'),(SELECT id FROM teams WHERE breve='SEN'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-18 00:00:00',(SELECT id FROM teams WHERE breve='IRQ'),(SELECT id FROM teams WHERE breve='NOR'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-22 23:00:00',(SELECT id FROM teams WHERE breve='FRA'),(SELECT id FROM teams WHERE breve='IRQ'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-23 02:00:00',(SELECT id FROM teams WHERE breve='NOR'),(SELECT id FROM teams WHERE breve='SEN'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-26 21:00:00',(SELECT id FROM teams WHERE breve='NOR'),(SELECT id FROM teams WHERE breve='FRA'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-26 21:00:00',(SELECT id FROM teams WHERE breve='SEN'),(SELECT id FROM teams WHERE breve='IRQ'),1);

-- GRUPPO J
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-16 06:00:00',(SELECT id FROM teams WHERE breve='AUT'),(SELECT id FROM teams WHERE breve='JOR'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-17 03:00:00',(SELECT id FROM teams WHERE breve='ARG'),(SELECT id FROM teams WHERE breve='ALG'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-22 19:00:00',(SELECT id FROM teams WHERE breve='ARG'),(SELECT id FROM teams WHERE breve='AUT'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-23 05:00:00',(SELECT id FROM teams WHERE breve='JOR'),(SELECT id FROM teams WHERE breve='ALG'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-28 04:00:00',(SELECT id FROM teams WHERE breve='ALG'),(SELECT id FROM teams WHERE breve='AUT'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-28 04:00:00',(SELECT id FROM teams WHERE breve='JOR'),(SELECT id FROM teams WHERE breve='ARG'),1);

-- GRUPPO K
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-17 19:00:00',(SELECT id FROM teams WHERE breve='POR'),(SELECT id FROM teams WHERE breve='COD'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-18 04:00:00',(SELECT id FROM teams WHERE breve='UZB'),(SELECT id FROM teams WHERE breve='COL'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-23 19:00:00',(SELECT id FROM teams WHERE breve='POR'),(SELECT id FROM teams WHERE breve='UZB'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-24 04:00:00',(SELECT id FROM teams WHERE breve='COL'),(SELECT id FROM teams WHERE breve='COD'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-28 01:30:00',(SELECT id FROM teams WHERE breve='COL'),(SELECT id FROM teams WHERE breve='POR'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-28 01:30:00',(SELECT id FROM teams WHERE breve='COD'),(SELECT id FROM teams WHERE breve='UZB'),1);

-- GRUPPO L
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-17 22:00:00',(SELECT id FROM teams WHERE breve='ENG'),(SELECT id FROM teams WHERE breve='CRO'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-18 01:00:00',(SELECT id FROM teams WHERE breve='GHA'),(SELECT id FROM teams WHERE breve='PAN'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-23 22:00:00',(SELECT id FROM teams WHERE breve='ENG'),(SELECT id FROM teams WHERE breve='GHA'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-24 01:00:00',(SELECT id FROM teams WHERE breve='PAN'),(SELECT id FROM teams WHERE breve='CRO'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-27 23:00:00',(SELECT id FROM teams WHERE breve='PAN'),(SELECT id FROM teams WHERE breve='ENG'),1);
INSERT INTO matches (date, id_team_1, id_team_2, fase) VALUES ('2026-06-27 23:00:00',(SELECT id FROM teams WHERE breve='CRO'),(SELECT id FROM teams WHERE breve='GHA'),1);

