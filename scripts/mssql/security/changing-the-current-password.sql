-- Sauvegarde des couples [utilsateur;mot de passe]
select password, name into old_login from master.sys.syslogins
GO

-- Modification du mot de passe de l'utilisateur "sa"
exec sp_password NULL, 'abc123', 'sa'
GO