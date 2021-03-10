			#Début
#mySQL Workbench ctr+entr pour executer une ligne ou icone eclair pour plusieurs sélectionnées
SHOW DATABASES;
CREATE DATABASE 00_resume;
CREATE DATABASE 00_resume CHARACTER SET "utf8"; #Pour avoir les accents, etc...
USE 00_resume;

/*--------------------------------- Creation Table ---------------------------------*/
CREATE TABLE table_1_type_data (
	id_1 INT NOT NULL AUTO_INCREMENT PRIMARY KEY, #clé primaire doit etre unique
	vrai_ou_faux BOOLEAN,
    lettre CHAR, #CHAR(5) Obligatoirement 5 CHAR pas moins
    nom VARCHAR(30), #VARCHAR max 255...
    adresse TEXT, #...si + alors mettre TEXT
    sexe ENUM("M","F"), #à éviter: mettre plutot un check
    genre CHAR(1), CHECK(sexe in("M","F")),
    age INT,
    taille FLOAT,
    #prix MONEY,
    dates DATE, #AAAA-MM-JJ
    heure TIME, #HH:MM:SS
    date_et_heure DATETIME,
    temps_depuis TIMESTAMP #temps en s depuis le 01/01/1970
);
CREATE TABLE table_2_option (
	id_2 INT NOT NULL AUTO_INCREMENT, # A_I = se gere tout seul donc on s'en occupe pas
    age INT NOT NULL, #refuse d'ajouter si on rentre pas une valeur
    numero INT(5) ZEROFILL, #Complete avec des 0 devant pour toujour avoir 5 chiffres
    qi INT DEFAULT 100, #Donne une valeur par défaut si on ne rentre rien
	mail VARCHAR(255) UNIQUE, #refuse d'ajouter si deja dans la DB
    CHECK (mail LIKE "%@%.__" OR email LIKE "%@%.___"), #Vérifie que c'est quelque chose d'acceptable
    PRIMARY KEY (id_2) #la cle primaire peut se mettre comme ça, avec les Foreign Key
);
CREATE TABLE table_3_clefs (
	id_3 INT NOT NULL AUTO_INCREMENT  PRIMARY KEY,
    tab_3_id_1 INT, #Attention que le type corresponde bien avec celui de l'autre table pour les Cle  Etrangere
    tab_3_id_2 INT,
    FOREIGN KEY (tab_3_id_1) REFERENCES table_1_type_data(id_1), #CLE etrangere fait reference à un cle primaire d'une autre table
    #		(Colonnne de cette table)		table où on a mes data(colonne de la table en question qui fait le lien)
    CONSTRAINT fk_tab3_tab2 FOREIGN KEY (tab_3_id_2) REFERENCES table_2_option(id_2) # On peut donner un nom à la cle etrangere
);
		#Vérifier que les Tables sont bien crées
SHOW TABLES;
/*--------------------------------- Modification et Suppression Table et Données  ---------------------------------*/

		#Ajouter données dans table
INSERT INTO table_1_type_data (nom, age) VALUES ("Cédric", 28); #pas obligé de tout renseigner tant que pas NOT NULL
INSERT INTO table_1_type_data (nom) VALUES ("Cédric"), ("Cédric"); #1 colonnes plusieurs lignes
INSERT INTO table_1_type_data (nom, age) VALUES ("Cédric", 28), ("Cédric", 28), ("Cédric", 28); #Plusieurs colonnes sur plusieurs lignes
INSERT INTO table_1_type_data (dates, heure, date_et_heure) VALUES ("2021-03-13", "13:40:59", "2021-03-13 13:40:59"), (NOW(), NOW() ,NOW()); #Date et Heures
SELECT * FROM table_1_type_data; #pour voir le résultat direct après

		#Modifier Colonnes
ALTER TABLE table_1_type_data ADD tva INT;#Ajoute une colonne 
ALTER TABLE table_1_type_data MODIFY tva FLOAT;#Change type de data 
ALTER TABLE table_1_type_data CHANGE tva tva_bis FLOAT ;#Change nom colonne 
ALTER TABLE table_1_type_data DROP tva_bis ;#Supprime une colonne 
		
        #Modifier Données
UPDATE table_1_type_data SET nom = 'Cedric' WHERE nom IS NULL;
#Attention à pas oublier le WHERE sinon toutes les valeurs de la colonnes seront modifiées
        
		#Vider table
DELETE FROM table_1_type_data ; #supprime les datas pas la tables
TRUNCATE TABLE table_1_type_data ; #Vide la table et remet l'A_I au depart

		#Supprimmer Lignes
DELETE FROM table_1_type_data WHERE id_1 = 1;  #Supprime 1 ligne
DELETE FROM table_1_type_data WHERE id_1 < 3;  #Supprime plusieurs lignes

        #Supprimer table (ou DATABASE)
