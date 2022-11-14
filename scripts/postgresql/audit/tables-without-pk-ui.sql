-- Renvoie toutes les tables non-système sur lesquelles il manque une clé primaire et/ou des index uniques
SELECT c.table_schema,
         c.table_name,
         c.table_type
FROM information_schema.tables c
WHERE c.table_schema NOT IN('information_schema', 'pg_catalog')
        AND c.table_type = 'BASE TABLE'
        AND NOT EXISTS
    (SELECT i.tablename
    FROM pg_catalog.pg_indexes i
    WHERE i.schemaname = c.table_schema
            AND i.tablename = c.table_name
            AND indexdef LIKE '%UNIQUE%')
        AND NOT EXISTS 
    (SELECT cu.table_name
    FROM information_schema.key_column_usage cu
    WHERE cu.table_schema = c.table_schema
            AND cu.table_name = c.table_name)
ORDER BY  c.table_schema, c.table_name;