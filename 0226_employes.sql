SHOW DATABASES;
CREATE DATABASE exo_employes;
USE exo_employes;

SHOW TABLES;

CREATE TABLE departement (
	DNO INT, 
	DNOM VARCHAR(20), 
	DIR INT, 
	VILLE VARCHAR(30)
);
CREATE TABLE employe (
	ENO INT(5),
    ENOM VARCHAR(20), 
    PROF VARCHAR(50), 
    DATEEMB DATE,
    SAL INT,
    COMM INT,
    DNO INT PRIMARY KEY
);
#1
SELECT * FROM employes WHERE COMM != 0;
#2
SELECT DNOM, ENO, SAL FROM employes order by ENO AND SAL DESC;
#3
SELECT AVG(SAL) FROM employes;
#4
SELECT AVG(SAL) FROM employes HAVING DNOM = 'Production' ;
#5
SELECT DNO, MAX(SAL) FROM departements;
#6
SELECT PROF, AVG(SAL) FROM employe GROUP BY PROF;
#7
SELECT MIN(AVG(SAL)) FROM employe GROUP BY PROF;
#8
SELECT MIN(SAL) FROM employe GROUP BY PROF;
#9

#10


ENO, ENOM, PROF, DATEEMB, SAL, COMM, #DNO)
ENO : numéro d'employé, clé
ENOM : nom de l'employé
PROF : profession (directeur n'est pas une profession)
SAL : salaire
COMM : commission (un employé peut ne pas avoir de commission)
DNO : numéro de département auquel appartient l'employé
DNO : numéro de département, clé
DNOM : nom du département
DIR : numéro d'employé du directeur du département
VILLE : lieu du département (ville)