-- Les tables orphelines (sans contraintes d'intégrité référentielle)
SELECT
  DB_NAME()+'.'+Object_Schema_name(t.object_ID)+'.'+t.name AS [Waif Tables]
FROM
  sys.tables t
WHERE
  OBJECTPROPERTY(object_id, 'TableHasForeignKey')=0
  AND OBJECTPROPERTY(object_id, 'TableHasForeignRef')=0
  AND OBJECTPROPERTY(object_id, 'IsUserTable')=1
ORDER BY
  [Waif tables]