SHOW DATABASES;
CREATE DATABASE immobilier;
USE immobilier;
SHOW TABLES;

CALL creation_agence;
CALL creation_logement;
CALL creation_logement_agence;
CALL creation_personne;
CALL creation_logement_personne;
CALL creation_demande;
SHOW TABLES;

CALL insert_agence;
CALL insert_logement;
CALL insert_logement_agence;
CALL insert_personne;
CALL insert_logement_personne;
CALL insert_demande;
#TRUNCATE TABLE logement;
			# Privilèges
SELECT * FROM mysql.user;
CREATE USER "afpa" IDENTIFIED BY "afpa";
DROP USER "afpa";

CREATE USER "afpa@localhost" IDENTIFIED BY "afpa";
/*Correction*/CREATE USER "afpa"@"localhost" IDENTIFIED BY "afpa";
GRANT select, insert ON immobilier.personne TO "afpa@localhost";
GRANT select, insert ON immobilier.logement TO "afpa@localhost";
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'afpa@localhost';

CREATE USER "cda314@localhost" IDENTIFIED BY "cda314";
/*Correction*/CREATE USER "cda314"@"localhost" IDENTIFIED BY "cda314";
GRANT delete ON immobilier.demande TO "cda314@localhost";/*Correction "cda314"@"localhost"*/
GRANT delete ON immobilier.logement TO "cda314@localhost";/*Correction "cda314"@"localhost"*/
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'cda314@localhost';

            
			# Requetes SQL

#1. Affichez le nom des agences
SELECT nom FROM agence;
#2. Affichez le numéro de l’agence « Orpi »
SELECT idAgence FROM agence WHERE nom LIKE "orpi";
#3. Affichez le premier enregistrement de la table logement
SELECT * FROM logement ORDER BY idLogement LIMIT 1;
#4. Affichez le nombre de logements (Alias : Nombre de logements)
SELECT COUNT(*) AS "Nombre de logements" FROM logement;
#5. Affichez les logements à vendre à moins de 150 000 € dans l’ordre croissant des prix.
SELECT * FROM logement WHERE categorie = "vente" HAVING prix < 350000 ORDER BY prix;
#6. Affichez le nombre de logements à la location (alias : nombre)
SELECT COUNT(*) nombre FROM logement WHERE categorie LIKE "location";
#7. Affichez les villes différentes recherchées par les personnes demandeuses d'un logement
SELECT DISTINCT ville FROM demande;
SELECT ville FROM demande GROUP BY ville;
#8. Affichez le nombre de biens à vendre par ville
SELECT ville, COUNT(*) FROM logement WHERE categorie LIKE "vente" GROUP BY ville;
#9. Quelles sont les id des logements destinés à la location ?
SELECT idLogement FROM logement WHERE categorie LIKE "location";
#10. Quels sont les id des logements entre 20 et 30m² ?
SELECT idLogement FROM logement WHERE superficie >= 20 AND superficie <= 30;
/*Correction*/SELECT idLogement FROM logement WHERE superficie BETWEEN 20 AND 30;
#11. Quel est le prix vendeur (hors frais) du logement le moins cher à vendre ? (Alias : prix minimum)
SELECT MIN(prix) AS "prix minimum" FROM logement WHERE categorie LIKE "vente";
#12. Dans quelles villes se trouve les maisons à vendre ?
SELECT DISTINCT ville FROM logement WHERE categorie LIKE "vente" AND type = "maison";
#13. L’agence Orpi souhaite diminuer les frais qu’elle applique sur le logement ayant l'id « 3 ». 
#Passer les frais de ce logement de 800 à 730€   
INSERT INTO logement_agence (idAgence, idLogement, frais) VALUES (5, 000003, 800);
				# VALUES ((SELECT idAgence FROM agence WHERE nom = "orpi" ), 000003, 800);
