-- Check a fillfactor value for tables and indexes
SELECT pc.relname AS ObjectName ,
        pc.reloptions AS ObjectOptions
FROM pg_class AS pc
INNER JOIN pg_namespace AS pns
    ON pns.oid = pc.relnamespace
WHERE pns.nspname = 'public'
        AND pc.relname = 'Table_Name';