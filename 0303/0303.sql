use exo_avion;

show tables;
SELECT * FROM avion;
SELECT * FROM pilote;
SELECT * FROM vol;


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
            
SELECT * FROM mysql.user; #voir tout de tous les users
SELECT user FROM mysql.user; #voir tous les noms users
SELECT current_user() FROM mysql.user; #voir l'user courant
SHOW GRANTS FOR 'root@localhost'; #voir les droits
CREATE user 'cedric@localhost' IDENTIFIED by 'password'; #Ajouter un user
#dans shell mysql -u user -p password     #de base -u root et -p 
#dans shell exit pour se deconnecter
ALTER user 'cedric@localhost' IDENTIFIED by 'passwordapresmodif'; #modifier un mdp
ALTER user 'cedric@localhost' IDENTIFIED by 'mdp'; #modifier un mdp
GRANT all on *.* to 'cedric@localhost'; # modifie droit user
# all = select, insert, update, Delete  === CRUD
# 1ère * == Toutes les bases de données
# 2ème * == Toutes les tables
GRANT all on base_ou_il_a_les_droits.table_ou_il_a_les_droits to 'cedric@localhost';
GRANT select, insert on *.* to 'cedric@localhost'; #donc pas le droit de update et delete
GRANT select on *.* to 'rim', 'simon'; #donner les memes droits a plusieurs utilisateurs
#souvent on donne tous les droits sauf delete
FLUSH PRIVILEGES; #mettre à jour les droits et eviter de se deconnecter
REVOKE all, GRANT OPTION FROM 'cedric@localhost'; #Enlever des droits
SHOW GRANTS FOR 'cedric@localhost'; #voir les droits de ce user
DROP user 'cedric@localhost'; #supprimer un user


#purger
DROP TABLE table1;

#Procedures stockées  === function
CALL nom_stored_procedure;









