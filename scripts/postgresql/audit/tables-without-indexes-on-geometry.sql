-- Répertorie toutes les tables avec des champs Geometry qui n'ont pas d'index sur le champ Geometry

SELECT c.table_schema,
         c.table_name,
         c.column_name
FROM 
    (SELECT *
    FROM information_schema.tables
    WHERE table_type = 'BASE TABLE') AS t
INNER JOIN 
    (SELECT *
    FROM information_schema.columns
    WHERE udt_name = 'geometry') c
    ON (t.table_name = c.table_name
        AND t.table_schema = c.table_schema)
LEFT JOIN pg_catalog.pg_indexes i
    ON (i.tablename = c.table_name
        AND i.schemaname = c.table_schema
        AND indexdef LIKE '%' || c.column_name || '%')
WHERE i.tablename IS NULL
ORDER BY  c.table_schema, c.table_name; 