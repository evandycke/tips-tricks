-- Les tables sans PK
SELECT --we'll do it via information_Schema
  TheTables.Table_Catalog+'.'+TheTables.Table_Schema+'.'
                        +TheTables.Table_Name AS [tables without primary keys]
FROM
  information_Schema.tables TheTables
  LEFT OUTER JOIN information_Schema.table_constraints TheConstraints
    ON TheTables.table_Schema=TheConstraints.table_schema
       AND TheTables.table_name=TheConstraints.table_name
       AND constraint_type='PRIMARY KEY'
WHERE table_Type='BASE TABLE'
  AND constraint_name IS NULL
ORDER BY [tables without primary keys]