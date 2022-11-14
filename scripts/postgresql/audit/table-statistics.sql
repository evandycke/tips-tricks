-- Refresh statistics by using ANALYSE
--analyse mySchema.myTable;

-- Get content statistics for a table
select 
	s.schemaname as "SCHEMA_NAME",
	s.tablename as "TABLE_NAME",
	s.attname as "COLUMN_NAME",
	c.data_type as "DATA_TYPE",
	coalesce(c.character_maximum_length::varchar(2),'') as "CHARACTER_MAXIMUM_LENGTH",
	case
		when c.is_nullable = 'YES' then 'X'
		else ''
	end as "IS_NULLABLE",
	case
		when s.null_frac = 1.0 then 'X'
		else ''
	end as "IS_EMPTY",
	case
		when s.null_frac = 0.0 then 'X'
		else ''
	end as "IS_FULL",
	s.avg_width as "AVERAGE_WIDTH",
	array_to_string(s.most_common_vals,', ') as "MOST_COMMOM_VALUES"
from 
	pg_stats s
inner join
	information_schema.columns c
	on c.table_schema = s.schemaname
	and c.table_name = s.tablename
	and c.column_name = s.attname
where
	(1=1) 
	and s.schemaname = 'mySchema'
	and s.tablename = 'myTable'
order by
	c.ordinal_position;

