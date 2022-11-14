SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE usp_Rebuild_All_Index
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @msg NVARCHAR(MAX)
	DECLARE @tableName NVARCHAR(128)
	DECLARE @sqlStatement NVARCHAR(300)
	DECLARE @fillfactor INT 

	SET @fillfactor = 90 

	DECLARE rebuildIndex CURSOR FOR
		SELECT 
			CONCAT('[',T.TABLE_CATALOG,'].[',T.TABLE_SCHEMA,'].[',T.TABLE_NAME,']')
		FROM 
			INFORMATION_SCHEMA.TABLES T
		WHERE 
			T.TABLE_TYPE = 'BASE TABLE'
			AND T.TABLE_SCHEMA IN ('schema1','schema2')
		ORDER BY 
			T.TABLE_SCHEMA ASC,
			T.TABLE_NAME ASC

	OPEN rebuildIndex
	FETCH NEXT FROM rebuildIndex INTO @tableName
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		SET @msg = '*** Reconstruction des index pour la table ' + @tableName + ' ***'
		RAISERROR(@msg,0,1) WITH NOWAIT
	
		DBCC DBREINDEX(@tableName, ' ', @fillfactor) 

		FETCH NEXT FROM rebuildIndex INTO @tableName
	END

	CLOSE rebuildIndex

	DEALLOCATE rebuildIndex;
	SET NOCOUNT OFF;
END
GO
