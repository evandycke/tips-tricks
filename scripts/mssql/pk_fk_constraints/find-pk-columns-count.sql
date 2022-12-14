SELECT 
	TC.TABLE_CATALOG, 
	TC.TABLE_SCHEMA, 
	TC.TABLE_NAME, 
	TC.CONSTRAINT_NAME,
	COUNT(KCU.COLUMN_NAME) AS COLUMNS_COUNT
FROM 
	INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC
LEFT OUTER JOIN
	INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCU
	ON KCU.CONSTRAINT_CATALOG = TC.CONSTRAINT_CATALOG
	AND KCU.CONSTRAINT_SCHEMA = TC.CONSTRAINT_SCHEMA
	AND KCU.CONSTRAINT_NAME = TC.CONSTRAINT_NAME
WHERE 
	(1=1)
	AND TC.CONSTRAINT_TYPE = 'PRIMARY KEY'
	AND TC.TABLE_SCHEMA = 'REF'
GROUP BY
	TC.TABLE_CATALOG, 
	TC.TABLE_SCHEMA, 
	TC.TABLE_NAME, 
	TC.CONSTRAINT_NAME
ORDER BY
	5 DESC, 
	TABLE_CATALOG ASC, 
	TABLE_SCHEMA ASC, 
	TABLE_NAME ASC;