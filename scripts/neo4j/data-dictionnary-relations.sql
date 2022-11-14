-- Etape 2 : Dictionnaire de données (relations)
CREATE VIEW dbo.Cypher_Relationships
		AS
		SELECT
		    CypherScript='CREATE (n'
		+   CAST(parent_object_id AS varchar(10))
		+   ')-[:IS_RELATED_TO]->(n'
		+   CAST(referenced_object_id AS varchar(10))
		+   ')'
		    FROM sys.foreign_keys
		GO