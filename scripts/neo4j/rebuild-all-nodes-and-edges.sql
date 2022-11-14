-- Etape 5 : Reconstruire tous les noeuds et les relations
CREATE VIEW dbo.CypherRebuildAllNodesAndRelationships
		AS
		SELECT CypherScript FROM dbo.CypherDeleteAll
		UNION ALL
		SELECT CypherScript FROM  dbo.Cypher_Nodes
		UNION ALL
		SELECT CypherScript FROM dbo.Cypher_Relationships
		UNION ALL
		SELECT ';' AS CypherScript
		GO