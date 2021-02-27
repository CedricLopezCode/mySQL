SHOW DATABASES;
CREATE DATABASE exo_2602_monde_spectacle;
USE exo_2602_monde_spectacle;
DROP TABLE Salle;

SHOW TABLES;

CREATE TABLE Salle (
	Salle_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(55) NOT NULL,
    Adresse VARCHAR(255) NOT NULL,
    Capacite INT
);
INSERT INTO Salle (nom, adresse,capacite) VALUES ("Zenith","bbb",1), ("Cygale","vvv",2), ("ddd","eee",5), ("fff","ggg",10), ("hhh","iii",3), ("jjj","kkk",3), ("lll","mmm",2);
SELECT * FROM Salle;
CREATE TABLE Spectacle (
	Spectacle_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Titre VARCHAR(50) NOT NULL,
    DateDeb DATETIME NOT NULL,
    Duree INT NOT NULL,
    Salle_ID INT NOT NULL,
    Chanteur VARCHAR(50) NOT NULL,
    CONSTRAINT cle_spec_salle FOREIGN KEY (Salle_ID) REFERENCES Salle(Salle_ID)
);
INSERT INTO Spectacle (Titre, DateDeb, Duree, Salle_ID, Chanteur) VALUES ("a", NOW(), 15, 44, "c3"), ("b", NOW(), 15, 9, "c4"),("c", NOW(), 15, 3, "c5"),("d", NOW(), 15, 5, "c1"),("e", NOW(), 15, 7, "c1");
SELECT * FROM Spectacle;
CREATE TABLE Concert (
	Concert_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Dates DATE NOT NULL,
    Heure DATETIME NOT NULL,
    Duree INT NOT NULL,
    Spectacle_ID INT NOT NULL,
    CONSTRAINT cle_conc_spec FOREIGN KEY (Spectacle_ID) REFERENCES Spectacle(Spectacle_ID)
);
INSERT INTO Concert (Dates, Heure,Duree,Spectacle_ID) VALUES (NOW(), NOW(),15,1),(NOW(), NOW(),15,2),(NOW(), NOW(),15,3),(NOW(), NOW(),15,1),(NOW(), NOW(),15,4)  ;
SELECT * FROM Concert;
CREATE TABLE Billet (
	Billet_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Concert_ID INT NOT NULL,
    Num_Place INT,
    Prix FLOAT,
    CONSTRAINT cle_billet_concert FOREIGN KEY (Concert_ID) REFERENCES Concert(Concert_ID)
);
INSERT INTO Billet (Concert_ID, Num_Place,Prix) VALUES (1, 22,42),(2, 22,42), (3, 22,42), (1, 22,42) ;
SELECT * FROM Billet;
CREATE TABLE Vente (
	Vente_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    Date_Vente DATETIME NOT NULL, 
	Billet_ID INT NOT NULL,
    MoyenPaiement VARCHAR(10),
    CONSTRAINT cle_vente_billet FOREIGN KEY (Billet_ID) REFERENCES Billet(Billet_ID)
);
INSERT INTO Vente (Date_Vente, Billet_ID,MoyenPaiement) VALUES (NOW(),1,"CB"), (NOW(),2,"CB"), (NOW(),3,"CB"), (NOW(),4,"CB"), (NOW(),5,"CB"), (NOW(),7,"CB");
SELECT * FROM Vente;

			# REQUETES
            
#1  Quelles sont les dates du concert de Corneille au Zenith
SELECT DateDeb FROM Spectacle 
WHERE Salle_ID IN(SELECT Salle_ID FROM Salle WHERE nom = "Zenith")
AND Chanteur LIKE "Corneille"
;
#2  Quels sont les noms des salles ayant la plus grande capacité ?
SELECT nom, capacite FROM Salle ORDER BY capacite DESC LIMIT 5;

