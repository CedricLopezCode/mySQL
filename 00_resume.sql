			#Début
SHOW DATABASES;
CREATE DATABASE 00_resume;
USE 00_resume;

			#Creer table
CREATE TABLE table_1_type_data (
	id_1 INT NOT NULL AUTO_INCREMENT PRIMARY KEY, #clé primaire doit etre unique
	nom VARCHAR(255), #VARCHAR max 255...
    adresse TEXT, #...si + alors mettre TEXT
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

		#Modifier table
ALTER TABLE table_1_type_data ADD tva INT;#Ajoute une colonne 
ALTER TABLE table_1_type_data MODIFY tva FLOAT;#Change type de data 
ALTER TABLE table_1_type_data CHANGE tva tva_bis FLOAT ;#Change nom colonne 
ALTER TABLE table_1_type_data DROP tva_bis ;#Supprime une colonne 

		#Supprimmer Lignes
DELETE FROM table_1_type_data WHERE id_1 = 1;  #Supprime 1 ligne
DELETE FROM table_1_type_data WHERE id_1 < 3;  #Supprime plusieurs lignes

		#Vider table
DELETE FROM table_1_type_data ; #supprime les datas pas la tables
TRUNCATE TABLE table_1_type_data ; #Vide la table et remet l'A_I au depart
		
        #Supprimer table
DROP TABLE table_1_type_data;
		#Creer table
		#Creer table
        SELECT *
FROM table
WHERE condition
GROUP BY expression
HAVING condition
{ UNION | INTERSECT | EXCEPT }
ORDER BY expression
LIMIT count
OFFSET start