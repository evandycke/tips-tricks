-- Obtient la structure d'une table PostgreSQL
SELECT c.table_schema,
         c.table_name,
         c.column_name,
         c.is_nullable,
         c.data_type,
         c.character_maximum_length,
         c.numeric_precision,
         c.numeric_scale
FROM information_schema.columns c
WHERE (1=1)
        AND c.table_schema = 'monSchema'
        AND c.table_name = 'maTable'
        AND column_name LIKE 'maColonne%'
ORDER BY  c.ordinal_position; 