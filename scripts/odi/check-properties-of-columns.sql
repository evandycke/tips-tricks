-- Check the properties of table columns

SELECT *
FROM SNP_COL
WHERE I_COL IN 
    (SELECT C.I_COL
    FROM SNP_MODEL M
    INNER JOIN SNP_TABLE T
        ON T.I_MOD = M.I_MOD
    INNER JOIN SNP_COL C
        ON C.I_TABLE = T.I_TABLE
    WHERE 1=1 --and MOD_NAME LIKE 'mod_name'
            AND T.TABLE_NAME LIKE 'EMP_CONTACTS' --and SOURCE_DT = 'STRING' );