DROP TABLE /*DATABASE*/ table_1_type_data;

/*--------------------------------- Affichage des Données ---------------------------------*/
		#Selectionner 
#Général Maximum possible dans quel ordre 
SELECT *    
FROM table_1
WHERE condition_1
AND condition_2
GROUP BY nom_colonne
HAVING condition_3
{ UNION | INTERSECT | EXCEPT }
ORDER BY nom_colonne
LIMIT 5 #Ne donne que 5 résultat
OFFSET 5 #Ne donne pas les 5 premiers résultats
;

SELECT * FROM table_1; #Affiche toute la table
SELECT colonne_1, colonne_3 FROM table_1; #Affiche seulement les colonnes 1 et 3
SELECT DISTINCT ville FROM table_1; #N'affiche pas le résultat s'il a déjà vu le meme nom avant
SELECT * FROM table_1 LIMIT 3 OFFSET 2; #Affiche 3 résultats en excluant les 2 premiers donc les 3,4 et 5

    #Alias
    #Valide uniquement dans la requete actuelle
SELECT * FROM table_avec_un_long_nom AS "a"; #permet de moins écrire si on le rappelle dans la requete....
SELECT colonne_1 AS "nom de colonne" FROM table_1 ; #....ou de changer le nom de colonne 
SELECT * FROM table_1 ali; #AS facltatif si juste 1 mot

    #Conditions
SELECT * FROM table_1 WHERE colonne_1 = 3; #Affiche que les lignes où true
SELECT * FROM table_1 WHERE colonne_1 = 3 AND colonne_3 = 5; #2 conditions
SELECT * FROM table_1 WHERE colonne_1 = 3 OR colonne_3 = 5; #1 des 2 conditions suffit
SELECT * FROM table_1 WHERE colonne_1 = 3 HAVING colonne_3 != 5; #2 conditions
SELECT * FROM table_1 WHERE colonne_1 IN(1,3); #Remplace le OR quand plusieurs choix sur la meme colonne
SELECT * FROM table_1 WHERE colonne_1 BETWEEN 10 AND 20; #Quand il y a un intervalle de valeurs possibles
SELECT * FROM table_1 WHERE colonne_1 IS NOT NULL;

    #LIKE 
    #== = pour les string mais avec des jokers en plus
 SELECT * FROM table_1 WHERE nom LIKE "Cedric"; #Affiche que les lignes où true 
 #% remplace un STRING et _ remplace un CHAR   
 SELECT * FROM table_1 WHERE nom LIKE "C%"; #Affiche toutes les lignes où nom commence par C 
 SELECT * FROM table_1 WHERE nom LIKE "%C";  #Affiche toutes les lignes où nom finit par C   
 SELECT * FROM table_1 WHERE nom LIKE "______"; #Affiche que les lignes où nom a 6 lettres
 SELECT * FROM table_1 WHERE nom LIKE "C_____"; #Affiche que les lignes où nom commence par C et 5 lettres derriere  
 SELECT * FROM table_1 WHERE email LIKE "%@%.__"; #email (souvent utilisé dans check pour vérifier la validité)

    #Fonctions d'Aggrégation
    #Souvent derriere un HAVING
    COUNT() 
SELECT COUNT(*) FROM table_1; #Compte le nombre de ligne dans la table
SELECT ville, COUNT(*) FROM logement GROUP BY ville; # Affichez le nombre de biens par ville
SELECT COUNT(DISTINCT idPersonne) FROM logement_personne;# Affichez le nombre de propriétaires différent
    MIN() MAX()
SELECT MIN(note), MAX(note) FROM etudiant;
    SUM()
SELECT SUM(prix) FROM panier;#Calcul le prix du panier
    AVG()
 SELECT AVG(note) FROM etudiant;#Calcul la moyenne des notes des étudiants

/*--------------------------------- Plusieur Tables ---------------------------------*/

    #Requetes imbriquées
