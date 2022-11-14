SELECT 'bcp "' + DB_NAME() + '.Person.Person" out c:\bcp\export.dat -c -C ACP -T -S ' + @@servername AS COMMANDE_BCP
GO