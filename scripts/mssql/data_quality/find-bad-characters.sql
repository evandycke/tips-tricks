SELECT 
	MaDonnee, 
	master.dbo.fn_varbintohexstr(CAST(MaDonnee AS VARBINARY)) AS Expr1
FROM MaTable
where 
	(1=1)
	and master.dbo.fn_varbintohexstr(CAST(MaDonnee AS VARBINARY)) like '%00'