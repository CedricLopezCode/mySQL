			#Début
SHOW DATABASES;
CREATE DATABASE 00_resume;
USE 00_resume;

			#Creer table
CREATE TABLE table_1_type_data (
	id_1 INT NOT NULL AUTO_INCREMENT PRIMARY KEY, #clé primaire doit etre unique
	nom VARCHAR(255), #VARCHAR max 255...
    adresse TEXT, #...si + alors mettre TEXT
    genre ENUM("M","F"),
    age INT,
    prix FLOAT,
    dates DATE,
    heure TIME,
    date_et_heure DATETIME
);
CREATE TABLE table_2_option (
	id_2 INT NOT NULL AUTO_INCREMENT, # A_I = se gere tout seul donc on s'en occupe pas
    age INT NOT NULL, #refuse d'ajouter si on rentre pas une valeur
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
UPDATE table_1_type_data SET nom = 'Moussa' WHERE nom IS NULL;
        
		#Vider table
DELETE FROM table_1_type_data ; #supprime les datas pas la tables
TRUNCATE TABLE table_1_type_data ; #Vide la table et remet l'A_I au depart

		#Supprimmer Lignes
DELETE FROM table_1_type_data WHERE id_1 = 1;  #Supprime 1 ligne
DELETE FROM table_1_type_data WHERE id_1 < 3;  #Supprime plusieurs lignes

        #Supprimer table
DROP TABLE table_1_type_data;

		
		#Selectionner 
#Générale Maximum possible dans quel ordre 
SELECT *
FROM table
WHERE conditions
GROUP BY expression
HAVING conditions
{ UNION | INTERSECT | EXCEPT }
ORDER BY expression
LIMIT count
OFFSET start
;

			# JOINTURES
#inner join 
#Sort uniquement là où c'est en commun
SELECT * FROM avion
INNER JOIN vol
ON avion.numAV = vol.numAV; #COLONNES EQUIVALENTES

#   == sans jointure
SELECT * FROM avion, vol
WHERE avion.numAV = vol.numAV;

#LEFT join 
#Sort là où il y a une correpondance avec la 2ème (inner join)
#et ensuite il affiche le reste de la 1ère table
SELECT * FROM avion
LEFT JOIN vol
ON avion.numAV = vol.numAV; #COLONNES EQUIVALENTES

#RIGHT join 
#Sort là où il y a une correpondance avec la 1ère (inner join)
#et ensuite il affiche le reste de la 2ème table
SELECT * FROM avion
RIGHT JOIN vol
ON avion.numAV = vol.numAV; #COLONNES EQUIVALENTES

#FULL join == UNION  De + en + obsolete
#Sort là où il y a une correpondance avec la 1ère (inner join)
#puis il affiche le reste de la 1ère table
#et enfin il affiche le reste de la 2ème table
SELECT * FROM avion
FULL JOIN vol
ON avion.numAV = vol.numAV; #COLONNES EQUIVALENTES
SELECT * FROM avion
UNION #s'attend à avoir le meme nombre de colonnes
SELECT * FROM vol;

#CROSS join 
#Sort là où il y a une correpondance avec la 1ère (inner join)
#et ensuite il affiche le reste de la 2ème table
SELECT * FROM avion
CROSS JOIN vol;

#EXCEPT ou MINUS    peut-etre obsolete
SELECT * FROM avion
MINUS 
SELECT * FROM vol;


			#USERS
  # Voir          
SELECT * FROM mysql.user; #voir tout de tous les users
SELECT user FROM mysql.user; #voir tous les noms users
SELECT current_user() FROM mysql.user; #voir l'user courant
SHOW GRANTS FOR 'root@localhost'; #voir les droits de ce user
  # Créer
CREATE user 'cedric@localhost' IDENTIFIED by 'password'; #Ajouter un user
#dans shell mysql -u user -p password     #de base -u root et -p 
#dans shell exit pour se deconnecter
 
	#Modifier 
ALTER user 'cedric@localhost' IDENTIFIED by 'mdp'; #modifier un mdp
GRANT all on *.* to 'cedric@localhost'; # modifie droit user
# all = select + insert + update + delete  === CRUD
# 1ère * == Toutes les bases de données
# 2ème * == Toutes les tables
GRANT all on base_ou_il_a_les_droits.table_ou_il_a_les_droits to 'cedric@localhost';
GRANT select, insert on *.* to 'cedric@localhost'; #donc pas le droit de update et delete
#souvent on donne tous les droits sauf delete
GRANT select on *.* to 'rim', 'simon'; #donner les memes droits a plusieurs utilisateurs
FLUSH PRIVILEGES; #mettre à jour les droits et eviter de se deconnecter

	#Modifier 
REVOKE all, GRANT OPTION FROM 'cedric@localhost'; #Enlever des droits
DROP user 'cedric@localhost'; #supprimer un user

