-- List of models, sub-models, tables with the corresponding parent folders and last userdate details
SELECT DISTINCT --* MF.I_MOD_FOLDER,
         MF.MOD_FOLDER_NAME,
         M.I_MOD,
         M.MOD_NAME,
         M.LSCHEMA_NAME,
         M.LAST_DATE MOD_LAST_DATE,
         M.LAST_USER MOD_LAST_USER,
         SM.I_SMOD,
         SM.SMOD_NAME,
         SM.LAST_DATE SMOD_LAST_DATE,
         SM.LAST_USER SMOD_LAST_USER,
         T.I_TABLE,
         T.TABLE_NAME,
         T.LAST_DATE TAB_LAST_DATE,
         T.LAST_USER TAB_LAST_USER
FROM SNP_MODEL M -- PARENT FOLDER left outer
JOIN SNP_MOD_FOLDER MF
    ON M.I_MOD_FOLDER = MF.I_MOD_FOLDER -- MODEL left outer
JOIN SNP_SUB_MODEL SM
    ON M.I_MOD = SM.I_MOD -- SUB-MODEL left outer
JOIN SNP_TABLE T
    ON SM.I_MOD = T.I_MOD
        AND SM.I_SMOD = T.I_SUB_MODEL -- TABLE
WHERE 1=1 --and MF.MOD_FOLDER_NAME LIKE '%' --and M.MOD_NAME LIKE '%' --and SM.SMOD_NAME LIKE '%' --and T.TABLE_NAME LIKE '%'
ORDER BY  MF.MOD_FOLDER_NAME, M.MOD_NAME, SM.SMOD_NAME, T.TABLE_NAME;