UPDATE logement_agence SET frais = 730 WHERE idLogement = 3;  
/*Correction Ingrid*/
SELECT REPLACE(frais, 800 , 730) FROM logement_agence WHERE idLogement = 3;
/*Ne change que dans l'affichage, pas dans les bases de données*/
#14. Quels sont les logements gérés par l’agence « seloger »
INSERT INTO logement_agence (idAgence, idLogement, frais) VALUES (8, 000004, 800), (8, 000005, 800);
#Simple
SELECT * from logement WHERE idLogement IN (
	SELECT idLogement FROM logement_agence WHERE idAgence IN(
		SELECT idAgence FROM agence WHERE nom = "seloger" )
);
#Jointure
SELECT * FROM logement INNER JOIN logement_agence INNER JOIN agence 
ON logement.idLogement = logement_agence.idLogement
AND logement_agence.idAgence = agence.idAgence
AND nom = "seloger"
;
#15. Affichez le nombre de propriétaires dans la ville de Paris (Alias : Nombre)
#Simple 
SELECT COUNT(DISTINCT idPersonne) Nombre 
FROM logement_personne WHERE idLogement IN(
	SELECT idLogement FROM logement WHERE ville = "paris")
;
#Jointure
SELECT COUNT(DISTINCT idPersonne) Nombre 
FROM logement_personne INNER JOIN logement
ON logement.idLogement = logement_personne.idLogement
AND ville LIKE "paris"
;
#16. Affichez les informations des trois premières personnes souhaitant acheter un logement
#Simple
SELECT * FROM personne 
WHERE idPersonne IN(
	SELECT idPersonne FROM demande) 
LIMIT 3;
#Jointure
SELECT * FROM personne INNER JOIN demande
ON personne.idPersonne = demande.idPersonne
LIMIT 3;
#17. Affichez les prénoms, email des personnes souhaitant accéder à un logement en location sur la ville de Paris
#Simple
SELECT prenom, email FROM personne
WHERE idPersonne IN(
	SELECT idPersonne FROM demande WHERE ville = "paris" AND categorie = "location" )
;
#Jointure
SELECT prenom, email FROM personne INNER JOIN demande
ON personne.idPersonne = demande.idPersonne
AND ville = "paris"
AND categorie = "location"
;
#18. Si l’ensemble des logements étaient vendus ou loués demain, quel serait le bénéfice généré grâce aux frais d’agence et pour chaque agence (Alias : bénéfice, classement : par ordre croissant des gains)
SELECT idAgence, SUM(frais) bénéfice FROM logement_agence GROUP BY idAgence ORDER BY bénéfice /*ASC*/;
#19. Affichez le prénom et la ville où se trouve le logement de chaque propriétaire
#Simple
SELECT prenom, ville FROM logement_personne, logement, personne 
WHERE logement_personne.idPersonne = personne.idPersonne
AND logement_personne.idLogement = logement.idLogement
;
#Jointure
SELECT prenom, ville FROM personne INNER JOIN logement_personne INNER JOIN logement
ON logement_personne.idPersonne = personne.idPersonne
AND logement_personne.idLogement = logement.idLogement
;
#20. Affichez le nombre de logements à la vente dans la ville de recherche de « hugo » (alias : nombre)
#Simple
SELECT COUNT(*) nombre FROM logement 
WHERE categorie LIKE "vente" 
AND ville IN(
	SELECT ville FROM demande WHERE idPersonne IN(
		SELECT idPersonne FROM personne WHERE prenom = "bbb"/*Cedric*/
    )
)
;
#Jointure
SELECT COUNT(*) nombre FROM logement INNER JOIN demande INNER JOIN personne
ON logement.ville = demande.ville
AND logement.categorie LIKE "vente" 
AND personne.idPersonne = demande.idPersonne
AND prenom = "bbb"
;

/*--------------------------En Cours--------------------------------------------------------*/
SELECT * FROM agence;
SELECT * FROM demande;
SELECT * FROM logement;
SELECT * FROM logement_agence;
SELECT * FROM logement_personne;
SELECT * FROM personne;


/*--------------------------En cours--------------------------------------------------------*/

