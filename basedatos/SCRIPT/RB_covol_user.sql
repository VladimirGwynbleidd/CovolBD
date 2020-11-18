use master
go

IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'usr_covol')
DROP LOGIN [usr_covol]
GO