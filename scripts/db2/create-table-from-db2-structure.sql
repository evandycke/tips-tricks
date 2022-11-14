-- Génère une ordre CREATE pour SQL Server à partir des tables systèmes
select create_order
from (
        select 0 as ordre ,'CREATE TABLE ' || upper('maTable') ||'(' as create_order
        from sysibm.sysdummy1
    union all
        select ordinal_position as ordre, '    ' || upper(column_name) || '    ' 
                || CASE WHEN (DATA_TYPE in ('CHAR') ) THEN 'VARCHAR('
                        WHEN (DATA_TYPE = 'DECIMAL' ) THEN 'NUMERIC('
                        ELSE DATA_TYPE || '('
                END
                || TRIM(CAST(LENGTH as CHAR(8)))
                || CASE WHEN (DATA_TYPE in ('NUMERIC','DECIMAL'))
                        THEN ',' || NUMERIC_SCALE || ')'
                        ELSE ')'
                END
                || CASE WHEN (ORDINAL_POSITION=(SELECT MAX(ORDINAL_POSITION)
                                                FROM qsys2.syscolumns
                                                WHERE table_name='maTable' and table_schema='monSchema' ) )
                        THEN ' '
                        ELSE ','
                END
                || '        -- ' || COLUMN_TEXT
        from qsys2.syscolumns
        WHERE table_name='maTable' and table_schema='monSchema'
    union all
        select 999 as ordre,');'
        from sysibm.sysdummy1
) as T
order by ordre