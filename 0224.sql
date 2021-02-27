SHOW DATABASES;
USE best_cda;
SHOW TABLES;
CREATE TABLE etudiants(id INT NOT NULL AUTO_INCREMENT, nom VARCHAR(30), prenom VARCHAR(30), mail VARCHAR(30), moyenne FLOAT, PRIMARY KEY(id));
UPDATE produits SET nom = "covid" WHERE nom = "gel";
SELECT * FROM etudiants;
INSERT INTO etudiants (prenom, nom, mail, moyenne) VALUES ("Cédric", "LOPEZ", "cedic@lee.ce", 20),("mousse", "camre", "fs@lf", 0.05);


SHOW DATABASES;
DROP DATABASE exo_centre;

SHOW DATABASES;
CREATE DATABASE exo_centre;
USE exo_centre;
CREATE TABLE stagiaires (nom VARCHAR(30), prenom VARCHAR(30), ville VARCHAR(30));
CREATE TABLE centres (nom VARCHAR(30), lieu VARCHAR(30), specialite VARCHAR(30));
INSERT INTO stagiaires(nom, prenom, ville) VALUES ("moussa", "camara", "Paris"), ("Jean", "Dupont", "Tintin"), ("Zack", "Henri", "Zebre"), ("Machin", "Bidule", "Truc");
INSERT INTO centres (nom, lieu, specialite) VALUES ("Afpa", "Paris", "Best CDA"), ("Afpa", "Marseille", "Dev Mobile"), ("Afpa", "Lyon", "Marketing"), ("Afpa", "Grenoble", "Nanotechnologie");
SELECT * FROM centres;
SELECT * FROM stagiaires;
SHOW TABLES;
SHOW DATABASES;

SELECT * FROM centres;
UPDATE centres SET specialite = "Nanotechnologie" WHERE specialite = "Nanptechnologie";

ALTER TABLE centres add id INT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;
ALTER TABLE centres DROP COLUMN id;
SELECT * FROM centres;


SHOW DATABASES;
SHOW TABLES;
CREATE DATABASE etudiants_examen;
USE etudiants_examen;

CREATE TABLE etudiant (matricule INT NOT NULL, nom VARCHAR(30) NOT NULL, prenom VARCHAR(30) NOT NULL, date_de_naissance DATE NOT NULL, niveau INT NOT NULL);
CREATE TABLE cours (code_cours INT NOT NULL, nom_du_cours VARCHAR(30) NOT NULL, enseignant VARCHAR(30) DEFAULT "Moussa Camara");
CREATE TABLE examen (matricule INT NOT NULL, code_cours VARCHAR(20) NOT NULL, note INT );

#ALTER TABLE examen CHANGE note notes INT);

SELECT * FROM etudiant;
SELECT * FROM examen;
SELECT * FROM cours;
SELECT * FROM etudiant ORDER BY date_de_naissance;
SELECT * FROM etudiant WHERE niveau = "CAP" OR niveau = "BAC";

SELECT matricule, AVG(note) FROM examen;
SELECT matricule, AVG(note) FROM examen GROUP BY matricule;
SELECT matricule, AVG(note) FROM examen GROUP BY matricule HAVING AVG(note)>= 10;
SELECT matricule, AVG(note) FROM examen GROUP BY code_cours;
#SELECT COUNT(SELECT matricule, AVG(note) FROM examen GROUP BY matricule HAVING AVG(note)>= 10) FROM cours;
SELECT COUNT(*) FROM cours;

