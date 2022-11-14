-- Qu'est ce qui a été récement modifié ?
SELECT  
	[Qualified_Name], 
	Object_Type, 
	CONVERT(CHAR(50), Created, 113) AS Created,
    CONVERT(CHAR(50), Last_Modified, 113) AS Last_Modified
FROM    
	(SELECT --firstly, we'll search the names of the basic objects
		DB_NAME() + '.' + Object_Schema_name(s.[object_ID]) + '.' + COALESCE(p.name + '.', '') + s.name AS [Qualified_Name],
        REPLACE(SUBSTRING(v.name, 5, 31), 'cns', 'constraint') + ' name' AS Object_Type, 
		s.create_date AS 'Created',
        s.modify_date AS 'Last_Modified'
	FROM
		sys.objects S --to get the objects
	LEFT OUTER JOIN 
		master.dbo.spt_values v --to get the type of object
        ON s.type = SUBSTRING(v.name, 1, 2) COLLATE database_default 
        AND v.type = 'O9T' 
	LEFT OUTER JOIN 
		sys.objects p --to get any parent object
		ON s.parent_Object_ID = p.[object_ID]
	WHERE  
		Object_Schema_name(s.object_ID) NOT LIKE 'sys%'

	UNION ALL --now search the XML schema collection names

	SELECT 
		DB_NAME() + '.' + name,
		'XML Schema Collection name',
        create_date AS 'created', 
		modify_date AS 'Last Modified'
	FROM
		sys.xml_schema_collections

	UNION ALL

    SELECT 
		DB_NAME() + '.' + name,
		LOWER(type_desc) COLLATE database_default,
        create_date AS 'created', 
		modify_date AS 'Last Modified'
	FROM
		sys.triggers
	WHERE  
		parent_class = 0 --only DDL triggers

	UNION ALL --names of CLR assemblies

	SELECT 
		DB_NAME() + '.' + name,
		'CLR Assembly',
		create_date AS 'created',
		modify_date AS 'Last Modified'
	FROM
		sys.assemblies

	UNION ALL --almost done. We do the agent jobs too here

	SELECT DISTINCT
		'Agent' + '.' + DB_NAME() + '.' + [name] COLLATE database_default,
		'Agent Job', 
		date_created, 
		date_modified
	FROM   
		MSDB.dbo.sysJobs Job 
	INNER JOIN 
		MSDB.dbo.sysJobSteps Step 
		ON Job.Job_Id = Step.Job_Id
WHERE  
	Database_name LIKE DB_NAME() COLLATE database_default) objects
ORDER BY 
	Last_Modified DESC