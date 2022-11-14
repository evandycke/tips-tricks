-- Les tables qui n'ont aucune documentation dans les propriétés étendues
SELECT
	DB_NAME() + '.' + Object_Schema_name(s.[object_ID]) + '.' + s.name AS [Undocumented Table]
FROM
	sys.objects s
LEFT OUTER JOIN 
	sys.extended_properties ep
    ON s.object_ID = ep.major_ID
    AND minor_ID = 0
WHERE
	type_desc = 'USER_TABLE'
	AND ep.value IS NULL
ORDER BY
	1 ASC;