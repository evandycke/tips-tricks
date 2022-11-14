-- On liste l'ensemble des dépendances de la base de données
SELECT
	Object_Schema_name(object_id) + '.' + COALESCE(OBJECT_NAME(object_id), 'unknown') + COALESCE('.' + COL_NAME(object_id, column_id), '') AS [Referencer],
	Object_Schema_name(referenced_major_id) + '.' + OBJECT_NAME(referenced_major_id) + COALESCE('.' + COL_NAME(referenced_major_id, referenced_minor_id), '') AS [Referenced]
FROM
	sys.sql_dependencies
WHERE
	class IN (0, 1)
ORDER BY
	COALESCE(OBJECT_NAME(object_id), 'x') ASC,
	COALESCE(COL_NAME(object_id, column_id), 'a') ASC