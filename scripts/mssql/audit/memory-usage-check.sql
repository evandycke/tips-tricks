-- V�rification de l'utilisation m�moire
SELECT 
	object_name, 
	counter_name, 
	cntr_value
FROM 
	sys.dm_os_performance_counters
WHERE 
	[object_name] LIKE '%Buffer Manager%'
	AND [counter_name] in ('Page life expectancy','Free list stalls/sec', 'Page reads/sec')

-- Page Life Expectancy: It�s Lifetime of the pages in the cache. The recommended value is over 300 sec.
-- Free List Stalls/sec: The number of requests that have to wait for a free page. If this value is high, your server is under memory pressure.
-- Page Reads/sec: If this counter has a high value this will confirm the memory pressure already highlighted by two counters