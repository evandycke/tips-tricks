SELECT TOP 10
    COUNT(*) AS [Indexes],
    DB_NAME() + '.' + Object_Schema_name(t.object_ID) + '.' + t.name AS [Table]
FROM
    sys.indexes i
INNER JOIN
    sys.objects t
    ON i.object_ID = t.object_ID
    AND i.is_hypothetical = 0
WHERE
    USER_NAME(OBJECTPROPERTY(i.object_id, 'OwnerId')) NOT LIKE 'sys%'
GROUP BY
    DB_NAME() + '.' + Object_Schema_name(t.object_ID) + '.' + t.name
ORDER BY
    COUNT(*) DESC
GO