-- Récupérer les infos système du SGBD
SELECT
	SERVERPROPERTY('MachineName') as Host,
	SERVERPROPERTY('InstanceName') as Instance,
	SERVERPROPERTY('Edition') as Edition, /*shows 32 bit or 64 bit*/
	SERVERPROPERTY('ProductLevel') as ProductLevel, /* RTM or SP1 etc*/
	Case SERVERPROPERTY('IsClustered') 
		when 1 then 'CLUSTERED' 
		else 'STANDALONE' 
	end as ServerType,
    @@VERSION as VersionNumber,
	@@LANGUAGE as Langue,
	@@SERVICENAME as ServiceName