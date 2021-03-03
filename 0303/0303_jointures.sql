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
