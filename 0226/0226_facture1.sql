SHOW DATABASES;
CREATE DATABASE exo_2602_facture;
USE exo_2602_facture;

SHOW TABLES;

CREATE TABLE clients (
	numCli INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nomCli VARCHAR(20) NOT NULL,
    prenomCli VARCHAR(20) NOT NULL,
    adresseCli VARCHAR(255) NOT NULL,
    mailCli VARCHAR(255) NOT NULL UNIQUE 
);
CREATE TABLE vendeur (
	idVendeur INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nomVendeur VARCHAR(20) NOT NULL,
    adresse_vend VARCHAR(255) NOT NULL
);
CREATE TABLE produit (
	numProd INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    designation VARCHAR(255) NOT NULL,
    prix FLOAT NOT NULL,
    qte_stock INT DEFAULT 0
);
CREATE TABLE commande (
	numCom INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    numCli INT NOT NULL,
	idVendeur INT NOT NULL,
    numProd INT NOT NULL,
	date_com DATETIME,
    qte_com INT,
    CONSTRAINT cle_com_cli FOREIGN KEY (numCli) REFERENCES clients(numCli),
    CONSTRAINT cle_com_vend FOREIGN KEY (idVendeur) REFERENCES vendeur(idVendeur),
    CONSTRAINT cle_com_prod FOREIGN KEY (numProd) REFERENCES produit(numProd)
);

#2  	la liste des clients de Paris.
SELECT * FROM clients WHERE adresseCli LIKE "%paris%" OR clients.adresseCli IN (75___);
#3 		la liste des produits (Numprod, désignation, prix) classés de plus cher au moins cher.
SELECT numProd, designation, prix FROM produit ORDER BY prix DESC;
#4		noms et adresses des vendeurs dont le nom commence par la lettre ‘M’.
SELECT nomVendeur, adresse_vend FROM vendeur WHERE nomVendeur LIKE "M%";
#5		la liste des commandes effectuées par le vendeur "Moussa" entre le 1er et 28 février.
SELECT * FROM commande 
WHERE (SELECT nomVendeur FROM vendeur) = "Moussa" 
HAVING date_com BETWEEN "2021-02-01" AND "2021-02-28";
#6		le nombre des commandes contenant le produit n° 365.
SELECT COUNT(*) FROM commande HAVING numProd = 365;




