-- Obtient les colonnes composant une table PostgreSQL
select 
	table_schema,
    table_name,
    ordinal_position as position,
    column_name,
    data_type,
    case
		when character_maximum_length is not null then character_maximum_length
        else numeric_precision 
	end as max_length,
    is_nullable,
    column_default as default_value
from
	information_schema.columns
where 
	(1=1)
	and table_schema not in ('information_schema', 'pg_catalog')
	and table_name = 'R_CENTRE_PAIE_HO'
order by 
	table_schema, 
    table_name,
    ordinal_position;