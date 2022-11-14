-- Etape 1 : Dictionnaire de données (tables)
CREATE VIEW dbo.Cypher_Nodes
		AS
		WITH Datadictionary_Tables(ObjectID,SchemaName,TableName,TableDescription)
		AS  (
		SELECT
		    CypherScript=T.OBJECT_ID,
		    SchemaName=OBJECT_SCHEMA_NAME(T.object_id),
		    TableName=T.NAME,
		    TableDescription=COALESCE(CAST(EP.VALUE AS VARCHAR(MAX)),'')
		FROM sys.tables AS T  
		    LEFT JOIN sys.extended_properties AS EP
		    ON T.object_id=EP.major_id
		    and EP.minor_id=0 -- We only want the table descriptions
		    and EP.name='MS_DESCRIPTION' 
		)
		SELECT
		    CypherScript='CREATE (n'
		    + CAST(objectID AS VARCHAR(10))
		    +':'
		    + SchemaName
		    + 'table{name:"'
		    +   tablename
		    +   '",schema:"'
		    +   SchemaName
		    +   '",description:"'
		    +   REPLACE(TableDescription,char(34),'\"'+char(39))
		    + '"})'
		FROM DataDictionary_tables
		GO