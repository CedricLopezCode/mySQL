SHOW DATABASES;
CREATE DATABASE exo_avion;
use exo_avion;

CREATE TABLE avion (
	numAv INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nomAv VARCHAR(10),
    capacite INT NOT NULL DEFAULT 100,
    gps VARCHAR(20)
    );
CREATE TABLE pilote (
	nomPil VARCHAR(30),
    numPil INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    adresse VARCHAR(255),
    salaire INT
);
CREATE TABLE vol (
	numVol VARCHAR(6) PRIMARY KEY,
    numPil INT,
    numAv INT,
    ville_depart VARCHAR(20),
    ville_arrive VARCHAR(20),
    heure_depart DATETIME,
    heure_arrive DATETIME,
    CONSTRAINT cle_vol_pil FOREIGN KEY (numPil) REFERENCES pilote(numPil),
    CONSTRAINT cle_vol_av FOREIGN KEY (numAv) REFERENCES avion(numAv)
);

ALTER TABLE vol MODIFY numVol VARCHAR(6);
ALTER TABLE avion MODIFY numAv INT(6) ZEROFILL;
ALTER TABLE pilote MODIFY numPil INT(6) ZEROFILL;

DROP TABLE pilote;
	# Recommencer avec les bons
CREATE TABLE avion (
	numAv INT(6) ZEROFILL NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nomAv VARCHAR(10),
    capacite INT NOT NULL DEFAULT 100,
    gps VARCHAR(20)
);
CREATE TABLE pilote (
	nomPil VARCHAR(30),
    numPil INT(6) ZEROFILL NOT NULL AUTO_INCREMENT PRIMARY KEY,
    adresse VARCHAR(255),
    salaire INT
);
CREATE TABLE vol (
	numVol VARCHAR(6) PRIMARY KEY,
    numPil INT(6) ZEROFILL,
    numAv INT(6) ZEROFILL,
    ville_depart VARCHAR(20),
    ville_arrive VARCHAR(20),
    heure_depart DATETIME,
    heure_arrive DATETIME,
	CONSTRAINT cle_vol_pilq FOREIGN KEY (numPil) REFERENCES pilote(numPil),
	CONSTRAINT cle_vol_pilq FOREIGN KEY (numAv) REFERENCES avion(numAv)
);
ALTER TABLE vol ADD CONSTRAINT cle_vol_avbis FOREIGN KEY (numAv) REFERENCES avion(numAv);



SHOW TABLES;
SELECT * FROM avion;
SELECT * FROM pilote;
SELECT * FROM vol;

INSERT INTO avion(nomAv, capacite, gps) VALUES 
				("Alpha", 300, "Parvdis"),
				("Delta", 400, "dvs"),
				("Delta", 350, "Gre")
;
INSERT INTO pilote(nomPil, adresse, salaire) VALUES 
				("Moussa", "Cergy", 650000),
				("Afpa", "Marseille", 900000),
				("Cedric", "Grenoble", 750901),
				("Zack", "Paris", 350000)
;
/*DELETE FROM pilote WHERE numPil > 4;*/
INSERT INTO vol(numVol, numPil, numAv, ville_depart, ville_arrive, heure_depart, heure_arrive) VALUES 
				("f", 000001, 000001, "Paris", "NY", '2021-02-25 19:00:00','2021-02-25 17:00:00'),
				("Ut54", 000002, 000002, "Canada", "Londres", '2021-02-25 13:00:00','2021-02-25 22:00:00'),
				("LHt9", 000002, 000003, "Paris", "Tunis", '2021-02-25 11:00:00','2021-02-25 21:00:00')
;

#1
SELECT * FROM pilote;
#2
SELECT numPil, ville_depart FROM vol;
#3
SELECT * FROM avion WHERE capacite > 350;
#4
SELECT numAv, nomAv FROM avion WHERE gps = "Paris";
#5
SELECT  COUNT( DISTINCT gps) FROM avion;
#6
SELECT nomPil FROM pilote WHERE adresse like "Cergy" AND salaire > 500000;
#7
SELECT numAv, nomAv FROM avion WHERE gps like "Paris" OR capacite <= 350;
#8
SELECT * FROM vol WHERE  
	ville_depart like "Paris" AND
    ville_arrive like "NY" AND
    HOUR(heure_depart) > 18
;
#9
SELECT numPil FROM pilote WHERE numPil NOT IN(SELECT numPil FROM vol);
#10
SELECT numVol, ville_depart FROM vol WHERE vol.numPil IN (1,2); /*numPil = 1OR numPil = 2;*/
#11
SELECT * FROM pilote WHERE nomPil like "z%";
#12
SELECT * FROM pilote WHERE nomPil like "__c%";
#13

#14

#15



# CONSTRAINT nom_cle_etrangere FOREIGN KEY (colonne_dans_cette_table) REFERENCES table(colonne_qu_on_recupere)
#CREATE TABLE command (id, numerocommand, idClient INT, CONSTRAINT "nom_cle_etrangere" FOREIGN KEY (colonne_dans_cette_table) REFERENCES table(colonne_qu_on_recupere)  ))