-- Permet de mener une analyse d'impact dans la base de données
SELECT
    OBJECTPROPERTYEX(SM.object_id, 'basetype') AS ObjectType,
    OBJECT_SCHEMA_NAME(SM.object_id) AS SchemaName,
    OBJECT_NAME(SM.object_id) AS ObjectName
FROM
    sys.sql_modules AS SM
WHERE
    OBJECTPROPERTY(SM.object_id, 'IsMSShipped') = 0 -- Pour exclure les objets système
    AND SM.definition LIKE '%Name%'; -- Pattern recherché dans la base de donneés