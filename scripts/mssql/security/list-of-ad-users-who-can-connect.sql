DECLARE @loginname VARCHAR(50)

DECLARE load_cursor CURSOR FOR 
    SELECT loginname from syslogins where isntgroup=1 order by loginname
OPEN load_cursor 
FETCH NEXT FROM load_cursor INTO @loginname 
 
WHILE @@FETCH_STATUS = 0 
BEGIN 
    EXEC XP_LOGININFO @loginname, 'members'
    FETCH NEXT FROM load_cursor INTO @loginname 
END 
 
CLOSE load_cursor 
DEALLOCATE load_cursor 