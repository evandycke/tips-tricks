SELECT 
    t.NAME AS TableName,
    s.Name AS SchemaName,
    p.rows AS RowCounts
FROM 
    sys.tables t
INNER JOIN      
    sys.indexes i 
	ON t.object_id = i.object_id
INNER JOIN 
    sys.partitions p 
	ON i.object_id = p.object_id 
	AND i.index_id = p.index_id
LEFT OUTER JOIN 
    sys.schemas s 
	ON t.schema_id = s.schema_id
WHERE 
    t.NAME NOT LIKE 'dt%' 
	AND t.name like 'E$_%'
    AND t.is_ms_shipped = 0
    AND i.OBJECT_ID > 255 
GROUP BY 
    t.Name, 
	s.Name, 
	p.Rows
HAVING 
	p.rows > 0
ORDER BY 
    p.rows desc, 
	t.Name