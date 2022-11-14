-- On va rechercher dans l'ensemble de colonnes de la table DWH.R_COMMUNE la valeur Lille
select c.* from "DWH"."R_COMMUNE" c where c::text ~ 'Lille'