-- Suppression en lot des données d'une table 

/*
@startDate: The start date from when to start working with the records.
@endDate: A non-inclusive date to limit when the records will be taken into account. In my example it means that I’m just going to be working with records from >= ‘2015-01-01’ and date < ‘2015-01-06’.
@dbName: The name of the database that hosts the table that you want to work with. Take into account that in this same database the historic and metrics tables are created.
IfIf you’d like to have these 2 tables in separate databases, a few tweaks would have to be made to the stored procedure and an additional parameter would have to be passed to specify the name of the other database.
@schemaName: The name of the schema of the table.
@tableName: The name of the table to be processed.
@d@dateFieldName: The name of the column that contains the timestamp fields to work with. Remember that this logic is written towards a date-based approach; if you want a different one you’d have to adjust the stored procedure to your particular case.
@saveToHistoryTable: If 1, then an identical empty table is created based on @tableName, and the name "_historic" is added to it to distinguish it. If 0, then no data movement will be performed during the execution of the script (use it very carefully).
*/

IF EXISTS (
   SELECT type_desc, type
    FROM sys.procedures WITH(NOLOCK)
    WHERE NAME = 'Batch_Delete'
            AND type = 'P'
)
DROP PROCEDURE Batch_Delete
GO
 
CREATE PROCEDURE Batch_Delete
@startDate          DATE,
@endDate            DATE,
@dbName             VARCHAR(64) = NULL,
@schemaName         VARCHAR(64) = NULL,
@tableName          VARCHAR(64) = NULL,
@dateFieldName      VARCHAR(64) = NULL,
@saveToHistoryTable BIT = 1,
@batch              INT = 1000
AS
  SET NOCOUNT ON
 
  DECLARE @tableExists BIT = 0
  DECLARE @fieldExists BIT = 0
  DECLARE @sqlCommand NVARCHAR(2048)
 
  IF(@startDate > @endDate OR @startDate = @endDate)
  BEGIN
   RAISERROR('startDate can''t be higher or equal than endDate!!!', 16, -1)
   RETURN
  END
 
  IF(@dbName IS NULL OR TRIM(@dbname) = '')
  BEGIN
   RAISERROR('You must specify the source database where the table is hosted!!!', 16, -1)
   RETURN
  END
 
  IF(@schemaName IS NULL OR TRIM(@schemaName) = '')
  BEGIN
   RAISERROR('You must specify the schema of the table!!!', 16, -1)
   RETURN
  END
 
  IF(@tableName IS NULL OR TRIM(@tableName) = '')
  BEGIN
   RAISERROR('You must specify the name of the table!!!', 16, -1)
   RETURN
  END
 
  IF(@dateFieldName IS NULL OR TRIM(@dateFieldName) = '')
  BEGIN
   RAISERROR('You must specify the name of the column that contains the dates for the lookups!!!', 16, -1)
   RETURN
  END
 
  DECLARE @e AS TABLE([objectID] BIGINT)
  SET @sqlCommand = '
  DECLARE @objectID BIGINT = 0
  SELECT @objectID = OBJECT_ID ('+CHAR(39)+'['+@dbname+'].['+@schemaName+'].['+@tableName+']'+CHAR(39)+',''U'')
  SELECT ISNULL(@objectID,-1)
  '
 
  INSERT INTO @e
  EXEC sp_executesql @sqlCommand
  SET @tableExists = (SELECT CASE [objectID] WHEN -1 THEN 0 ELSE 1 END FROM @e)
  DELETE FROM @e
 
  IF(@tableExists <> 1)
  BEGIN
   RAISERROR('The specified table can''t be located, please check and try again!!!', 16, -1)
   RETURN
  END
 
  DECLARE @f AS TABLE([size] SMALLINT)
  SET @sqlCommand = '
  DECLARE @colSize SMALLINT = 0
  SELECT @colSize = COL_LENGTH ('+CHAR(39)+'['+@dbname+'].['+@schemaName+'].['+@tableName+']'+CHAR(39)+','+CHAR(39)+@dateFieldName+CHAR(39)+')
  SELECT ISNULL(@colSize,-1)
  '
  INSERT INTO @f
  EXEC sp_executesql @sqlCommand
  SET @fieldExists = (SELECT CASE [size] WHEN -1 THEN 0 ELSE 1 END FROM @f)
  DELETE FROM @f
 
  IF(@fieldExists = 0)
  BEGIN
   RAISERROR('The specified field can''t be located, please check and try again!!!', 16, -1)
   RETURN
  END
 
  IF(@saveToHistoryTable = 0)
  PRINT 'Be aware that you have invoked the execution of this SP with historical data transfer turned off!!!'
 
  -- Per Day logic
  DECLARE @currentDate DATE
  DECLARE @startTime   DATETIME
  DECLARE @endTime     DATETIME
  DECLARE @rows        INT
  DECLARE @totalRows   INT
  DECLARE @deletedRows INT
 
  SET @currentDate = @startDate
 
  SET @sqlCommand = '
  USE '+'['+@dbname+']
  '
  EXEC(@sqlCommand)
 
  IF OBJECT_ID ('Delete_Metrics','U') IS NULL
  BEGIN
    CREATE TABLE Delete_Metrics(
      StartDate      DATE NOT NULL,
      EndDate        DATE NOT NULL,
      Records        INT NOT NULL,
      CompletionTime INT NOT NULL
   )
    CREATE NONCLUSTERED INDEX IX_StartDate ON Delete_Metrics(StartDate)
    CREATE NONCLUSTERED INDEX IX_EndDate ON Delete_Metrics(EndDate)
  END
 
  IF(@saveToHistoryTable = 1)
  BEGIN
   DECLARE @h AS TABLE([rows] INT)
    SET @sqlCommand = '
    SET NOCOUNT ON
 
    IF OBJECT_ID ('+CHAR(39)+'['+@dbname+'].['+@schemaName+'].['+@tableName+'_historic]'+CHAR(39)+',''U'') IS NULL
    BEGIN
        SELECT TOP 0 * INTO ['+@dbname+'].['+@schemaName+'].['+@tableName+'_historic] FROM ['+@dbname+'].['+@schemaName+'].['+@tableName+']  
    END
 
    INSERT INTO ['+@dbname+'].['+@schemaName+'].['+@tableName+'_historic]
    SELECT * FROM ['+@dbname+'].['+@schemaName+'].['+@tableName+'] WHERE ['+@dateFieldName+'] >= '+CHAR(39)+CONVERT(VARCHAR(20),@startDate)+CHAR(39)+' AND ['+@dateFieldName+'] < '+CHAR(39)+CONVERT(VARCHAR(20),@endDate)+CHAR(39)+'
   
   SELECT @@ROWCOUNT
   '
   INSERT INTO @h
    EXEC sp_executesql @sqlCommand
    SET @totalRows = (SELECT [rows] FROM @h)
    DELETE FROM @h
 
   IF(@totalRows > 0)
   RAISERROR ('#Finished transferring records to historic table#', 0, 1) WITH NOWAIT
  END
 
  WHILE(@currentDate < @endDate)
  BEGIN
   BEGIN TRANSACTION
      BEGIN TRY
            DECLARE @t AS TABLE([rows] INT)
            SET @sqlCommand = '
            DECLARE @tempTotalRows INT = 0
            SELECT @tempTotalRows = COUNT(*) FROM ['+@dbName+'].['+@schemaName+'].['+@tableName+'] WHERE ['+@dateFieldName+'] >= '+CHAR(39)+CONVERT(VARCHAR(20),@currentDate)+CHAR(39)+' AND ['+@dateFieldName+'] < DATEADD(DAY,1,'+CHAR(39)+CONVERT(VARCHAR(20),@currentDate)+CHAR(39)+')
            SELECT @tempTotalRows
            '
            INSERT INTO @t
            EXEC sp_executesql @sqlCommand
            SET @totalRows = (SELECT [rows] FROM @t)
            DELETE FROM @t
 
         SET @deletedRows = 0
         SET @startTime = GETDATE()
         DECLARE @d AS TABLE([rows] INT)
 
         WHILE @deletedRows < @totalRows 
         BEGIN
             SET @sqlCommand = '            
            DELETE TOP ('+CONVERT(VARCHAR(16),@batch)+')
            FROM ['+@dbName+'].['+@schemaName+'].['+@tableName+'] WHERE ['+@dateFieldName+'] >= '+CHAR(39)+CONVERT(VARCHAR(20),@currentDate)+CHAR(39)+' AND ['+@dateFieldName+'] < DATEADD(DAY,1,'+CHAR(39)+CONVERT(VARCHAR(20),@currentDate)+CHAR(39)+')
 
            SELECT @@ROWCOUNT
                '
 
                INSERT INTO @d
            EXEC sp_executesql @sqlCommand
            SET @deletedRows += (SELECT [rows] FROM @d)
            DELETE FROM @d
         
            SELECT l.total_size AS TotalSize,f.free_space AS FreeSpace
            FROM(
               SELECT CONVERT(DECIMAL(10,2),(total_log_size_in_bytes - used_log_space_in_bytes)/1024.0/1024.0) AS [free_space]  
               FROM sys.dm_db_log_space_usage
            )AS f,
            (
               SELECT CONVERT(DECIMAL(10,2),size*8.0/1024.0) AS [total_size]
               FROM sys.database_files
               WHERE type_desc = 'LOG'
            )AS l
 
         END
 
         IF(@deletedRows > 0)
         BEGIN
            DECLARE @stringDate VARCHAR(10) = CONVERT(VARCHAR(10),@currentDate)
            RAISERROR('Finished deleting records for date: %s',0,1,@stringDate) WITH NOWAIT
            INSERT INTO Delete_Metrics VALUES(@currentDate, DATEADD(DAY,1,@currentDate),@deletedRows,DATEDIFF(SECOND,@startTime,GETDATE()))
         END
 
         SET @currentDate = DATEADD(DAY,1,@currentDate)
 
         COMMIT TRANSACTION
      END TRY
      BEGIN CATCH
         ROLLBACK TRANSACTION
         SELECT ERROR_MESSAGE() AS ErrorMessage;
      END CATCH
  END