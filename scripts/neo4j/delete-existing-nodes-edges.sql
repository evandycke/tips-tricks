-- Etape 4 : Suppression des noeuds et relations existants
CREATE VIEW dbo.CypherDeleteAll
		AS
		SELECT 'MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n,r;' AS CypherScript