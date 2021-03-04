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
/*--------------------------ESSAI--------------------------------------------------------*/
SELECT * FROM personne;


/*--------------------------ESSAI--------------------------------------------------------*/

#2. Affichez le numéro de l’agence « Orpi »
#3. Affichez le premier enregistrement de la table logement
#4. Affichez le nombre de logements (Alias : Nombre de logements)
#5. Affichez les logements à vendre à moins de 150 000 € dans l’ordre croissant des prix.
#6. Affichez le nombre de logements à la location (alias : nombre)
#7. Affichez les villes différentes recherchées par les personnes demandeuses d'un logement
#8. Affichez le nombre de biens à vendre par ville
#9. Quelles sont les id des logements destinés à la location ?
#10. Quels sont les id des logements entre 20 et 30m² ?
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