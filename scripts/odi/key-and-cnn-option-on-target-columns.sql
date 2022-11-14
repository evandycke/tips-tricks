-- Key and Check Not Null option on target columns

SELECT P.POP_NAME,
         PC.COL_NAME,
         PC.IND_KEY_UPD,
         PC.CHECK_NOT_NULL
FROM SNP_POP P
INNER JOIN SNP_POP_COL PC
    ON P.I_POP = PC.I_POP
WHERE 1=1
        AND (PC.IND_KEY_UPD = 1
        OR PC.CHECK_NOT_NULL = 1)
ORDER BY  P.POP_NAME, PC.COL_NAME;