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
GRANT select, insert ON immobilier.personne TO "afpa@localhost";
GRANT select, insert ON immobilier.logement TO "afpa@localhost";
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'afpa@localhost';

CREATE USER "cda314@localhost" IDENTIFIED BY "cda314";
GRANT delete ON immobilier.demande TO "cda314@localhost";
GRANT delete ON immobilier.logement TO "cda314@localhost";
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
SELECT ville, COUNT(*) FROM logement WHERE  categorie LIKE "vente" GROUP BY ville;
#9. Quelles sont les id des logements destinés à la location ?
SELECT idLogement FROM logement WHERE categorie LIKE "location";
/*--------------------------En Cours--------------------------------------------------------*/
SELECT * FROM agence;
SELECT * FROM demande;
SELECT * FROM logement;
SELECT * FROM logement_agence;
SELECT * FROM logement_personne;
SELECT * FROM personne;
#10. Quels sont les id des logements entre 20 et 30m² ?
SELECT idLogement, superficie FROM logement WHERE superficie >= 20 AND superficie <= 30;
/*--------------------------En cours--------------------------------------------------------*/

#11. Quel est le prix vendeur (hors frais) du logement le moins cher à vendre ? (Alias : prix minimum)
#12. Dans quelles villes se trouve les maisons à vendre ?
#13. L’agence Orpi souhaite diminuer les frais qu’elle applique sur le logement ayant l'id « 3 ». Passer les frais de ce logement de 800 à 730€          
#14. Quels sont les logements gérés par l’agence « seloger »
#15. Affichez le nombre de propriétaires dans la ville de Paris (Alias : Nombre)
#16. Affichez les informations des trois premières personnes souhaitant acheter un logement
#17. Affichez les prénoms, email des personnes souhaitant accéder à un logement en location sur la ville de Paris
#18. Si l’ensemble des logements étaient vendus ou loués demain, quel serait le bénéfice généré grâce aux frais d’agence et pour chaque agence (Alias : bénéfice, classement : par ordre croissant des gains)
#19. Affichez le prénom et la ville où se trouve le logement de chaque propriétaire
#20. Affichez le nombre de logements à la vente dans la ville de recherche de « hugo » (alias : nombre)