-- Les permissions sur les objets
SELECT
	CASE 
		WHEN class_desc='DATABASE' THEN DB_NAME()
		WHEN class_desc='SCHEMA' THEN SCHEMA_NAME(major_id)
		WHEN class_desc='OBJECT_OR_COLUMN' THEN OBJECT_NAME(major_id)
		WHEN class_desc='DATABASE_PRINCIPAL' THEN USER_NAME(major_id)
		WHEN class_desc='TYPE' THEN TYPE_NAME(major_id)
		ELSE 'Huh??'
	END AS [Object Name],
	USER_NAME(grantee_principal_id) AS grantee,
	USER_NAME(grantor_principal_id) AS grantor, 
	type, 
	Permission_Name,
	State_Desc
FROM
	sys.database_permissions
WHERE
	Class_Desc IN ('DATABASE', 'SCHEMA', 'OBJECT_OR_COLUMN','DATABASE_PRINCIPAL', 'TYPE');
-- and grantee_principal_id = DATABASE_PRINCIPAL_ID('public');

-- Les propriétaires des objets
SELECT 
	[Entity Type], 
	[Owner name], 
	[Object Name]
FROM
	(SELECT 
		REPLACE(SUBSTRING(v.name, 5, 31),'cns','constraint')  AS [entity type],
		USER_NAME(OBJECTPROPERTY(object_id, 'OwnerId')) AS [owner name],
		DB_NAME() + '.' + Object_Schema_name(o.object_ID) + '.' + o.name as [Object Name]
	FROM 
		sys.objects o
	LEFT OUTER JOIN 
		master.dbo.spt_values v -- Pour obtenir le type de l'objet
        ON o.type = SUBSTRING(v.name, 1, 2) COLLATE database_default
        AND v.type = 'O9T'

	UNION 

	SELECT 
		'Type',
		USER_NAME(TYPEPROPERTY(SCHEMA_NAME(schema_id) + '.' + name, 'OwnerId')),
		DB_NAME() + '.' + Schema_name(schema_ID) + '.' + name 
	FROM 
		sys.types  

	UNION

	SELECT 
		'XML Schema Collection',
		COALESCE(USER_NAME(xsc.principal_id),USER_NAME(s.principal_id)),
		DB_NAME() + '.' + Schema_name(xsc.schema_ID) + '.' + xsc.name 
	FROM 
		sys.xml_schema_collections AS xsc 
	JOIN 
		sys.schemas AS s
		ON s.schema_id = xsc.schema_id) f
WHERE 
	[owner Name] NOT LIKE 'sys';