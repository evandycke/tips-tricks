SELECT *
FROM 
    (SELECT DISTINCT T_PCK.pack_name NomPackage,
         T_STP.NNO NumeroStep,
         'INT' TypeStep, T_STP.STEP_NAME NomStep, SNP_POP.POP_NAME NomReelStep, snp_pop.LSCHEMA_NAME SchemaCible, snp_pop.TABLE_NAME TableCible, SNP_POP_COL.COL_NAME ColonneCible,'' InterfaceSource, SNP_SOURCE_TAB.LSCHEMA_NAME SchemaSource,SNP_SOURCE_TAB.table_name TableSource,SNP_COL.COL_NAME ColonneSource, SNP_SOURCE_TAB.SRC_TAB_ALIAS AliasTableSource, TXT.STRING_ELT Texte,'MAPPING' TypeTexte
    FROM SNP_PROJECT LEFT OUTER
    JOIN SNP_FOLDER
        ON SNP_FOLDER.I_PROJECT=SNP_PROJECT.I_PROJECT LEFT OUTER
    JOIN SNP_POP
        ON SNP_POP.I_FOLDER=SNP_FOLDER.I_FOLDER LEFT OUTER
    JOIN SNP_POP_COL
        ON SNP_POP_COL.I_POP=SNP_POP.I_POP LEFT OUTER
    JOIN SNP_POP_CLAUSE
        ON SNP_POP_CLAUSE.I_POP=SNP_POP.I_POP LEFT OUTER
    JOIN SNP_POP_MAPPING MAP
        ON SNP_POP_COL.I_POP_COL=MAP.I_POP_COL
    LEFT JOIN SNP_TXT_CROSSR TXT
        ON TXT.I_TXT= MAP.I_TXT_MAP
    LEFT JOIN snp_data_set ds
        ON ds.i_pop = snp_pop.i_pop LEFT OUTER
    JOIN SNP_SOURCE_TAB
        ON SNP_SOURCE_TAB.I_DATA_SET=ds.I_DATA_SET LEFT OUTER
    JOIN SNP_COL
        ON SNP_COL.I_COL=TXT.I_COL
    JOIN SNP_TABLE
        ON SNP_TABLE.I_TABLE= SNP_COL.I_TABLE LEFT OUTER
    JOIN SNP_COL T_COL
        ON T_COL.I_COL=SNP_POP_COL.I_COL LEFT OUTER
    JOIN SNP_STEP T_STP
        ON T_STP.I_POP=SNP_POP.I_POP LEFT OUTER
    JOIN SNP_PACKAGE T_PCK
        ON T_PCK.I_PACKAGE=T_STP.I_PACKAGE
    UNION ALL
    SELECT DISTINCT T_PCK.pack_name NomPackage,
         T_STP.NNO NumeroStep,
         'INT' TypeStep, T_STP.STEP_NAME NomStep, SNP_POP.POP_NAME NomReelStep, snp_pop.LSCHEMA_NAME SchemaCible, snp_pop.TABLE_NAME TableCible, SNP_POP_COL.COL_NAME ColonneCible,SUB_POP.pop_name InterfaceSource,SNP_SOURCE_TAB.LSCHEMA_NAME SchemaSource,sub_pop.table_name TableSource,COL.COL_NAME ColonneSource, SNP_SOURCE_TAB.SRC_TAB_ALIAS AliasTableSource, TXT.STRING_ELT Texte,'MAPPING' TypeTexte
    FROM SNP_PROJECT LEFT OUTER
    JOIN SNP_FOLDER
        ON SNP_FOLDER.I_PROJECT=SNP_PROJECT.I_PROJECT LEFT OUTER
    JOIN SNP_POP
        ON SNP_POP.I_FOLDER=SNP_FOLDER.I_FOLDER LEFT OUTER
    JOIN SNP_POP_COL
        ON SNP_POP_COL.I_POP=SNP_POP.I_POP LEFT OUTER
    JOIN SNP_POP_CLAUSE
        ON SNP_POP_CLAUSE.I_POP=SNP_POP.I_POP LEFT OUTER
    JOIN SNP_TXT TX
        ON TX.I_TXT=SNP_POP_CLAUSE.I_TXT_SQL LEFT OUTER
    JOIN SNP_POP_MAPPING MAP
        ON SNP_POP_COL.I_POP_COL=MAP.I_POP_COL
    LEFT JOIN SNP_TXT_CROSSR TXT
        ON TXT.I_TXT= MAP.I_TXT_MAP
    LEFT JOIN snp_data_set ds
        ON ds.i_pop = snp_pop.i_pop LEFT OUTER
    JOIN SNP_SOURCE_TAB
        ON SNP_SOURCE_TAB.I_DATA_SET=ds.I_DATA_SET
    JOIN SNP_POP SUB_POP
        ON SUB_POP.I_POP=SNP_SOURCE_TAB.I_POP_SUB
    INNER JOIN SNP_POP_COL col
        ON col.I_POP=SUB_POP.I_POP LEFT OUTER
    JOIN SNP_STEP T_STP
        ON T_STP.I_POP=SNP_POP.I_POP LEFT OUTER
    JOIN SNP_PACKAGE T_PCK
        ON T_PCK.I_PACKAGE=T_STP.I_PACKAGE
    WHERE instr(TXT.STRING_ELT,col.COL_NAME)>0
    UNION ALL
    SELECT T_PCK.pack_name NomPackage,
         T_STP.NNO NumeroStep,
         'INT' TypeStep, T_STP.STEP_NAME NomStep, SNP_POP.POP_NAME NomReelStep, '','','','','','','','', dbms_lob.substr( snp_txt_header.FULL_TEXT, 4000, 1 ) Texte,CASE
        WHEN snp_pop_clause.clause_type=3 THEN
        'FILTRE'
        ELSE 'JOINTURE'
        END TypeTexte
    FROM snp_pop
    INNER JOIN SNP_DATA_SET
        ON snp_pop.i_pop=snp_data_set.i_pop
    INNER JOIN SNP_POP_CLAUSE
        ON snp_data_set.i_data_set=snp_pop_clause.i_data_set
    INNER JOIN SNP_TXT_HEADER
        ON snp_pop_clause.i_txt_sql=snp_txt_header.i_txt LEFT OUTER
    JOIN SNP_STEP T_STP
        ON T_STP.I_POP=SNP_POP.I_POP LEFT OUTER
    JOIN SNP_PACKAGE T_PCK
        ON T_PCK.I_PACKAGE=T_STP.I_PACKAGE
    UNION ALL
    SELECT DISTINCT PACK.PACK_NAME NomPackage,
         stp.nno NumeroStep,
         'TRT' TypeStep, stp.step_name NomStep, trt.TRT_NAME NomReelStep, '','','','', ltrt.DEF_LSCHEMA_NAME SchemaSource ,'','',LTRT.SQL_NAME Tache, dbms_lob.substr( H.FULL_TEXT, 4000, 1 ) Texte,'TRAITEMENT' TypeTexte
    FROM SNP_PACKAGE PACK
    LEFT JOIN SNP_STEP stp
        ON PACK.i_package = stp.i_package
    INNER JOIN SNP_TRT trt
        ON stp.I_trt=trt.I_trt LEFT OUTER
    JOIN SNP_LINE_TRT LTRT
        ON trt.I_TRT=LTRT.I_TRT LEFT OUTER
    JOIN SNP_TXT_HEADER H
        ON LTRT.DEF_I_TXT=H.I_TXT LEFT OUTER
    JOIN SNP_MODEL model
        ON model.LSCHEMA_NAME=ltrt.DEF_LSCHEMA_NAME
    LEFT JOIN ORA_DIAG_TOPO topo
        ON model.LSCHEMA_NAME=topo.LSCHEMA_NAME
    UNION ALL
    SELECT DISTINCT PACK.PACK_NAME NomPackage,
         stp.nno NumeroStep,
         'VAR' TypeStep, stp.step_name NomStep, var.VAR_NAME NomReelStep, '','','','', var.LSCHEMA_NAME SchemaSource, '','','', dbms_lob.substr( H.FULL_TEXT, 4000, 1 ) Texte,'VARIABLE' TypeTexte
    FROM SNP_PACKAGE PACK
    LEFT JOIN SNP_STEP stp
        ON PACK.i_package = stp.i_package
    INNER JOIN SNP_VAR var
        ON stp.I_VAR=var.I_VAR LEFT OUTER
    JOIN SNP_TXT_HEADER H
        ON H.I_TXT=var.I_TXT_VAR_IN LEFT OUTER
    JOIN snp_model model
        ON model.LSCHEMA_NAME=var.LSCHEMA_NAME
    LEFT JOIN ORA_DIAG_TOPO topo
        ON model.LSCHEMA_NAME=topo.LSCHEMA_NAME )
WHERE (1=1)
        AND tablecible LIKE '%T_PROJET_DEV_IMM%' --AND schemacible='POSTGRES_DWH_DWH' --AND nompackage='P_DEC_ODSOUT_TDB_CODIR_DEV_IMMO_DGA_4B'
        AND upper(colonnecible) = 'NUMERO_OPERATION'