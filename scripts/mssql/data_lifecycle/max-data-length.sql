declare @results table
(
ID varchar(36),
TableName varchar(250),
ColumnName varchar(250),
DataType varchar(250),
MaxLength varchar(250),
Longest varchar(250),
SQLText varchar(250)
)

INSERT INTO @results(ID,TableName,ColumnName,DataType,MaxLength,Longest,SQLText)
SELECT 
    NEWID(),
    Object_Name(c.object_id),
    c.name,
    t.Name,
    case 
        when t.Name != 'varchar' Then 'NA'
        when c.max_length = -1 then 'Max' 
        else CAST(c.max_length as varchar)
    end,
    'NA',
    'SELECT Max(Len(' + c.name + ')) FROM ' + OBJECT_SCHEMA_NAME(c.object_id) + '.' + Object_Name(c.object_id)
FROM    
    sys.columns c
INNER JOIN 
    sys.types t ON c.system_type_id = t.system_type_id
WHERE
    c.object_id = OBJECT_ID('maTable')    


DECLARE @id varchar(36)
DECLARE @sql varchar(200)
declare @receiver table(theCount int)

DECLARE length_cursor CURSOR
    FOR SELECT ID, SQLText FROM @results WHERE MaxLength != 'NA'
OPEN length_cursor
FETCH NEXT FROM length_cursor
INTO @id, @sql
WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO @receiver (theCount)
    exec(@sql)

    UPDATE @results
    SET Longest = (SELECT theCount FROM @receiver)
    WHERE ID = @id

    DELETE FROM @receiver

    FETCH NEXT FROM length_cursor
    INTO @id, @sql
END
CLOSE length_cursor
DEALLOCATE length_cursor


SELECT 
    TableName, 
    ColumnName, 
    DataType, 
    MaxLength, 
    Longest,
	Case 
		when DataType = 'text' then null
		else try_cast(Longest as int)
	end as IntLongest 
FROM 
    @results
-- debug
--where
--	Longest > 255
order by
	6 desc;