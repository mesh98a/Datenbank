CREATE USER admin_user WITH PASSWORD 'admin_password';
CREATE USER trainer_user WITH PASSWORD 'trainer_password';
CREATE USER normal_user WITH PASSWORD 'user_password';

GRANT ALL PRIVILEGES ON DATABASE volleyball_db TO admin_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA volleyball TO admin_user;

-- Trainer darf nur die Spieler-Tabelle ändern
GRANT SELECT, UPDATE ON spieler TO trainer_user;
GRANT SELECT ON mannschaftTO trainer_user;
GRANT SELECT ON spiel TO trainer_user;
GRANT SELECT ON statistik TO trainer_user;
GRANT SELECT ON veranstaltungsort TO trainer_user;
GRANT SELECT ON trainer TO trainer_user;

-- Normaler Nutzer darf nur die Spieler und Teams lesen
GRANT SELECT ON ALL TABLES IN SCHEMA volleyball TO normal_user;





