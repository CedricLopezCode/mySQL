
#4 Quels sont les chanteurs ayant réalisé au moins un concert dans toutes les salles ? 
SELECT Chanteur FROM Spectacle4 
HAVING COUNT(DISTINCT Salle_ID) IN(
	SELECT COUNT(*) FROM Salle4
);
#4 Bis Quels sont les chanteurs ayant réalisé au moins un concert dans toutes les salles ? 
#---------------------------------------------------------
SELECT Chanteur, Salle_ID, Spectacle_ID FROM Spectacle4 requetegobale
WHERE EXISTS ( # Liste chanteur pas toute salle
	# 1 chanteur a toutes les salles   #toutes les salles existes pour 1 chanteur
   
		SELECT  FROM 
        WHERE Salle4.Salle_ID = Spectacle4.Salle_ID   #Recherche de chaque salle dans ce chanteur
    
)
;
SELECT Chanteur, Salle_ID, Spectacle_ID FROM Spectacle4
WHERE EXISTS (  # Liste chanteur toutes salle
	#tous les salles ont 1 Chanteur #1 meme chanteur existe dans toutes les salles
		
        SELECT  FROM 
		WHERE requetegobale.Chanteur = sousrequete.Chanteur
    
)
;
SELECT Chanteur, Salle_ID, Spectacle_ID FROM Spectacle4
WHERE NOT EXISTS ( # Liste chanteur pas toute salle
	#Une salle sans ce chanteur
    SELECT  FROM 
	WHERE requetegobale.Chanteur = sousrequete.Chanteur
)
;
SELECT Chanteur, Salle_ID, Spectacle_ID FROM Spectacle4
WHERE NOT EXISTS (  # Liste chanteur toutes salle
	#Un chanteur sans cette salle
    SELECT  FROM 
	WHERE Salle4.Salle_ID = Spectacle4.Salle_ID
)
;

#---------------------------------------------------------
#Presque comme Correction
SELECT Chanteur, Salle_ID, Spectacle_ID FROM Spectacle4
WHERE NOT EXISTS (  # Liste chanteur toutes salle
	SELECT Salle_ID FROM Salle4 # un id de salle....
    WHERE Spectacle4.Salle_ID =  Salle4.Salle_ID
    AND NOT EXISTS( #... sans ce chanteur
		SELECT SALLE_ID FROM Spectacle4
        WHERE 1 = 1
    )
)
;
#4 Corrections Internet
SELECT Chanteur FROM Spectacle t 
WHERE NOT EXISTS
(SELECT * FROM Salle u WHERE NOT EXISTS 
	(SELECT * FROM Spectacle v
	WHERE v.Chanteur = t. Chanteur AND u.Salle_ID = v.Salle_ID
	)
);

SELECT Chanteur, Spectacle_ID, Salle_ID FROM Spectacle4, Salle4;
	# 4 possibililtés
SELECT Chanteur, Salle_ID, Spectacle_ID FROM Spectacle4
WHERE EXISTS ( # Liste chanteur pas toute salle
	# 1 chanteur a toutes les salles
    
)
;
SELECT Chanteur, Salle_ID, Spectacle_ID FROM Spectacle4
WHERE EXISTS (  # Liste chanteur toutes salle
	#tous les salles ont 1 Chanteur
    
)
;
SELECT Chanteur, Salle_ID, Spectacle_ID FROM Spectacle4
WHERE NOT EXISTS ( # Liste chanteur pas toute salle
	#Une salle sans ce chanteur
    
)
;
SELECT Chanteur, Salle_ID, Spectacle_ID FROM Spectacle4
WHERE NOT EXISTS (  # Liste chanteur toutes salle
	#Un chanteur sans cette salle
    
)
;
