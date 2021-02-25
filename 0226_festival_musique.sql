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
#1
SELECT titre_rep FROM representation;
#2
SELECT titre_rep FROM representation WHERE lieu like "theatre JCC";
#3
/*VERSION SIMPLE vue après:*/
SELECT musicien.nom, representation.titre_rep WHERE musicien.num_rep = representation.num_rep;

SELECT 
	nom, titre_rep 
	FROM musicien/*INNER facultatif dans ce cas*/ JOIN representation 
	WHERE/*ON*/ musicien.num_rep = representation.num_rep
;

#4
SELECT 
	representation.titre_rep , lieu, tarif
    FROM programme 
    WHERE num_rep IN(SELECT * FROM programme WHERE date_rep = "2021/02/28")
;
SELECT 
	representation.titre_rep , lieu, tarif
    FROM programme 
    WHERE num_rep IN(SELECT * FROM programme)
	/*GROUP BY date_rep */
    HAVING date_rep = "2021/02/28"
;
SELECT 
	titre_rep , programme.lieu, programme.tarif
    FROM representation 
    WHERE num_rep IN(SELECT * FROM representation)
    HAVING date_rep = "2021/02/28"
;
#5
SELECT COUNT(DISTINCT num_mus) FROM representation WHERE num_rep = 15;
#6
SELECT representation.titre_rep, date_rep FROM programme WHERE tarif <30 ;
/*GENERIQUE
SELECT *
FROM table1
INNER JOIN table2 ON table1.id = table2.fk_id
OU
INNER JOIN table2
WHERE table1.id = table2.fk_id
*/

