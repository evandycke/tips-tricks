-- Recherche d'une colonne dans les tables système
SELECT SYSTEM_TABLE_SCHEMA,
         SYSTEM_TABLE_NAME,
         SYSTEM_COLUMN_NAME,
         COLUMN_TEXT,
         DATA_TYPE,
         LENGTH
FROM QSYS2.SYSCOLUMNS
WHERE UPPER(COLUMN_NAME) LIKE '%MUTCA%'
ORDER BY  1 asc, 2 asc, 3 asc;