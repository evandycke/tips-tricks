select 
	loginname,
	isntgroup as isntgroup 
from 
	syslogins logins
where 
	(1=1)
	and hasaccess=1 
	and isntgroup=0 
order by 
	loginname;