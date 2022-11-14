-- Renvoie toutes les tables non-système sur lesquelles il manque une clé primaire
SELECT c.table_schema,
         c.table_name,
         c.table_type
FROM information_schema.tables c
WHERE c.table_type = 'BASE TABLE'
        AND c.table_schema NOT IN('information_schema', 'pg_catalog')
        AND NOT EXISTS 
    (SELECT cu.table_name
    FROM information_schema.key_column_usage cu
    WHERE cu.table_schema = c.table_schema
            AND cu.table_name = c.table_name)
ORDER BY  c.table_schema, c.table_name;