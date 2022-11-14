-- Vérification de la fragmentation (détaillée) des index
SELECT 
	object_name(IPS.object_id) AS [TableName], 
	SI.name AS [IndexName], 
	IPS.Index_type_desc, 
	IPS.avg_fragmentation_in_percent, 
	IPS.avg_page_space_used_in_percent, 
	IPS.record_count, 
	IPS.ghost_record_count,
	IPS.fragment_count, 
	IPS.avg_fragment_size_in_pages,
	alloc_unit_type_desc,
	index_level 
FROM 
	sys.dm_db_index_physical_stats(db_id(N'NOM_BASE'), NULL, NULL, NULL , 'DETAILED') IPS
JOIN 
	sys.tables ST WITH (nolock) 
	ON IPS.object_id = ST.object_id
JOIN 
	sys.indexes SI WITH (nolock) 
	ON IPS.object_id = SI.object_id 
	AND IPS.index_id = SI.index_id
WHERE 
	ST.is_ms_shipped = 0 
	and (fragment_count * avg_fragment_size_in_pages) > 20
	and index_type_desc in ('NONCLUSTERED INDEX','CLUSTERED INDEX') 
	and index_level <> 0
ORDER BY 
	avg_fragmentation_in_percent desc