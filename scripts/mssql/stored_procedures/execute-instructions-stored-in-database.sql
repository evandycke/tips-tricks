

DECLARE @sql NVARCHAR(MAX)

DECLARE cur CURSOR FOR
WITH Referentiel(NumRequete, InstructionSql)
AS
(SELECT
    T.NUM_REQUETE,
    T.INSTRUCTION_SQL
FROM
    dbo.Referentiel T)
SELECT
    R.InstructionSql
FROM
    Referentiel R
ORDER BY
    R.NumRequete

OPEN cur
FETCH NEXT FROM cur INTO @sql
WHILE @@FETCH_STATUS = 0 BEGIN
    print @sql
    --EXEC sp_executesql @sql
    FETCH NEXT FROM cur INTO @sql
END

CLOSE cur
DEALLOCATE cur
GO

