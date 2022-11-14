PRINT N'-- DROP FOREIGN KEY CONSTRAINTS --';

SET NOCOUNT ON;

SELECT '
PRINT N''Dropping ' + fk.NAME + '...''
GO
ALTER TABLE [' + sch.NAME + '].[' + OBJECT_NAME(fk.parent_object_id) + ']' + ' DROP  CONSTRAINT ' + '[' + fk.NAME + ']
GO'
FROM sys.foreign_keys AS fk
INNER JOIN sys.schemas AS sch ON sch.schema_id = fk.schema_id
ORDER BY fk.NAME





PRINT N'-- CREATE FOREIGN KEY CONSTRAINTS --';

SET NOCOUNT ON;
SELECT '
PRINT N''Creating '+ const.const_name +'...''
GO
ALTER TABLE ' + const.parent_obj + '
    ADD CONSTRAINT ' + const.const_name + ' FOREIGN KEY (
            ' + const.parent_col_csv + '
            ) REFERENCES ' + const.ref_obj + '(' + const.ref_col_csv + ')
GO'
FROM (
    SELECT QUOTENAME(fk.NAME) AS [const_name]
        ,QUOTENAME(schParent.NAME) + '.' + QUOTENAME(OBJECT_name(fkc.parent_object_id)) AS [parent_obj]
        ,STUFF((
                SELECT ',' + QUOTENAME(COL_NAME(fcP.parent_object_id, fcp.parent_column_id))
                FROM sys.foreign_key_columns AS fcP
                WHERE fcp.constraint_object_id = fk.object_id
                FOR XML path('')
                ), 1, 1, '') AS [parent_col_csv]
        ,QUOTENAME(schRef.NAME) + '.' + QUOTENAME(OBJECT_NAME(fkc.referenced_object_id)) AS [ref_obj]
        ,STUFF((
                SELECT ',' + QUOTENAME(COL_NAME(fcR.referenced_object_id, fcR.referenced_column_id))
                FROM sys.foreign_key_columns AS fcR
                WHERE fcR.constraint_object_id = fk.object_id
                FOR XML path('')
                ), 1, 1, '') AS [ref_col_csv]
    FROM sys.foreign_key_columns AS fkc
    INNER JOIN sys.foreign_keys AS fk ON fk.object_id = fkc.constraint_object_id
    INNER JOIN sys.objects AS oParent ON oParent.object_id = fkc.parent_object_id
    INNER JOIN sys.schemas AS schParent ON schParent.schema_id = oParent.schema_id
    INNER JOIN sys.objects AS oRef ON oRef.object_id = fkc.referenced_object_id
    INNER JOIN sys.schemas AS schRef ON schRef.schema_id = oRef.schema_id
    GROUP BY fkc.parent_object_id
        ,fkc.referenced_object_id
        ,fk.NAME
        ,fk.object_id
        ,schParent.NAME
        ,schRef.NAME
    ) AS const
ORDER BY const.const_name