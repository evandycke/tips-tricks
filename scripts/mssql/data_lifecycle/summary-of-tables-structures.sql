-- Une synthèse de la structure des tables du DHB
SELECT 
DB_NAME()+'.'+Object_Schema_name(t.object_ID)+'.'
                                                    +t.name  AS [Qualified Name],
  CASE WHEN OBJECTPROPERTY(object_id,'TableHasActiveFulltextIndex') = 0  
       THEN 'no' ELSE 'yes' END AS  [FT index],--Table has an active full-text index.
  CASE WHEN OBJECTPROPERTY(object_id,'TableHasCheckCnst') = 0  
       THEN 'no' ELSE 'yes' END AS  [Check Cnt],--Table has a CHECK constraint.
  CASE WHEN OBJECTPROPERTY(object_id,'TableHasClustIndex') = 0  
       THEN 'no' ELSE 'yes' END AS  [Clustered ix],--Table has a clustered index.
  CASE WHEN OBJECTPROPERTY(object_id,'TableHasDefaultCnst') = 0  
       THEN 'no' ELSE 'yes' END AS  [Default Cnt],--Table has a DEFAULT constraint.
  CASE WHEN OBJECTPROPERTY(object_id,'TableHasDeleteTrigger') = 0  
       THEN 'no' ELSE 'yes' END AS  [Delete Tgr],--Table has a DELETE trigger.
  CASE WHEN OBJECTPROPERTY(object_id,'TableHasForeignKey') = 0  
       THEN 'no' ELSE 'yes' END AS  [FK Cnt],--Table has a FOREIGN KEY constraint.
  CASE WHEN OBJECTPROPERTY(object_id,'TableHasForeignRef') = 0  
       THEN 'no' ELSE 'yes' END AS  [FK Ref],--referenced by a FOREIGN KEY constraint.
  CASE WHEN OBJECTPROPERTY(object_id,'TableHasIdentity') = 0  
       THEN 'no' ELSE 'yes' END AS  [Identity Col],--Table has an identity column.
  CASE WHEN OBJECTPROPERTY(object_id,'TableHasIndex') = 0  
       THEN 'no' ELSE 'yes' END AS  [Any index],--Table has an index of any type.
  CASE WHEN OBJECTPROPERTY(object_id,'TableHasInsertTrigger') = 0  
       THEN 'no' ELSE 'yes' END AS  [Insert Tgr],--Object has an INSERT trigger.
  CASE WHEN OBJECTPROPERTY(object_id,'TableHasNonclustIndex') = 0  
       THEN 'no' ELSE 'yes' END AS  [nonCl Index],--Table has a nonclustered index.
  CASE WHEN OBJECTPROPERTY(object_id,'TableHasPrimaryKey') = 0  
       THEN 'no' ELSE 'yes' END AS  [Primary Key],--Table has a primary key
  CASE WHEN OBJECTPROPERTY(object_id,'TableHasRowGuidCol') = 0  
       THEN 'no' ELSE 'yes' END AS  [ROWGUIDCOL],--ROWGUIDCOL for uniqueidentifier col
  CASE WHEN OBJECTPROPERTY(object_id,'TableHasTextImage') = 0  
       THEN 'no' ELSE 'yes' END AS  [Has Blob],--Table has text, ntext, or image column
  CASE WHEN OBJECTPROPERTY(object_id,'TableHasTimestamp') = 0  
       THEN 'no' ELSE 'yes' END AS  [Timestamp],--Table has a timestamp column.
  CASE WHEN OBJECTPROPERTY(object_id,'TableHasUniqueCnst') = 0  
       THEN 'no' ELSE 'yes' END AS  [Unique Cnt],--Table has a UNIQUE constraint.
  CASE WHEN OBJECTPROPERTY(object_id,'TableHasUpdateTrigger') = 0  
       THEN 'no' ELSE 'yes' END AS  [Update Tgr]--Table has an Update trigger. 
FROM sys.tables t
ORDER BY [Qualified Name]