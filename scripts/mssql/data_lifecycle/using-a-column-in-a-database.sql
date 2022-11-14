select distinct
	c.TABLE_SCHEMA,
	c.TABLE_NAME 
from 
	DHB_PRE.INFORMATION_SCHEMA.columns c
inner join
	DHB_PRE.INFORMATION_SCHEMA.TABLES t
	on t.TABLE_CATALOG = c.TABLE_CATALOG
	and t.TABLE_SCHEMA = c.TABLE_SCHEMA
	and t.TABLE_NAME = c.TABLE_NAME
where 
	(1=1)
	and	c.COLUMN_NAME = 'maColonne'
	and t.TABLE_TYPE = 'BASE TABLE'
	and c.TABLE_SCHEMA in ('schema1','schema2');