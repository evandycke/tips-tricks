

DECLARE @sql VARCHAR(8000)
DECLARE @DateBcp VARCHAR(23)
SET @DateBcp = REPLACE(CONVERT(VARCHAR(23), GETDATE(), 126),':','-')

DECLARE cur CURSOR FOR
WITH ListTables(Catalogue,[Schema],Nom)
AS
(SELECT
    T.TABLE_CATALOG,
    T.TABLE_SCHEMA,
    T.TABLE_NAME
FROM
    INFORMATION_SCHEMA.TABLES T),

CommandeBcp(script)
AS
(SELECT
    'bcp "' + DB_NAME() + '.dbo.' + T.Nom + '" queryout c:\bcp\' + T.Nom + '_' + @DateBcp + '.dat -c -C ACP -T -S ' + @@servername
FROM
    ListTables T
)

SELECT C.script FROM CommandeBcp C
OPEN cur
FETCH NEXT FROM cur INTO @sql
WHILE @@FETCH_STATUS = 0 BEGIN
    print @sql
    --exec master..xp_cmdshell @sql
    FETCH NEXT FROM cur INTO @sql
END

CLOSE cur
DEALLOCATE cur
GO

