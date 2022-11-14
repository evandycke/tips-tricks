-- Liste des scénarios dans ODI

SELECT *
FROM SNP_SCEN
WHERE 1=1
        AND SCEN_NAME LIKE '%SDE%'
ORDER BY  SCEN_NAME;