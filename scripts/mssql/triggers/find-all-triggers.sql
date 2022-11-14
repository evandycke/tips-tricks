-- Retrouver les triggers positionnés sur les tables du DHB
SELECT --firstly, we'll search the names of the basic objects
	DB_NAME() + '.' + Object_Schema_name(s.[object_ID]) + p.name AS [Qualified_Name],
	COUNT(*) AS [how many]
FROM
	sys.objects S --to get the objects
INNER JOIN 
	sys.objects p --to get the parent object so as to get the name of the table
    ON s.parent_Object_ID = p.[object_ID]
WHERE
	OBJECTPROPERTY ( s.object_ID , 'IsTrigger') <> 0
	AND OBJECTPROPERTY ( p.object_ID , 'IsTable') <> 0
GROUP BY
	DB_NAME() + '.' + Object_Schema_name(s.[object_ID]) + p.name;

-- Le détail des triggers positionnés sur les tables du DHB
SELECT   
	DB_NAME() + '.' + Object_Schema_name(t.[object_ID]) + '.' + t.name AS [Qualified_Name],
	case when OBJECTPROPERTY ( t.object_ID , 'HasAfterTrigger')<>0 
                                         then 'yes' else 'no' end as [After],
  case when OBJECTPROPERTY ( t.object_ID , 'HasDeleteTrigger') <>0 
                                         then 'yes' else 'no' end as  [Delete],
  case when OBJECTPROPERTY ( t.object_ID , 'HasInsertTrigger') <>0 
                                         then 'yes' else 'no' end as  [Insert],
  case when OBJECTPROPERTY ( t.object_ID , 'HasInsteadOfTrigger') <>0 
                                         then 'yes' else 'no' end as [Instead Of],
  case when OBJECTPROPERTY ( t.object_ID , 'HasUpdateTrigger ')<>0 
                                         then 'yes' else 'no' end as [Update]
 FROM
 sys.tables t;