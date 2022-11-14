DECLARE @TCP_port varchar(5)
        , @registry_path varchar(100)

SELECT @registry_path = CASE @@SERVICENAME
                WHEN 'MSSQLSERVER' THEN 'SOFTWARE\Microsoft\MSSQLSERVER\MSSQLSERVER\SuperSocketNetLib\TCP'
                ELSE 'SOFTWARE\Microsoft\Microsoft SQL Server\' + @@SERVICENAME + '\MSSQLServer\SuperSocketNetLib\TCP'
        END

EXEC master.dbo.xp_regread
    @rootkey = 'HKEY_LOCAL_MACHINE'
    , @key = @registry_path
    , @value_name = 'TcpPort'
    , @value = @TCP_port OUTPUT

SELECT @TCP_port AS PortNumber
        , @@SERVERNAME AS ServerName
        , @@SERVICENAME AS ServiceName