#3  Quels sont les chanteurs n’ayant jamais réalisé de concert à la Cygale ? 
SELECT Chanteur FROM Spectacle
WHERE Chanteur NOT IN (
	SELECT Chanteur FROM Spectacle WHERE Salle_ID IN 
		(SELECT Salle_ID FROM Salle WHERE nom = "Cygale")
	GROUP BY Chanteur
) 
GROUP BY Chanteur
;
#3bis  Quels sont les chanteurs n’ayant jamais réalisé de concert à la Cygale ? 
SELECT * FROM Spectacle
WHERE 
	EXISTS (SELECT * FROM Salle WHERE nom = "Cygale") 
;
#3tri  inspiration internet  Quels sont les chanteurs n’ayant jamais réalisé de concert à la Cygale ? 
SELECT DISTINCT Chanteur FROM Spectacle
WHERE Chanteur NOT IN (
	SELECT Chanteur FROM Spectacle
	WHERE EXISTS (
		SELECT * FROM Salle
		WHERE Spectacle.Salle_ID = Salle.Salle_ID AND Salle.nom = "Cygale"
	)
);
#3 Correction Internet   Quels sont les chanteurs n’ayant jamais réalisé de concert à la Cygale ?
SELECT Chanteur FROM Spectacle t
WHERE /*Chanteur bug si on met*/ NOT EXISTS (
	SELECT * FROM Spectacle u, Salle v
	WHERE u.Salle_ID=v.Salle_ID	AND v.Nom='Cygale' AND t.CHanteur=u.Chanteur
);


#4 Quels sont les chanteurs ayant réalisé au moins un concert dans toutes les salles ? 
SELECT Chanteur FROM Spectacle 
HAVING COUNT(DISTINCT Salle_ID) IN(
	SELECT COUNT(*) FROM Salle
);
#4 Bis Quels sont les chanteurs ayant réalisé au moins un concert dans toutes les salles ? 
SELECT Chanteur FROM Spectacle 
WHERE NOT EXISTS()
 ;
#4 Corrections Internet
SELECT Chanteur FROM Spectacle t 
WHERE NOT EXISTS
(SELECT * FROM Salle u WHERE NOT EXISTS
	(SELECT * FROM Spectacle v
	WHERE v.Chanteur = t. Chanteur AND u.Salle_ID = v.Salle_ID
	)
)
#5 Quels sont les dates et les identificateurs des concerts pour lesquels il ne reste aucun billet invendu
SELECT Dates, Concert_ID FROM Concert WHERE Concert_ID IN(
	SELECT Concert_ID FROM Billet HAVING COUNT(Billet GROUP BY Concert_ID) =(
		SELECT capacite FROM Salle WHERE Salle_ID IN (
			SELECT Salle_ID FROM Spectacle WHERE Spectacle_ID IN (
				SELECT Spectacle_ID FROM Concert WHERE Concert_ID IN (
					SELECT DISTINCT Concert_ID FROM Billet
				)
			)
		)
	)
)
;
/*
Salle.Capacite = Concert_ID.nombre de billets vendus
nombre de billets vendus = COUNT(Billet GROUP BY Concert_ID)
Concert_ID donne Spectacle_ID donne Salle_ID
*/

	#FUNCTION COMPTER LES PLACES POSSIBLES D'UN CONCERT
SELECT capacite FROM Salle WHERE Salle_ID IN (
	SELECT Salle_ID FROM Spectacle WHERE Spectacle_ID IN (
		SELECT Spectacle_ID FROM Concert WHERE Concert_ID = Concert_ID
	)
)

	#FUNCTION COMPTER LES BILLETS VENDUS D'UN CONCERT
    SELECT  COUNT(Billet_ID) FROM Billet GROUP BY Concert_ID
	SELECT COUNT(*) FROM Billet WHERE Concert_ID = Concert_ID
    
    #MIX 
SELECT Dates, Concert_ID FROM Concert WHERE NOT EXISTS(
	SELECT * FROM Billet 
    WHERE Billet.Concert_ID = Concert.Concert_ID 
    AND NOT EXISTS (
		SELECT * FROM Vente 
        WHERE Vente.Billet_ID = Billet.Billet_ID
    )
)
;
SHOW TABLES;
SELECT * FROM Salle;
SELECT * FROM Spectacle;
SELECT * FROM Concert;
SELECT * FROM Billet;
SELECT * FROM Vente;



