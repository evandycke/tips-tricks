-- Compare last modification dates of objects

SELECT *
FROM 
    (SELECT DISTINCT SCEN.SCEN_NAME,
         SCEN.LAST_DATE SCEN_LAST_DT,
         PACK.PACK_NAME,
         PACK.LAST_DATE PACK_LAST_DT,
         STPOP.POP_NAME STEP_POP_NAME,
         STPOP.LAST_DATE STEP_POP_LAST_DT,
         POP.POP_NAME,
         POP.LAST_DATE POP_LAST_DT,
        
        CASE
        WHEN ( SCEN.LAST_DATE &gt; coalesce(PACK.LAST_DATE, to_date('20000101','yyyymmdd'))
            AND SCEN.LAST_DATE &gt; coalesce(STPOP.LAST_DATE, to_date('20000101','yyyymmdd'))
            AND SCEN.LAST_DATE &gt; coalesce(POP.LAST_DATE, to_date('20000101','yyyymmdd')) ) THEN
        'Y'
        ELSE 'N'
        END REGENERATED_FLG
    FROM SNP_SCEN SCEN left outer
    JOIN SNP_PACKAGE PACK
        ON SCEN.I_PACKAGE = PACK.I_PACKAGE left outer
    JOIN SNP_STEP STEP
        ON PACK.I_PACKAGE = STEP.I_PACKAGE left outer
    JOIN SNP_POP STPOP
        ON STEP.I_POP = STPOP.I_POP left outer
    JOIN SNP_POP POP
        ON SCEN.I_POP = POP.I_POP
    WHERE 1=1
            AND (STEP.I_POP is NOT null
            OR SCEN.I_POP is NOT null) )
WHERE 1=1
        AND REGENERATED_FLG = 'N'
ORDER BY  SCEN_NAME, PACK_NAME, STEP_POP_NAME, POP_NAME;