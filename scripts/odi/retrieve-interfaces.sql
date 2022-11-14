-- Retrieve the interface list in ODI

SELECT *
FROM SNP_POP
WHERE 1=1
        AND POP_NAME LIKE '%SDE%'
        AND DISTINCT_ROWS &lt;&gt; 0
ORDER BY  POP_NAME;