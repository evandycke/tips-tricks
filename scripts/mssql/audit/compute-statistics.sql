SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE usp_Compute_Statistics_For_All_Tables
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @msg NVARCHAR(MAX)
	DECLARE @tableSchema NVARCHAR(128)
	DECLARE @tableName NVARCHAR(128)
	DECLARE @sqlStatement NVARCHAR(300)

	DECLARE updateStats CURSOR FOR
		SELECT 
			T.TABLE_SCHEMA,
			T.TABLE_NAME 
		FROM 
			INFORMATION_SCHEMA.TABLES T
		WHERE 
			T.TABLE_TYPE = 'BASE TABLE'
			AND T.TABLE_SCHEMA IN ('schema1','schema2')
		ORDER BY 
			T.TABLE_SCHEMA ASC,
			T.TABLE_NAME ASC

	OPEN updateStats
	FETCH NEXT FROM updateStats INTO @tableSchema, @tableName
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		SET @msg = '*** Calcul des statistiques pour la table ' + CONCAT(@tableSchema, '.', @tableName) + ' ***'
		RAISERROR(@msg,0,1) WITH NOWAIT
	
		SET @sqlStatement = 'UPDATE STATISTICS '  + @tableName + '  WITH FULLSCAN, ALL'
		EXEC sp_executesql @sqlStatement
		FETCH NEXT FROM updateStats INTO @tableSchema, @tableName
	END

	CLOSE updateStats

	DEALLOCATE updateStats;
	SET NOCOUNT OFF;
END
GO
