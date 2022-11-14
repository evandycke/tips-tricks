-- Data lineage

select distinct 
 
  -- FOLDERS : more levels can be included, if needed (update the join conditions accordingly)
  PROJECT.PROJECT_NAME PROJECT,
  FOLDER_LVL1.FOLDER_NAME LVL1_FOLDER,
  FOLDER_LVL2.FOLDER_NAME LVL2_FOLDER,
   
  --INTERFACE
  I.POP_NAME INTERFACE,
  case when I.WSTAGE = 'E' then 'N' else 'Y' end TEMPORARY_INTERFACE, -- WSTAGE can be: E - Existing target or N,W - Temporary target
   
  -- SOURCE
  SRC_TMP.POP_NAME SOURCE_TMP, -- temporary interface as the source
  SRC_MOD.MOD_NAME SOURCE_MODEL,
  SRC_TAB.TABLE_NAME SOURCE_TABLE,
  SRC_TAB.RES_NAME SOURCE_TABLE_RES_NAME,
  SRC_COL.COL_NAME SOURCE_COLUMN,
  SRC_COL.SOURCE_DT || '(' || SRC_COL.LONGC || case when SRC_COL.SCALEC is not null then ',' || SRC_COL.SCALEC else '' end || ')' SOURCE_COLUMN_DATATYPE,
   
  -- TARGET
  TGT_MOD.MOD_NAME TARGET_MODEL,   
  case when I.WSTAGE = 'E' then TGT_TAB.TABLE_NAME || '(' || TGT_TAB.RES_NAME || ')' else I.TABLE_NAME end TARGET_TABLE,
  case when I.WSTAGE = 'E' then TGT_TAB.RES_NAME else null end TARGET_TABLE_RES_NAME,
  case when I.WSTAGE = 'E' then TGT_COL.COL_NAME else TGT_POP_COL.COL_NAME end TARGET_COLUMN,
  case
    when I.WSTAGE = 'E' then TGT_COL.SOURCE_DT || '(' || TGT_COL.LONGC || case when TGT_COL.SCALEC is not null then ',' || TGT_COL.SCALEC else '' end || ')'
    else TGT_POP_COL.SOURCE_DT || '(' || TGT_POP_COL.LONGC || case when TGT_POP_COL.SCALEC is not null then ',' || TGT_POP_COL.SCALEC else '' end || ')'
  end TARGET_COLUMN_DATATYPE,
  case when TGT_POP_COL.IND_KEY_UPD = 1 then 'Y' else null end PRIMARY_KEY,
   
  -- MAPPING VALUE
  MAP_VAL_FULL.STRING_ELT FULL_ELT_STRING
 
from SNP_PROJECT PROJECT
  left outer join SNP_FOLDER FOLDER_LVL1 on FOLDER_LVL1.I_PROJECT = PROJECT.I_PROJECT -- FIRST FOLDER LEVEL
  left outer join SNP_FOLDER FOLDER_LVL2 on FOLDER_LVL2.PAR_I_FOLDER = FOLDER_LVL1.I_FOLDER -- SECOND FOLDER LEVEL
 
  left outer join SNP_POP I on I.I_FOLDER = FOLDER_LVL2.I_FOLDER -- INTERFACES IN THE 2nd LEVEL FOLDER
 
  left outer join SNP_POP_COL TGT_POP_COL on TGT_POP_COL.I_POP = I.I_POP -- TARGET COLUMNS OF THE INTERFACES
  left outer join SNP_COL TGT_COL on TGT_COL.I_COL = TGT_POP_COL.I_COL -- TARGET COLUMNS DETAILS
  left outer join SNP_TABLE TGT_TAB on TGT_TAB.I_TABLE = TGT_COL.I_TABLE -- TARGET TABLE DETAILS
  left outer join SNP_MODEL TGT_MOD on TGT_MOD.I_MOD = TGT_TAB.I_MOD -- TARGET TABLE MODEL
 
  left outer join SNP_POP_MAPPING MAP on MAP.I_POP_COL = TGT_POP_COL.I_POP_COL 
  left outer join SNP_TXT_CROSSR MAP_VAL on MAP_VAL.I_TXT = MAP.I_TXT_MAP and MAP_VAL.OBJECT_TYPE in ('C', 'P', 'V') 
  left outer join SNP_COL SRC_COL on SRC_COL.I_COL = MAP_VAL.I_COL -- SOURCE COLUMN DETAILS
  left outer join SNP_TABLE SRC_TAB on SRC_TAB.I_TABLE = SRC_COL.I_TABLE -- SOURCE TABLE DETAILS
  left outer join SNP_MODEL SRC_MOD on SRC_MOD.I_MOD = SRC_TAB.I_MOD -- SOURCE TABLE MODEL
  left outer join SNP_DATA_SET DATA_SET on I.I_POP = DATA_SET.I_POP 
  left outer join SNP_SOURCE_TAB SOURCE_TAB on DATA_SET.I_DATA_SET = SOURCE_TAB.I_DATA_SET
  left outer join SNP_POP SRC_TMP on SOURCE_TAB.I_POP_SUB = SRC_TMP.I_POP -- TEMPORARY SOURCE
 
  left outer join (
    select I_TXT, STRING_POS, STRING_ELT, ROW_NUMBER() over (partition by I_TXT order by length(STRING_ELT) desc) POS 
    from SNP_TXT_CROSSR 
   ) MAP_VAL_FULL on MAP_VAL_FULL.I_TXT = MAP_VAL.I_TXT and MAP_VAL_FULL.POS = 1
 
where 1=1 -- FILTERS
  and PROJECT.PROJECT_NAME = 'BI Apps Project' -- by Project name
  and FOLDER_LVL1.FOLDER_NAME like 'Custom_%' -- by 1st Level Folder name
  and FOLDER_LVL2.FOLDER_NAME = 'SDE_ORA_%' -- by 2nd Level Folder name
  and I.POP_NAME not like 'Copy%' -- by Interface name
  and SRC_TAB.TABLE_NAME like '%WC_LHA%PS%' -- by Source Table name
  and SRC_COL.COL_NAME like '%EMPLOYEE_ID' -- by Source Column name
  and TGT_TAB.TABLE_NAME like '%_DS' -- by Target Table name
  and TGT_COL.COL_NAME like '%EMPLOYEE_ID'  -- by Target Column name
  and MAP_VAL_FULL.STRING_ELT like '%COALESCE(%' -- by Mapping Value
         
order by 
  PROJECT.PROJECT_NAME
  , FOLDER_LVL1.FOLDER_NAME
  , FOLDER_LVL2.FOLDER_NAME 
  , I.POP_NAME 
  , SRC_COL.COL_NAME
  , case when I.WSTAGE = 'E' then TGT_COL.COL_NAME else TGT_POP_COL.COL_NAME end
;