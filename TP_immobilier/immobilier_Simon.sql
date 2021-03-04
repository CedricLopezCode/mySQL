/*1*/
#mySql root -u password -p;
create database immobilier;
use immobilier;

 
create table logement(id int not null auto_increment primary key, type varchar (25), prix float, superficie float,
categorie varchar (10));

create table agence (id int not null auto_increment primary key, nom varchar (50), adresse varchar(200));

create table logement_agence (id int not null auto_increment primary key,  foreign key logement(id)
 references logement,
 foreign key agence(id) references agence, frais float);

Create table personne(id int not null auto_increment primary key, nom varchar (50), prenom varchar(50), 
email varchar(50) unique check (email like'%@%.___');

create table logement_personne (mailcli varchar(50) unique check (email like'%@%.___'), foreign key logement(id) references logement, 
foreign key personne(id) references personne); 

/*2*/
create procedure agence
insert data (a integer, nom varchar(50), adresse varchar(200))
language sql 
AS $$ insert into table agence values (idagence, nom, adresse); $$;

create procedure demande
insert_data (idDemande, idPersonne, type, ville, budget, superficie, categorie)
language sql
AS $$ insert into table demande values (idDemande, idPersonne, type, ville, budget, superficie, categorie); $$;

create procedure logement_personnne
insert_data (idLogementPersonne int not null auto_increment primary key, 
idPersonne foreign key personne(id) references personne, idlogement foreign key personne(id) references personne)
language sql
as $$ insert into logement-personne(logement_id, personne_id, id_logement);$$;

/*3*/
select id, nom from agence;
select nom, idagence from agence where nom like 'Orpi';
select nom, id from logement where id=1;
select logement, count(idlogement) as nombre_de_logements from logement;

select categorie, prix from logement where prix order by asc and categorie = 'vente';

select categorie, count(idlogement) as nombre from logement where categorie = 'location';
select unique ville from demande;
select sum(logement.id), ville, categorie from logement, demande where categorie='location' and order by 'ville';
select logement.id, superficie from logement;
select logement where id = '3' and alter table logement.prix from '800' to '730';
select logement.id, superficie from logement where superficie >='20' and >='30';
 select min(prix), categorie from logement order by categorie = 'vente';
 select ville, id.demande, categorie from demande where categorie = 'vente';
select id, nom from logement, agence where agence.nom=  'Orpi';
select id, nom from logement, agence where agence.nom= 'se loger';
select count(idlogementPersonne), count(idPersonne), categorie, ville from personne, demande 
where categorie, ville = 'vente';
select * from personne where personne(id)= limit(3) order by 
categorie='location' and order by 'ville'='Paris';
 select prenom, mailcli, ville from personne, demande where 'ville'= 'Paris';
18????
Select prenom, 
18. Si l’ensemble des logements étaient vendus ou loués demain, quel serait le
bénéfice généré grâce aux frais d’agence et pour chaque agence (Alias : bénéfice,
classement : par ordre croissant des gains)
19.Affichez le prénom et la ville où se trouve le logement de chaque propriétaire
20.Affichez le nombre de logements à la vente dans la ville de recherche de « hugo »
(alias : nombre)
 
