SHOW DATABASES;
CREATE DATABASE exo_2602_monde_spectacle;
USE exo_2602_monde_spectacle;
DROP TABLE Salle;

SHOW TABLES;

CREATE TABLE Salle (
	Salle_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(55) NOT NULL,
    Adresse VARCHAR(255) NOT NULL,
    capacite INT
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
    Heure TIME NOT NULL,
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
SELECT nom, capacite FROM Salle WHERE capacite = MAX(capacite);
SELECT nom, capacite FROM Salle HAVING MAX(capacite);
#2bis  Quels sont les noms des salles ayant la plus grande capacité ?
SELECT nom, capacite FROM Salle 
WHERE capacite IN(
	SELECT MAX(capacite) FROM Salle
)
;
#3  Quels sont les chanteurs n’ayant jamais réalisé de concert à la Cygale ? 
SELECT Chanteur FROM Spectacle
WHERE Chanteur NOT IN (
	SELECT Chanteur FROM Spectacle WHERE Salle_ID IN 
		(SELECT Salle_ID FROM Salle WHERE nom = "Cygale")
	GROUP BY Chanteur
) 
GROUP BY Chanteur
;
#3bis inspiration internet  Quels sont les chanteurs n’ayant jamais réalisé de concert à la Cygale ? 
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

/* POUR TESTER POUR LA 4 SANS DERANGER LE RESTE

CREATE TABLE Salle4 (
	Salle_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(55) NOT NULL,
    Adresse VARCHAR(255) NOT NULL,
    Capacite INT
);
INSERT INTO Salle4 (nom, adresse,capacite) VALUES ("aaa","bbb",10), ("ccc","vvv",20),  ("lll","mmm",20);
SELECT * FROM Salle4;
CREATE TABLE Spectacle4 (
	Spectacle_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Titre VARCHAR(50) NOT NULL,
    DateDeb DATETIME NOT NULL,
    Duree INT NOT NULL,
    Salle_ID INT NOT NULL,
    Chanteur VARCHAR(50) NOT NULL,
    CONSTRAINT cle_spec_salle4 FOREIGN KEY (Salle_ID) REFERENCES Salle4(Salle_ID)
);
INSERT INTO Spectacle4 (Titre, DateDeb, Duree, Salle_ID, Chanteur) VALUES ("a", NOW(), 15, 1, "TouteSale"), ("b", NOW(), 15, 2, "TouteSale"),("c", NOW(), 15, 3, "TouteSale"),("d", NOW(), 15, 1, "2Salles"),("e", NOW(), 15, 2, "2Salles");
SELECT * FROM Spectacle4;
CREATE TABLE Concert4 (
	Concert_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Dates DATE NOT NULL,
    Heure DATETIME NOT NULL,
    Duree INT NOT NULL,
    Spectacle_ID INT NOT NULL,
    CONSTRAINT cle_conc_spec4 FOREIGN KEY (Spectacle_ID) REFERENCES Spectacle4(Spectacle_ID)
);
INSERT INTO Concert4 (Dates, Heure,Duree,Spectacle_ID) VALUES (NOW(), NOW(),15,1),(NOW(), NOW(),15,2),(NOW(), NOW(),15,3),(NOW(), NOW(),15,1),(NOW(), NOW(),15,4)  ;
SELECT * FROM Concert4;
CREATE TABLE Billet4 (
	Billet_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Concert_ID INT NOT NULL,
    Num_Place INT,
    Prix FLOAT,
    CONSTRAINT cle_billet_concert4 FOREIGN KEY (Concert_ID) REFERENCES Concert4(Concert_ID)
);
INSERT INTO Billet4 (Concert_ID, Num_Place,Prix) VALUES (1, 22,42),(2, 22,42), (3, 22,42), (1, 22,42) ;
SELECT * FROM Billet4;
CREATE TABLE Vente4 (
	Vente_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    Date_Vente DATETIME NOT NULL, 
	Billet_ID INT NOT NULL,
    MoyenPaiement VARCHAR(10),
    CONSTRAINT cle_vente_billet4 FOREIGN KEY (Billet_ID) REFERENCES Billet4(Billet_ID)
);
INSERT INTO Vente4 (Date_Vente, Billet_ID,MoyenPaiement) VALUES (NOW(),1,"CB"), (NOW(),2,"CB"), (NOW(),3,"CB"), (NOW(),4,"CB"), (NOW(),5,"CB"), (NOW(),7,"CB");
SELECT * FROM Vente4;
*/

#4 Quels sont les chanteurs ayant réalisé au moins un concert dans toutes les salles ? 
SELECT Chanteur FROM Spectacle 
HAVING COUNT(DISTINCT Salle_ID) IN(
	SELECT COUNT(*) FROM Salle
);
#4 Bis Quels sont les chanteurs ayant réalisé au moins un concert dans toutes les salles ? 
SELECT Chanteur FROM Spectacle, Salle
WHERE Chanteur = ALL(
	SELECT Chanteur FROM Spectacle
    WHERE  Salle.Salle_ID = Spectacle.Salle_ID
)
GROUP BY Chanteur
;
#Presque comme Correction
SELECT Chanteur, Salle_ID, Spectacle_ID FROM Spectacle4
WHERE NOT EXISTS (  # Liste chanteur toutes salle
	SELECT Salle_ID FROM Salle4 # un id de salle....
    WHERE Spectacle4.Salle_ID =  Salle4.Salle_ID
    AND NOT EXISTS( #... sans ce chanteur
		SELECT SALLE_ID FROM Spectacle4
        WHERE 1 = 1
    )
)
;
#4 Corrections Moussa
SELECT Chanteur FROM Spectacle as spect
WHERE NOT EXISTS(
	SELECT * FROM Salle as sa WHERE NOT EXISTS(
		SELECT * FROM Spectacle as sp
		WHERE sp.Chanteur = spect.Chanteur 
        AND sa.Salle_ID = sp.Salle_ID
	)
);
#4 Corrections Internet
SELECT Chanteur FROM Spectacle t 
WHERE NOT EXISTS
(SELECT * FROM Salle u WHERE NOT EXISTS
	(SELECT * FROM Spectacle v
	WHERE v.Chanteur = t. Chanteur AND u.Salle_ID = v.Salle_ID
	)
);


#--------------------------------------------------------------
#5 Quels sont les dates et les identificateurs des concerts pour lesquels il ne reste aucun billet invendu
 # Probleme integration COUNT
SELECT Dates, Concert_ID FROM Concert WHERE Concert_ID IN(
	SELECT Concert_ID FROM Billet HAVING COUNT(Billet GROUP BY Concert_ID) = ( # Probleme integration COUNT
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
#5 Quels sont les dates et les identificateurs des concerts pour lesquels il ne reste aucun billet invendu
SELECT Dates, Concert_ID FROM Concert
WHERE NOT EXISTS (# Correspondance avec billets invendu
	SELECT * FROM Billet # == Liste des billets invendu
	WHERE NOT EXISTS (  # Pas de correspondance avec VENTE == Selection Billets invendus
		SELECT * FROM Vente # == Liste des Vente
		WHERE Vente.Billet_ID = Billet.Billet_ID # == Billets vendus
	)
    AND Billet.Concert_ID = Concert.Concert_ID #Correspondance des Concert ID
);
#5 Avec Moussa   Quels sont les dates et les identificateurs des concerts pour lesquels il ne reste aucun billet invendu
SELECT Dates, Concert_ID FROM Concert 
WHERE NOT EXISTS(
	SELECT * FROM Billet 
    WHERE Billet.Concert_ID = Concert.Concert_ID 
    AND NOT EXISTS (
		SELECT * FROM Vente 
        WHERE Vente.Billet_ID = Billet.Billet_ID
    )
);

#5 Correction Internet   Quels sont les dates et les identificateurs des concerts pour lesquels il ne reste aucun billet invendu
SELECT Concert_ID, Dates FROM Concert t
WHERE NOT EXISTS (
	SELECT * FROM Billet u
	WHERE u.Concert_ID = t.Concert_ID
	AND NOT EXISTS(
		SELECT * FROM Vente v
		WHERE u.Billet_ID = v.Billet_ID
	)
)
;
/*
SELECT * FROM Billet # == Liste des billets invendu
WHERE NOT EXISTS (  # Pas de correspondance avec VENTE == Selection Billets invendus
	SELECT * FROM Vente # == Liste des Vente
	WHERE Vente.Billet_ID = Billet.Billet_ID # == Billets vendus
);
*/
/*
Salle.Capacite = Concert_ID.nombre de billets vendus
nombre de billets vendus = COUNT(Billet GROUP BY Concert_ID)
Concert_ID donne Spectacle_ID donne Salle_ID
*/
/*
	#FUNCTION COMPTER LES PLACES POSSIBLES D'UN CONCERT
SELECT capacite FROM Salle WHERE Salle_ID IN (
	SELECT Salle_ID FROM Spectacle WHERE Spectacle_ID IN (
		SELECT Spectacle_ID FROM Concert WHERE Concert_ID = Concert_ID
	)
);
	#FUNCTION COMPTER LES BILLETS VENDUS D'UN CONCERT
    SELECT  COUNT(Billet_ID) FROM Billet GROUP BY Concert_ID;
	SELECT COUNT(*) FROM Billet WHERE Concert_ID = Concert_ID;
*/    

SHOW TABLES;
SELECT * FROM Salle;
SELECT * FROM Spectacle;
SELECT * FROM Concert;
SELECT * FROM Billet;
SELECT * FROM Vente;



