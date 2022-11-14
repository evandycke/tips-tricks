-- Les tables avec contraintes, valeurs par défaut, règles, déclencheurs, ... et combien
SELECT 
  DB_NAME()+'.'+Object_Schema_name(s.[object_ID])+'.'+p.name AS [Qualified_Name],
  Count(*),
  sum(OBJECTPROPERTY ( s.object_ID , 'IsPrimaryKey')) as [Pk],
  sum(OBJECTPROPERTY ( s.object_ID , 'IsCheckCnst')) as [ChkCns],
  sum(OBJECTPROPERTY ( s.object_ID , 'IsDefaultCnst')) as [DefCns],
  sum(OBJECTPROPERTY ( s.object_ID , 'IsForeignKey')) as [Fk],
  sum(OBJECTPROPERTY ( s.object_ID , 'IsConstraint')) as [Cnstrnt],
  sum(OBJECTPROPERTY ( s.object_ID , 'IsDefault')) as [Default],
  sum(OBJECTPROPERTY ( s.object_ID , 'IsTrigger')) as [Trigger]
  
FROM
  sys.objects S --to get the objects
  inner JOIN sys.objects p
    --to get the parent object so as to get the name of the table
    ON s.parent_Object_ID=p.[object_ID]
WHERE
  OBJECTPROPERTY ( p.object_ID , 'IsTable')<>0
GROUP BY
  DB_NAME()+'.'+Object_Schema_name(s.[object_ID])+'.'+p.name