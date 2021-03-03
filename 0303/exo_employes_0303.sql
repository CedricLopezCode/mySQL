SHOW DATABASES;
CREATE DATABASE exo_0303_employes;
USE exo_0303_employes;

SHOW TABLES;

CALL creation_table_departements;
CALL creation_table_employes;
CALL insert_departements;
CALL insert_employes;

SELECT * FROM departements;
SELECT * FROM employes;


		# Requetes SQL
#01 Faire le produit cartésien en Employés et Départements
SELECT * FROM employes CROSS JOIN departements;
#02 Donnez les noms des employés et les noms de leur département
	#Simple
SELECT ENOM, DNOM FROM employes, departements WHERE employes.DNO = departements.DNO;
	#joint
SELECT ENOM, DNOM FROM employes INNER JOIN departements ON employes.DNO = departements.DNO;
#03 Donnez les numéros des employés travaillant à Boston
#Simple
SELECT ENO FROM employes WHERE DNO IN (SELECT DNO FROM departements WHERE VILLE = "Boston");
	#joint
SELECT ENO FROM employes INNER JOIN departements ON VILLE = "Boston" AND employes.DNO = departements.DNO;

#04 Donnez les noms des directeurs de département 1 et 3.
#Simple
SELECT ENOM FROM employes WHERE ENO IN (SELECT DIR FROM departements WHERE DNO = 1 OR DNO = 3);
	#joint
SELECT ENOM FROM employes INNER JOIN departements ON DIR = ENO WHERE departements.DNO = 1 OR departements.DNO = 3;

#05 Donnez les noms des employés travaillant dans un département avec au moins un ingénieur
#Simple
SELECT ENOM FROM employes WHERE DNO IN(
	SELECT DNO FROM employes WHERE PROF = "Ingénieur"
);
#joint
SELECT ENOM FROM employes INNER JOIN departements
ON employes.DNO = departements.DNO
WHERE PROF = "Ingénieur"
;
#06 Donnez le salaire et le nom des employés gagnant plus qu'un (au moins un) ingénieur
SELECT SAL, ENOM FROM employes 
WHERE (SELECT MIN(SAL) FROM employes WHERE PROF = "Ingénieur") <= SAL 
AND PROF != "Ingénieur"
;
#07 Donnez les salaires et le nom des employés gagnant plus que tous les ingénieurs
SELECT SAL, ENOM FROM C 
WHERE (SELECT MAX(SAL) FROM employes WHERE PROF = "Ingénieur") <= SAL 
;
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!;
#08 Donnez les noms des employés et les noms de leur directeur.
SELECT ENO, ENOM, employes.DNO, departements.DNO, DIR, REPLACE(
	DIR, DIR, (SELECT ENOM, ENO, DIR FROM employes INNER JOIN departements ON ENO = DIR)
) FROM employes, departements
;

SELECT ENOM, ENO, DIR FROM employes INNER JOIN departements ON ENO = DIR;
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!;
#09 Trouvez les noms des employés ayant le même directeur que JIM
SELECT ENOM  
FROM employes INNER JOIN departements
ON  DIR = (
	SELECT DIR FROM employes INNER JOIN departements ON ENOM = "JIM" AND employes.DNO = departements.DNO
)
AND employes.DNO = departements.DNO
;
SELECT * FROM employes INNER JOIN departements ON ENOM = "JIM" AND employes.DNO = departements.DNO;
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!;
SELECT * FROM  employes;
#10 Donnez le nom et la date d'embauche des employés embauchés avant leur directeur  
SELECT ENOM, DATEEMB, DIR 
FROM employes INNER JOIN departements
ON DATEEMB < /* '2050-10-10'*/(
	SELECT DATEEMB FROM employes INNER JOIN departements 
    ON employes.DNO = departements.DIR
    AND employes.DNO = departements.DNO
)
AND employes.DNO = departements.DNO;
SELECT DATEEMB FROM employes INNER JOIN departements ON ENOM = "JIM" AND employes.DNO = departements.DNO;
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!;
#10bisdonnez également le nom et la date d'embauche dudit directeur
SELECT ENOM, DATEEMB, DIR 
FROM employes INNER JOIN departements
ON employes.DNO = departements.DNO
WHERE employes.ENO = departements.DIR
;
#11 Donnez les départements qui n'ont pas d'employés
SELECT *,COUNT(DISTINCT employes.DNO) FROM employes, departements;
SELECT *,COUNT(DISTINCT employes.DNO) 
FROM employes INNER JOIN departements 
ON employes.DNO = departements.DNO
;
HAVING COUNT(DISTINCT ENO) = 0
;
SELECT *, COUNT(employes.DNO) 
FROM employes INNER JOIN departements 
ON employes.DNO = departements.DNO
GROUP BY departements.DNO 
#HAVING COUNT(DISTINCT ENO) = 0
; 
SELECT * FROM employes HAVING COUNT(DISTINCT ENO);
SELECT * FROM departements
WHERE NOT EXISTS (
	SELECT *
	FROM employes INNER JOIN departements
	WHERE employes.DNO = departements.DNO
)
;
SELECT * FROM employes, departements  WHERE employes.DNO = departements.DNO;
SELECT * FROM employes FULL JOIN departements ON employes.DNO = departements.DNO;

SELECT *  FROM employes INNER JOIN departements WHERE employes.DNO = departements.DNO;
INSERT INTO departements (DNOM) VALUES ("test");
#12 Donnez les noms des employés du département commercial embauchés le même jour
SELECT * FROM employes CROSS JOIN departements
ON DATEEMB = DATEEMB
AND DNOM  = "Commercial"


;

			#Correction Moussa
#08 Donnez les noms des employés et les noms de leur directeur.
SELECT ENOM, DIR FROM employes INNER JOIN departements
ON employes.DNO = departements.DNO
;
#09 Trouvez les noms des employés ayant le même directeur que JIM

#10 Donnez le nom et la date d'embauche des employés embauchés avant leur directeur ; donnez également le nom et la date d'embauche dudit directeur
#11 Donnez les départements qui n'ont pas d'employés
#12 Donnez les noms des employés du département commercial embauchés le même