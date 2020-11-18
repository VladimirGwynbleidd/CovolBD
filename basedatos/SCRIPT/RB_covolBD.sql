EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'Covol'
GO
USE [master]
GO
ALTER DATABASE [Covol] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
USE [master]
GO
/****** Object:  Database [Covol]    Script Date: 06/02/2020 19:29:26 ******/
DROP DATABASE [Covol]
GO