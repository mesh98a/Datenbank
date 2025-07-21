-- Datenbanken Projekt

-- veranstaltungsort (id_ort, name, stadt, land, kapazitaet)
-- mannschaft (id_mannschaft, land, rang)
-- spiel (id_spiel, datum, zeit, fk_ort)
-- mannschaft_hat_spiel (fk_mannschaft, fk_spiel)
-- spieler (id_spieler, vorname, nachname, geburtsdatum, position, nummer, fk_mannschaft)
-- statistik (punkte, angriff, aufschlag, block, angrifffehler, aufschlagfehler, fk_spieler, fk_spiel)
-- trainer (id_trainer, vorname, nachname, geburtsdatum, fk_mannschaft)

-- Schema volleyball
CREATE SCHEMA IF NOT EXISTS volleyball;

-- Set search path to the schema
SET search_path TO volleyball;

-- Table: Veranstaltungsort
CREATE TABLE IF NOT EXISTS Veranstaltungsort (
    id_Ort SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Stadt VARCHAR(45),
    Land VARCHAR(45),
    Kapazitaet INT
);

-- Table: Mannschaft
CREATE TABLE IF NOT EXISTS Mannschaft (
    id_Mannschaft SERIAL PRIMARY KEY,
    Land VARCHAR(45),
    Rang INT
);

-- Table: Spiel
CREATE TABLE IF NOT EXISTS Spiel (
    id_Spiel SERIAL PRIMARY KEY,
    Datum DATE,
    Zeit TIME,
    fk_Ort INT,
    CONSTRAINT fkSpielVeranstaltungsort FOREIGN KEY (fk_Ort)
        REFERENCES Veranstaltungsort (id_Ort)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

-- Table: Mannschaft_hat_Spiel
CREATE TABLE IF NOT EXISTS Mannschaft_hat_Spiel (
    fk_Mannschaft INT,
    fk_Spiel INT,
    PRIMARY KEY (fk_Mannschaft, fk_Spiel),
    CONSTRAINT fkMannschaft_hat_SpielMannschaft FOREIGN KEY (fk_Mannschaft)
        REFERENCES Mannschaft (id_Mannschaft)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fkMannschaft_hat_SpielSpiel FOREIGN KEY (fk_Spiel)
        REFERENCES Spiel (id_Spiel)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

-- Table: Spieler
CREATE TABLE IF NOT EXISTS Spieler (
    id_Spieler SERIAL PRIMARY KEY,
    Vorname VARCHAR(45),
    Nachname VARCHAR(45),
    Geburtsdatum DATE,
    Position VARCHAR(45),
    Nummer INT,
    fk_Mannschaft INT,
    CONSTRAINT fkSpielerMannschaft FOREIGN KEY (fk_Mannschaft)
        REFERENCES Mannschaft (id_Mannschaft)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

-- Table: Statistik
CREATE TABLE IF NOT EXISTS Statistik (
    Punkte INT,
    Angriff INT,
    Aufschlag INT,
    Block INT,
    Angrifffehler INT,
    Aufschlagfehler INT,
    fk_Spieler INT,
    fk_Spiel INT,
    PRIMARY KEY (fk_Spieler, fk_Spiel),
    CONSTRAINT fkStatistikSpieler FOREIGN KEY (fk_Spieler)
        REFERENCES Spieler (id_Spieler)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fkStatistikSpiel FOREIGN KEY (fk_Spiel)
        REFERENCES Spiel (id_Spiel)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

-- Table: Trainer
CREATE TABLE IF NOT EXISTS Trainer (
    id_Trainer SERIAL PRIMARY KEY,
    Vorname VARCHAR(45),
    Nachname VARCHAR(45),
    Geburtsdatum DATE,
    Nationalitaet VARCHAR(45),
    fk_Mannschaft INT,
    CONSTRAINT fkTrainerMannschaft FOREIGN KEY (fk_Mannschaft)
        REFERENCES Mannschaft (id_Mannschaft)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);
