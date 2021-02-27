#4 Quels sont les chanteurs ayant réalisé au moins un concert dans toutes les salles ? 
SELECT Chanteur FROM Spectacle4 
HAVING COUNT(DISTINCT Salle_ID) IN(
	SELECT COUNT(*) FROM Salle4
);
#4 Bis Quels sont les chanteurs ayant réalisé au moins un concert dans toutes les salles ? 
SELECT Chanteur FROM Spectacle4 
WHERE EXISTS(
	SELECT COUNT(*) FROM Salle4 
)
 ;
 #4tri  Quels sont les chanteurs ayant réalisé au moins un concert dans toutes les salles ? 
SELECT * FROM Spectacle4 ext 
WHERE EXISTS(
	SELECT * FROM Salle4 sal 
	WHERE NOT EXISTS(
		SELECT * FROM Spectacle4 inte
		WHERE inte.Chanteur = ext.Chanteur AND sal.Salle_ID = inte.Salle_ID
	)
);
SELECT * FROM Salle4 sal 
WHERE NOT EXISTS(
	SELECT * FROM Spectacle4 inte
	WHERE Salle4.Salle_ID = Spectacle4.Salle_ID
);
SELECT * FROM Spectacle4 inte WHERE 1 = inte.Salle_ID;
 #4qua  Quels sont les chanteurs ayant réalisé au moins un concert dans toutes les salles ? 
 
#4 Corrections Internet
SELECT Chanteur FROM Spectacle t 
WHERE NOT EXISTS(
	SELECT * FROM Salle u WHERE NOT EXISTS(
		SELECT * FROM Spectacle v
		WHERE v.Chanteur = t. Chanteur AND u.Salle_ID = v.Salle_ID
	)
);
  #MIX 

SELECT Dates, Concert_ID FROM Concert WHERE NOT EXISTS(
	SELECT * FROM Billet 
    WHERE Billet.Concert_ID = Concert.Concert_ID 
    AND NOT EXISTS (
		SELECT * FROM Vente 
        WHERE Vente.Billet_ID = Billet.Billet_ID
    )
);

SELECT * FROM Billet 
WHERE NOT EXISTS (
	SELECT * FROM Vente 
	WHERE Vente.Billet_ID = Billet.Billet_ID
);
SHOW TABLES;
SELECT * FROM Salle;
SELECT * FROM Spectacle;
SELECT * FROM Concert;
SELECT * FROM Billet;
SELECT * FROM Vente;

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