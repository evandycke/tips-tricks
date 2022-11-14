SELECT 'DROP INDEX ' + QUOTENAME(i.name)  + ' ON ' + QUOTENAME(SCHEMA_NAME(o.schema_id)) +'.'+ QUOTENAME(OBJECT_NAME(i.object_id)) + ';'
FROM sys.indexes AS i
INNER JOIN sys.objects AS o ON i.[object_id] = o.[object_id]
WHERE i.is_hypothetical = 1