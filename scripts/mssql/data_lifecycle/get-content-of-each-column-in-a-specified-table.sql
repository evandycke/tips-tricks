USE [DHB_DEV]
GO

/****** Object:  StoredProcedure [dbo].[usp_CheckTableContent]    Script Date: 23/06/2017 08:47:32 ******/
DROP PROCEDURE [dbo].[usp_CheckTableContent]
GO

/****** Object:  StoredProcedure [dbo].[usp_CheckTableContent]    Script Date: 23/06/2017 08:47:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =======================================================================
-- Author:		Elie Vandycke
-- Create date: 22/06/2017
-- Description:	Obtient le contenu de chaque colonne d'une table spécifiée
-- =======================================================================
CREATE PROCEDURE [dbo].[usp_CheckTableContent]
	@tableSchema NVARCHAR(MAX),
	@tableName NVARCHAR(MAX),
	@count BIT = 0,
	@debug BIT = 0
AS
BEGIN
	DECLARE @sql NVARCHAR(MAX);
	DECLARE @columnName VARCHAR(MAX);

	DECLARE COLUMNS_CURSOR CURSOR LOCAL STATIC READ_ONLY FORWARD_ONLY
	FOR 
	WITH TableColumns(ColumnName) AS (
	SELECT 
		C.COLUMN_NAME 
	FROM 
		INFORMATION_SCHEMA.COLUMNS C 
	WHERE 
		C.TABLE_SCHEMA = @tableSchema 
		AND C.TABLE_NAME = @tableName),

	SqlOrder(Script) AS (
	SELECT
		CASE WHEN @count = 1 THEN
			'SELECT ' + CHAR(39) + '*' + CHAR(39) + ' AS [VALEUR_' + ColumnName + '], COUNT(*) AS NB FROM ' + @tableSchema + '.' + @tableName + ' ' +
			'UNION ALL ' +
			'SELECT TRY_CONVERT(NVARCHAR(MAX), ' + ColumnName + '), COUNT(*) FROM ' + @tableSchema + '.' + @tableName + ' GROUP BY ' + ColumnName + ' ' +
			'ORDER BY 2 DESC, 1 ASC'
		ELSE
			'SELECT TRY_CONVERT(NVARCHAR(MAX), ' + ColumnName + ') AS [VALEUR_' + ColumnName + '], COUNT(*) AS NB FROM ' + @tableSchema + '.' + @tableName + ' GROUP BY ' + ColumnName + ' ' +
			'ORDER BY 2 DESC, 1 ASC'
		END
	FROM
		TableColumns
	)

	SELECT Script FROM SqlOrder
	OPEN COLUMNS_CURSOR
	FETCH NEXT FROM COLUMNS_CURSOR INTO @sql
	WHILE @@FETCH_STATUS = 0
	BEGIN 
		IF @debug = 1
			PRINT @sql
		ELSE
			exec sp_executesql @sql

		FETCH NEXT FROM COLUMNS_CURSOR INTO @sql
	END
	CLOSE COLUMNS_CURSOR
	DEALLOCATE COLUMNS_CURSOR
END



GO


