-- Le top 20 des requêtes les plus longues
SELECT 
	DISTINCT TOP 20
	est.TEXT AS QUERY,
	Db_name(dbid),
	eqs.execution_count AS EXEC_CNT,
	eqs.max_elapsed_time AS MAX_ELAPSED_TIME,
	ISNULL(eqs.total_elapsed_time / NULLIF(eqs.execution_count,0), 0) AS AVG_ELAPSED_TIME,
	eqs.creation_time AS CREATION_TIME,
	ISNULL(eqs.execution_count / NULLIF(DATEDIFF(s, eqs.creation_time, GETDATE()),0), 0) AS EXEC_PER_SECOND,
	total_physical_reads AS AGG_PHYSICAL_READS
FROM 
	sys.dm_exec_query_stats eqs
CROSS APPLY 
	sys.dm_exec_sql_text( eqs.sql_handle ) est
ORDER BY
	eqs.max_elapsed_time DESC