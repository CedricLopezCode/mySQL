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


