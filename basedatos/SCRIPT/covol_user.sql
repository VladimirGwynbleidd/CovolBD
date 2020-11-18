use master
go

IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'usr_covol')
DROP LOGIN [usr_covol]
GO

CREATE LOGIN [usr_covol] WITH PASSWORD=N'usr_covol', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

use Covol
GO

IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'usr_covol')
	DROP USER [usr_covol]
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'usr_covol')
	CREATE USER [usr_covol] FOR LOGIN [usr_covol] WITH DEFAULT_SCHEMA=[dbo]
GO

sys.sp_addrolemember @rolename = N'db_owner', @membername = N'usr_covol'
GO

sys.sp_addrolemember @rolename = N'db_datareader', @membername = N'usr_covol'
GO

sys.sp_addrolemember @rolename = N'db_datawriter', @membername = N'usr_covol'
GO