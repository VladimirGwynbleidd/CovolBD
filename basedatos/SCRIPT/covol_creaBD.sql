USE [master]
GO
/*---------------------  reemplazar en el al ejecutar en el servidor por lo que esta comentado, as� como reemplazar la ubicaci�n--------------------*/
CREATE DATABASE [Covol]
 CONTAINMENT = NONE
 ON  PRIMARY 

( NAME = N'Covol', FILENAME = N'/var/opt/mssql/data/Covol.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Covol_log', FILENAME = N'/var/opt/mssql/data/Covol_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [Covol] SET COMPATIBILITY_LEVEL = 130
GO


IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Covol].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [Covol] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [Covol] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [Covol] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [Covol] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [Covol] SET ARITHABORT OFF 
GO

ALTER DATABASE [Covol] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [Covol] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [Covol] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [Covol] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [Covol] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [Covol] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [Covol] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [Covol] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [Covol] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [Covol] SET  DISABLE_BROKER 
GO

ALTER DATABASE [Covol] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [Covol] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO


ALTER DATABASE [Covol] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO

ALTER DATABASE [Covol] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [Covol] SET READ_COMMITTED_SNAPSHOT ON 
GO

ALTER DATABASE [Covol] SET RECOVERY FULL 
GO

ALTER DATABASE [Covol] SET  MULTI_USER 
GO

ALTER DATABASE [Covol] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [Covol] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [Covol] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [Covol] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [Covol] SET QUERY_STORE = OFF
GO

USE [Covol]
GO

ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO

ALTER DATABASE [Covol] SET  READ_WRITE 
GO


