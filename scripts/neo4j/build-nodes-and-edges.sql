-- Etape 3 : G�n�ration des noeuds et des relations
CREATE VIEW dbo.Cypher_GenerateNodesAndRelationships
		AS
		SELECT CypherScript FROM  dbo.Cypher_Nodes
		UNION ALL
		SELECT CypherScript FROM dbo.Cypher_Relationships
		GO