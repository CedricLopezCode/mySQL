SHOW DATABASES;
CREATE DATABASE exo_2602;
USE exo_2602;

SHOW TABLES;

CREATE TABLE representation (
	num_rep INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
	titre_rep VARCHAR(50), 
	lieu TEXT
);
CREATE TABLE musicien (
	num_mus INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
	nom VARCHAR(30), 
	num_rep INT NOT NULL,
    CONSTRAINT fk_mus_rep FOREIGN KEY (num_rep)  REFERENCES representation(num_rep)
);
CREATE TABLE programme (
	date_rep DATETIME NOT NULL PRIMARY KEY, 
	num_rep  INT NOT NULL,
	tarif INT NOT NULL,
    CONSTRAINT fk_date_rep FOREIGN KEY (num_rep)  REFERENCES representation(num_rep)
);

SHOW TABLES;
SELECT * FROM representation;
SELECT * FROM musicien;
SELECT * FROM programme;

#Requetes SQL
#1		La liste des titres des représentations.
SELECT titre_rep FROM representation;
#2		La liste des titres des représentations ayant lieu au « théâtre JCC »
SELECT titre_rep FROM representation WHERE lieu like "theatre JCC";
#3		La liste des noms des musiciens et des titres et les titres des représentations auxquelles ils participent.
/*VERSION SIMPLE vue après:*/
SELECT nom, representation.titre_rep FROM musicien, representation
WHERE musicien.num_rep = representation.num_rep;


#4  	La liste des titres des représentations, les lieux et les tarifs du 28/02/2021.
SELECT titre_rep , lieu, tarif
FROM programme, representation 
WHERE num_rep IN(
	SELECT * FROM programme 
    WHERE date_rep = "2021/02/28")
;
#5		Le nombre des musiciens qui participent à la représentations n°15.
SELECT COUNT(DISTINCT num_mus) FROM representation WHERE num_rep = 15;
#6		Les représentations et leurs dates dont le tarif ne dépasse pas 30Euros.
SELECT titre_rep, date_rep FROM programme, representation 
WHERE tarif <=30 
AND programme.num_rep = representation.num_rep;
/*GENERIQUE
SELECT *
FROM table1
INNER JOIN table2 ON table1.id = table2.fk_id
OU
INNER JOIN table2
WHERE table1.id = table2.fk_id
*/

