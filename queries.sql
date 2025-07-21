set search_path to volleyball;
/*Spielplam ansehen*/
select 
    s.Datum,
    v.stadt,
    m1.land AS Team1,
    m2.land AS Team2
from  spiel s
	join veranstaltungsort v on id_spiel=id_ort
	join mannschaft_hat_spiel h1  on h1.fk_spiel=id_spiel
	join mannschaft_hat_spiel h2  on h2.fk_spiel=id_spiel
	join mannschaft m1 on m1.id_mannschaft=h1.fk_mannschaft
	join mannschaft m2 on m2.id_mannschaft=h2.fk_mannschaft and m1.id_mannschaft != m2.id_mannschaft  
WHERE m1.land='Italy'
ORDER BY s.datum;
--spieler mit mehr als 20 Angriffspunkte;
SELECT 
    sp.Vorname AS Spieler_Vorname,
    sp.Nachname AS Spieler_Nachname,
	COUNT(s.fk_spiel) AS Anzahl_der_Spiele,
    SUM(s.Punkte) AS Gesamt_Punkte,
    SUM(s.Angriff) AS Gesamter_Angriff,
    SUM(s.Aufschlag) AS Gesamter_Aufschlag,
    SUM(s.Block) AS Gesamter_Block
FROM 
    statistik s
INNER JOIN 
    Spieler sp ON sp.id_spieler = s.fk_spieler
INNER JOIN
    spiel ON spiel.id_spiel = s.fk_spiel
GROUP BY 
    sp.Vorname, sp.Nachname
HAVING 
	SUM(s.angriff) > 20
ORDER BY 
	Gesamt_Punkte desc;
-- Trainer der Top 10 Mannschaften
SELECT t.id_trainer,t.vorname || ' ' || t.nachname AS name,t.nationalitaet, m.land,m.rang
FROM 
	trainer t
JOIN 
	mannschaft m ON t.fk_mannschaft=m.id_mannschaft
WHERE rang <= 10
ORDER BY rang;
-- Welche Hallen in 2022, 2023 und 2024 hatten eine Kapazitaet ueber 10000?
SELECT name, kapazitaet,*spiel
FROM spiel
JOIN veranstaltungsort ON fk_ort=id_ort
WHERE extract(year from datum)=2022
    OR extract(year from datum)=2023
    OR extract(year from datum)=2024
GROUP BY name, kapazitaet 
HAVING kapazitaet>=10000;


