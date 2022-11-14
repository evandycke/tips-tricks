-- Les tables sans index clustered
SELECT
  DB_NAME()+'.'+Object_Schema_name(t.object_ID)+'.'+t.name AS [Tables without Clustered index]
FROM
  sys.tables t
WHERE
  OBJECTPROPERTY(object_id, 'TableHasClustIndex')=0
order by [Tables without Clustered index];

-- Les tables sans index
SELECT
  DB_NAME()+'.'+Object_Schema_name(t.object_ID)+'.'+t.name AS [Tables without any index]
FROM
  sys.tables t
WHERE
  OBJECTPROPERTY(object_id, 'TableHasIndex')=0
order by [Tables without any index];