SELECT * FROM Concert WHERE Concert_ID IN( 
    SELECT Concert_ID FROM Billet WHERE capacite IN( 
    #Attention à ce que le SELECT dedans ne renvoie que la colonne qui nous intéresse
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
SELECT * FROM pays WHERE EXISTS(
    SELECT * FROM ville WHERE nomVille = "Grenoble"
);
SELECT * FROM pays WHERE capitale ANY( # == IN
    SELECT nomVille FROM ville WHERE nomVille = "Grenoble"
);
SELECT * FROM classe WHERE age ALL(
    SELECT * FROM 3eme4 WHERE age = 13
); #Attention SELECT 1 colonne


		# JOINTURES
        #Evite les SELECT imbriqués
#Générale 
#Sort uniquement là où c'est en commun
SELECT * FROM table_1
TYPE_JOINTURE JOIN table_2
ON table_1.colonne_en_commun = table_2.colonne_en_commun #Colonnes qui font la jointure entre les 2 tables
AND condition_1
; 

#INNER join  90% du temps
#Sort uniquement là où c'est en commun
SELECT * FROM table_1
INNER JOIN table_2
ON table_1.colonne_en_commun = table_2.colonne_en_commun
;
#   == sans jointure
SELECT * FROM table_1, table_2
WHERE table_1.colonne_en_commun = table_2.colonne_en_commun
;
#   == sans jointure
SELECT * FROM table_1, table_2
WHERE table_1.colonne_en_commun = table_2.colonne_en_commun
;
# == avec INTERSECT (Postgre) n'existe pas dans mySQL
SELECT * FROM table_1
INTERSECT 
SELECT * FROM table_2
;

#LEFT join 
#Sort là où il y a une correpondance avec la 2ème (inner join)
#et ensuite il affiche le reste de la 1ère table
SELECT * FROM table_1
LEFT JOIN table_2
ON table_1.colonne_en_commun = table_2.colonne_en_commun
;

#RIGHT join 
#Sort là où il y a une correpondance avec la 1ère (inner join)
#et ensuite il affiche le reste de la 2ème table
SELECT * FROM table_1
RIGHT JOIN table_2
ON table_1.colonne_en_commun = table_2.colonne_en_commun
;

#FULL join De + en + obsolete
#Sort là où il y a une correpondance avec la 1ère (inner join)
#puis il affiche le reste de la 1ère table
#et enfin il affiche le reste de la 2ème table
SELECT * FROM table_1
FULL JOIN table_2
ON table_1.colonne_en_commun = table_2.colonne_en_commun
;
# == avec UNION
SELECT * FROM table_1
UNION #s'attend à avoir le meme nombre de colonnes
#UNION ALL si on veut afficher les doublons
SELECT * FROM table_2
;

#CROSS join 
#Sort Toutes les combinaisons possibles entre les tables
#donc si longueur de 30 et 50 ça nous sors 1500 lignes
#donc très gourmand en ressources
SELECT * FROM table_1
CROSS JOIN table_2
;

#EXCEPT (Postgre) ou MINUS     peut-etre obsolete
SELECT * FROM table_1
MINUS 
SELECT * FROM table_2
;

        #Plusieurs jointures (donc au moins 3 tables) 
SELECT * FROM table_1
INNER JOIN table_2 INNER JOIN table_3 
ON table_1.colonne_en_commun = table_2.colonne_en_commun
AND table_2.colonne_en_communbis = table_3.colonne_en_communbis
AND condition_1
;
    # == Version Moussa
SELECT * FROM table_1
INNER JOIN table_2 
ON table_1.colonne_en_commun = table_2.colonne_en_commun
INNER JOIN table_3 
ON table_2.colonne_en_communbis = table_3.colonne_en_communbis
AND condition_1
;


/*--------------------------------- Utilisateurs ---------------------------------*/
  # Voir          
SELECT * FROM mysql.user; #voir tout de tous les users
SELECT user FROM mysql.user; #voir tous les noms users
SELECT current_user() FROM mysql.user; #voir l'user courant
SHOW GRANTS FOR "root@localhost"; #voir les droits de ce user
  # Créer
CREATE user "cedric"@"localhost" IDENTIFIED by "password"; #Ajouter un user
#dans shell mysql -u user -p password     #de base -u root et -p 
#dans shell exit pour se deconnecter
 
	#Modifier 
ALTER user "cedric@localhost" IDENTIFIED by "mdp"; #modifier un mdp
GRANT all on *.* to "cedric@localhost"; # modifie droit user
# all = create + insert + select + update + delete + drop + truncate
# drop supprimme les table alors que delete juste les données
# 1ère * == Toutes les bases de données
# 2ème * == Toutes les tables
GRANT all on base_ou_il_a_les_droits.table_ou_il_a_les_droits to "cedric@localhost";
GRANT select, insert on *.* to "cedric@localhost"; #donc pas le droit de update et delete
#souvent on donne tous les droits sauf delete
GRANT select on *.* to "rim", "simon"; #donner les memes droits a plusieurs utilisateurs
FLUSH PRIVILEGES; #mettre à jour les droits et eviter de se deconnecter

	#Modifier 
REVOKE all, GRANT OPTION FROM 'cedric@localhost'; #Enlever des droits
DROP user 'cedric@localhost'; #supprimer un user

/*--------------------------------- Procédures ---------------------------------*/
    #Créer une procédure
/*
Dans la collone à gauche Navigator
Sélectionner onglet Schemas en bas
Ouvrir la Database
Clique Droit sur Stored Procedure
Dans le nouvel onglet
    CREATE PROCEDURE `nom_procédure` ()
    BEGIN
        Instructions
    END
Cliquer sur Apply en bas à droite
Apply...
*/

    #Appeler une procédure
CALL nom_procedure;



