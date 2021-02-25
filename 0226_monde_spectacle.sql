SHOW DATABASES;
CREATE DATABASE exo_2602_monde_spectacle;
USE exo_2602_monde_spectacle;

SHOW TABLES;

CREATE TABLE Salle (
	Salle_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(55) NOT NULL,
    Adresse VARCHAR(255) NOT NULL,
    Capacite INT
);
CREATE TABLE Spectacle (
	Spectacle_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Titre VARCHAR(50) NOT NULL,
    DateDeb DATETIME NOT NULL,
    Duree INT NOT NULL,
    Salle_ID INT NOT NULL,
    Chanteur VARCHAR(50) NOT NULL,
    CONSTRAINT cle_spec_salle FOREIGN KEY (Salle_ID) REFERENCES Salle(Salle_ID)
);
CREATE TABLE Concert (
	Concert_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Dates DATE NOT NULL,
    Heure DATETIME NOT NULL,
    Duree INT NOT NULL,
    Spectacle_ID INT NOT NULL,
    CONSTRAINT cle_conc_spec FOREIGN KEY (Spectacle_ID) REFERENCES Spectacle(Spectacle_ID)
);
CREATE TABLE Billet (
	Billet_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Concert_ID INT NOT NULL,
    Num_Place INT,
    Prix FLOAT,
    CONSTRAINT cle_billet_concert FOREIGN KEY (Concert_ID) REFERENCES Concert(Concert_ID)
);
CREATE TABLE Vente (
	Vente_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    Date_Vente DATETIME NOT NULL, 
	Billet_ID INT NOT NULL,
    MoyenPaiement VARCHAR(10),
    CONSTRAINT cle_vente_billet FOREIGN KEY (Billet_ID) REFERENCES Billet(Billet_ID)
);

#1
SELECT DateDeb FROM Spectacle 
	WHERE Salle_ID IN(SELECT * FROM Salle WHERE nom = "Zenith" )
	HAVING Chanteur LIKE "Corneille"
;
#2
SELECT nom FROM Salle ORDER BY capacite LIMIT 5;
#3
SELECT Chanteur FROM Spectacle WHERE ;
#4

#5

#6
3. Quels sont les chanteurs n’ayant jamais réalisé de concert à la Cygale ? 
4. Quels sont les chanteurs ayant réalisé au moins un concert dans toutes les salles ? 
5. Quels sont les dates et les identificateurs des concerts pour lesquels il ne reste aucun billet invendu

