USE Covol
GO

/**** crea funciones ****/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_split] (
    @string NVARCHAR(MAX),
    @delimiter CHAR(1)
    )
RETURNS @out_put TABLE (
    [column_id] INT IDENTITY(1, 1) NOT NULL,
    [value] NVARCHAR(MAX)
    )
AS
BEGIN
    DECLARE @value NVARCHAR(MAX),
        @pos INT = 0,
        @len INT = 0

    SET @string = CASE 
            WHEN RIGHT(@string, 1) != @delimiter
                THEN @string + @delimiter
            ELSE @string
            END

    WHILE CHARINDEX(@delimiter, @string, @pos + 1) > 0
    BEGIN
        SET @len = CHARINDEX(@delimiter, @string, @pos + 1) - @pos
        SET @value = SUBSTRING(@string, @pos, @len)

        INSERT INTO @out_put ([value])
        SELECT LTRIM(RTRIM(@value)) AS [column]

        SET @pos = CHARINDEX(@delimiter, @string, @pos + @len) + 1
    END

    RETURN
END

GO

CREATE FUNCTION [dbo].[fn_split_string_to_column] (
    @string NVARCHAR(MAX),
    @delimiter CHAR(1)
    )
RETURNS @out_put TABLE (
    [column_id] INT IDENTITY(1, 1) NOT NULL,
    [value] NVARCHAR(MAX)
    )
AS
BEGIN
    DECLARE @value NVARCHAR(MAX),
        @pos INT = 0,
        @len INT = 0

    SET @string = CASE 
            WHEN RIGHT(@string, 1) != @delimiter
                THEN @string + @delimiter
            ELSE @string
            END

    WHILE CHARINDEX(@delimiter, @string, @pos + 1) > 0
    BEGIN
        SET @len = CHARINDEX(@delimiter, @string, @pos + 1) - @pos
        SET @value = SUBSTRING(@string, @pos, @len)

        INSERT INTO @out_put ([value])
        SELECT LTRIM(RTRIM(@value)) AS [column]

        SET @pos = CHARINDEX(@delimiter, @string, @pos + @len) + 1
    END

    RETURN
END

GO


/**** CREA TABLAS ****/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cs_EntidadesFederativas](
	[c_Entidad] [int] NOT NULL,
	[d_entidad] [nvarchar](30) NULL,
	[b_Activo] [bit] NOT NULL,
 CONSTRAINT [PK_cs_EntidadesFed] PRIMARY KEY CLUSTERED 
(
	[c_Entidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cs_estacionesservicio](
	[c_estaciones_servicio] [int] NOT NULL,
	[c_zona_cuarto_decreto] [nvarchar](6) NOT NULL,
	[d_adaf] [nvarchar](100) NOT NULL,
	[d_entidad] [nvarchar](100) NOT NULL,
	[d_municipio] [nvarchar](100) NOT NULL,
	[d_no_estacion_servicio] [nvarchar](100) NOT NULL,
	[d_rfc] [nvarchar](13) NOT NULL,
	[d_razon_social] [nvarchar](100) NOT NULL,
	[d_ubicacion] [nvarchar](100) NOT NULL,
	[d_colonia] [nvarchar](100) NULL,
	[d_cp] [nvarchar](10) NULL,
	[d_competencia] [nvarchar](10) NOT NULL
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cs_estadotanque](
	[c_EstadoTanque] [bigint] IDENTITY(1,1) NOT NULL,
	[d_ClaveEstado] [nvarchar](1) NULL,
	[d_Estado] [nvarchar](100) NULL
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cs_expendios](
	[d_NumerodeTurno] [nvarchar](255) NULL,
	[d_no_estacion_servicio] [nvarchar](255) NULL,
	[d_Permiso] [nvarchar](255) NULL,
	[d_Razonsocial] [nvarchar](255) NULL,
	[f_Fechadeingreso] [datetime] NULL,
	[f_Fechadepleno] [datetime] NULL,
	[d_Calle] [nvarchar](255) NULL,
	[d_Colonia] [nvarchar](255) NULL,
	[c_CP] [int] NULL,
	[d_Municipio] [nvarchar](255) NULL,
	[d_EntidadFederativa] [nvarchar](255) NULL
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cs_marcas](
	[c_Marca] [bigint] IDENTITY(1,1) NOT NULL,
	[d_ClaveMarca] [nvarchar](100) NULL,
	[d_Marca] [nvarchar](100) NULL
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cs_perfil](
	[c_Perfil] [bigint] NOT NULL,
	[d_perfil] [nvarchar](100) NULL,
	[b_carga] [bit] NULL,
	[b_catalogo] [bit] NULL,
	[b_cruce] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[c_Perfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cs_productos](
	[c_Productos] [bigint] NOT NULL,
	[d_claveProducto] [nvarchar](2) NOT NULL,
	[d_Producto] [nvarchar](100) NULL,
	[d_ComentarioProducto] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[d_claveProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cs_statuscruce](
	[c_status] [bigint] IDENTITY(1,1) NOT NULL,
	[d_estatus] [nvarchar](100) NULL,
	[b_activo] [bit] NULL
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cs_subproductos](
	[c_SubProducto] [bigint] NOT NULL,
	[d_claveProducto] [nvarchar](2) NOT NULL,
	[d_claveSubProducto] [nvarchar](3) NOT NULL,
	[d_SubProducto] [nvarchar](100) NOT NULL,
	[d_ComentarioSubProducto] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[c_SubProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cs_tiporegistro](
	[c_TipoRegistro] [bigint] IDENTITY(1,1) NOT NULL,
	[d_ClaveRegistro] [nvarchar](1) NULL,
	[d_Registro] [nvarchar](150) NULL
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cs_usuario](
	[c_usuario] [bigint] NOT NULL,
	[c_perfil] [nvarchar](100) NULL,
	[d_nombre] [nvarchar](100) NULL,
	[d_RFC] [nvarchar](100) NULL,
	[b_carga] [bit] NULL,
	[b_catalogo] [bit] NULL,
	[b_cruce] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[c_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cs_valorestimulo](
	[c_valorestimulo] [bigint] NOT NULL,
	[c_subproducto] [int] NOT NULL,
	[m_Valor] [decimal](4, 2) NOT NULL,
	[d_valor] [nvarchar](100) NULL,
	[d_ComentarioValorEstimulo] [nvarchar](100) NULL
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cs_ZonaValorEstimulo](
	[c_zonavalor] [int] NOT NULL,
	[d_zona] [nvarchar](4) NOT NULL,
	[m_valorMagna] [decimal](4, 2) NOT NULL,
	[m_valorPremium] [decimal](4, 2) NOT NULL,
 CONSTRAINT [PK_cs_ZonaValorEstimulo] PRIMARY KEY CLUSTERED 
(
	[c_zonavalor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dd_dispensario](
	[c_Dispensario] [bigint] IDENTITY(1,1) NOT NULL,
	[c_numeroDispensario] [int] NOT NULL,
	[c_identificadorManguera] [int] NOT NULL,
	[d_claveProducto] [nvarchar](2) NOT NULL,
	[d_claveSubProducto] [nvarchar](1) NOT NULL,
	[c_composicionOctanajeDeGasolina] [int] NULL,
	[c_gasolinaConEtanol] [nvarchar](2) NULL,
	[m_composicionDeEtanolEnGasolina] [decimal](4, 2) NULL,
	[d_Otros] [nvarchar](100) NULL,
	[d_Marca] [nvarchar](200) NULL,
	[c_ControlVolumetrico] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[c_Dispensario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dd_existencias](
	[c_Existencias] [bigint] IDENTITY(1,1) NOT NULL,
	[c_numeroTanque] [int] NOT NULL,
	[d_claveProducto] [nvarchar](2) NOT NULL,
	[d_claveSubProducto] [nvarchar](1) NOT NULL,
	[c_composicionOctanajeDeGasolina] [int] NULL,
	[d_gasolinaConEtanol] [nvarchar](2) NULL,
	[m_composicionDeEtanolEnGasolina] [decimal](4, 2) NULL,
	[d_Otros] [nvarchar](100) NULL,
	[d_Marca] [nvarchar](200) NULL,
	[c_volumenUtil] [int] NOT NULL,
	[c_volumenFondaje] [int] NOT NULL,
	[c_volumenAgua] [int] NOT NULL,
	[c_volumenDisponible] [int] NOT NULL,
	[c_volumenExtraccion] [int] NOT NULL,
	[c_volumenRecepcion] [int] NOT NULL,
	[m_Temperatura] [decimal](4, 2) NOT NULL,
	[f_fechaYHoraEstaMedicion] [datetime] NOT NULL,
	[f_fechaYHoraMedicionAnterior] [datetime] NOT NULL,
	[c_ControlVolumetrico] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[c_Existencias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dd_reccabecera](
	[c_RecCabecera] [bigint] IDENTITY(1,1) NOT NULL,
	[c_folioUnicoRecepcion] [int] NOT NULL,
	[d_claveProducto] [nvarchar](2) NOT NULL,
	[d_claveSubProducto] [nvarchar](1) NOT NULL,
	[c_composicionOctanajeDeGasolina] [int] NULL,
	[d_gasolinaConEtanol] [nvarchar](2) NULL,
	[m_composicionDeEtanolEnGasolina] [decimal](4, 2) NULL,
	[d_Otros] [nvarchar](100) NULL,
	[d_Marca] [nvarchar](200) NULL,
	[c_folioUnicoRelacion] [int] NOT NULL,
	[c_totalRecepciones] [int] NOT NULL,
	[c_totalDocumentos] [int] NOT NULL,
	[c_ControlVolumetrico] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[c_RecCabecera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dd_recdetalle](
	[c_RecDetalle] [bigint] IDENTITY(1,1) NOT NULL,
	[c_folioUnicoRecepcion] [int] NOT NULL,
	[c_numeroDeTanque] [int] NOT NULL,
	[c_volumenInicialTanque] [int] NOT NULL,
	[c_volumenFinalTanque] [int] NOT NULL,
	[c_volumenRecepcion] [int] NOT NULL,
	[m_Temperatura] [decimal](4, 2) NOT NULL,
	[f_fechaYHoraRecepcion] [datetime] NOT NULL,
	[c_folioUnicoRelacion] [int] NOT NULL,
	[c_ControlVolumetrico] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[c_RecDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dd_recdocumentos](
	[c_RecDocumentos] [bigint] IDENTITY(1,1) NOT NULL,
	[c_folioUnicoRecepcion] [int] NOT NULL,
	[d_terminalAlmacenamientoYDistribucion] [nvarchar](3) NULL,
	[d_permisoAlmacenamientoYDistribucion] [nvarchar](100) NULL,
	[d_tipoDocumento] [nvarchar](2) NOT NULL,
	[f_fechaDocumento] [datetime] NOT NULL,
	[d_folioDocumentoRecepcion] [nvarchar](36) NOT NULL,
	[c_volumenDocumentado] [int] NOT NULL,
	[m_precioCompra] [decimal](4, 2) NOT NULL,
	[d_permisoTransporte] [nvarchar](100) NOT NULL,
	[d_claveVehiculo] [nvarchar](11) NOT NULL,
	[c_folioUnicoRelacion] [int] NOT NULL,
	[d_tipoProveedor] [nvarchar](12) NOT NULL,
	[d_permisoImportacion] [nvarchar](100) NULL,
	[d_RfcProveedor] [nvarchar](13) NULL,
	[d_nombreProveedor] [nvarchar](100) NOT NULL,
	[d_permisoProveedor] [nvarchar](100) NULL,
	[c_ControlVolumetrico] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[c_RecDocumentos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dd_tanques](
	[c_Tanque] [bigint] IDENTITY(1,1) NOT NULL,
	[c_numeroTanque] [int] NOT NULL,
	[d_claveProducto] [nvarchar](2) NOT NULL,
	[d_claveSubProducto] [nvarchar](1) NOT NULL,
	[c_composicionOctanajeDeGasolina] [int] NULL,
	[d_gasolinaConEtanol] [nvarchar](2) NULL,
	[m_composicionDeEtanolEnGasolina] [decimal](4, 2) NULL,
	[d_Otros] [nvarchar](100) NULL,
	[d_Marca] [nvarchar](200) NULL,
	[c_capacidadTotalTanque] [int] NOT NULL,
	[c_capacidadOperativaTanque] [int] NOT NULL,
	[c_capacidadUtilTanque] [int] NOT NULL,
	[c_capacidadFondajeTanque] [int] NOT NULL,
	[c_volumenMinimoOperacion] [int] NOT NULL,
	[d_estadoTanque] [nvarchar](1) NOT NULL,
	[c_ControlVolumetrico] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[c_Tanque] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dd_vtacabecera](
	[c_VtaCabecera] [bigint] IDENTITY(1,1) NOT NULL,
	[c_numeroTotalRegistrosDetalle] [int] NOT NULL,
	[c_numeroDispensario] [int] NOT NULL,
	[c_identificadorManguera] [int] NOT NULL,
	[d_claveProducto] [nvarchar](2) NOT NULL,
	[d_claveSubProducto] [nvarchar](1) NOT NULL,
	[c_composicionOctanajeDeGasolina] [int] NULL,
	[d_gasolinaConEtanol] [nvarchar](2) NULL,
	[m_composicionDeEtanolEnGasolina] [decimal](4, 2) NULL,
	[d_Otros] [nvarchar](100) NULL,
	[d_Marca] [nvarchar](200) NULL,
	[m_sumatoriaVolumenDespachado] [decimal](12, 3) NOT NULL,
	[m_sumatoriaVentas] [decimal](12, 3) NOT NULL,
	[c_ControlVolumetrico] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[c_VtaCabecera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dd_vtadetalle](
	[c_VtaDetalle] [bigint] IDENTITY(1,1) NOT NULL,
	[d_tipoDeRegistro] [nvarchar](1) NOT NULL,
	[c_numeroUnicoTransaccionVenta] [int] NOT NULL,
	[c_numeroDispensario] [int] NOT NULL,
	[c_identificadorManguera] [int] NOT NULL,
	[d_claveProducto] [nvarchar](2) NOT NULL,
	[d_claveSubProducto] [nvarchar](1) NOT NULL,
	[c_composicionOctanajeDeGasolina] [int] NULL,
	[d_gasolinaConEtanol] [nvarchar](2) NULL,
	[m_composicionDeEtanolEnGasolina] [decimal](4, 2) NULL,
	[d_Otros] [nvarchar](100) NULL,
	[d_Marca] [nvarchar](200) NULL,
	[m_volumenDespachado] [decimal](6, 3) NOT NULL,
	[m_precioUnitarioProducto] [decimal](4, 2) NOT NULL,
	[m_importeTotalTransaccion] [decimal](10, 3) NOT NULL,
	[f_fechaYHoraTransaccionVenta] [datetime] NOT NULL,
	[c_ControlVolumetrico] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[c_VtaDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mm_consolidado](
	[c_consolidado] [bigint] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[d_numeroPermisoCRE] [nvarchar](100) NULL,
	[d_TipoGasolina] [nvarchar](200) NULL,
	[m_LitrosDeVenta] [decimal](10, 3) NULL,
	[m_Total] [decimal](10, 3) NULL,
	[m_LtsExcedentes] [decimal](10, 3) NULL,
	[m_LtsEtimad] [decimal](10, 3) NULL,
	[m_MontoEstimulo] [decimal](18, 5) NULL,
	[m_valorEst] [decimal](4, 2) NULL,
	[d_claveSubProducto] [nvarchar](2) NULL,
	[c_CtrolVol] [bigint] NULL,
	[c_Status] [int] NULL,
	[f_fechaValidado] [datetime] NULL,
	[d_usuariovalido] [nvarchar](13) NULL,
PRIMARY KEY CLUSTERED 
(
	[c_consolidado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mm_controlvolumetrico](
	[c_ControlVolumetrico] [bigint] IDENTITY(1,1) NOT NULL,
	[c_ContolesVolumetricos_Id] [bigint] NOT NULL,
	[d_version] [nvarchar](10) NOT NULL,
	[d_rfc] [nvarchar](13) NOT NULL,
	[d_rfcProveedorSW] [nvarchar](13) NOT NULL,
	[d_noCertificado] [nvarchar](100) NOT NULL,
	[d_certificado] [nvarchar](max) NOT NULL,
	[f_fechaYHoraCorte] [datetime] NOT NULL,
	[d_numeroPermisoCRE] [nvarchar](100) NOT NULL,
	[d_sello] [nvarchar](max) NOT NULL,
	[d_Xmldoc] [xml] NOT NULL,
	[c_totalregistroEXI] [int] NULL,
	[c_totalregistrosRECCabecera] [int] NULL,
	[c_totalregistroRECDetalle] [int] NULL,
	[c_totalregistroRECDocumentos] [int] NULL,
	[c_totalregistroVTACabecera] [int] NULL,
	[c_totalregistroVTADetalle] [int] NULL,
	[c_totalregistroTQS] [int] NULL,
	[c_totalregistroDIS] [int] NULL,
	[d_UsuarioCarga] [varchar](13) NULL,
	[f_FechaCarga] [datetime] NULL,
	[d_fileName] [nvarchar](200) NULL,
	[b_Estatus] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[c_ControlVolumetrico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mm_Log](
	[c_mmLog] [bigint] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[Thread] [nvarchar](255) NULL,
	[Level] [nvarchar](50) NULL,
	[Logger] [nvarchar](255) NULL,
	[Message] [nvarchar](max) NULL,
	[Exception] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mm_resultadoCarga](
	[c_mmResultado] [bigint] IDENTITY(1,1) NOT NULL,
	[d_Date] [date] NULL,
	[Level] [nvarchar](20) NULL,
	[d_RFC] [nvarchar](13) NULL,
	[d_Permisionario] [nvarchar](50) NULL,
	[d_Message] [nvarchar](max) NULL,
	[c_TotalARchivos] [int] NULL,
	[d_fileName] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[c_mmResultado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/**** TERMINA DE CREAR TABLAS ****/

/**** CREA VISTAS ****/

CREATE VIEW [dbo].[vw_reportecruces]
AS
SELECT        TOP (100) PERCENT ctrlvol.c_ControlVolumetrico, ctrlvol.d_version, ctrlvol.d_rfc, ctrlvol.d_rfcProveedorSW, ctrlvol.d_numeroPermisoCRE AS Permiso,
                             (SELECT        value
                               FROM            dbo.fn_split(ctrlvol.d_numeroPermisoCRE, '/') AS fn_split_2
                               WHERE        (column_id = 2)) AS d_numeroPermisoCRE, ctrlvol.d_sello, ctrlvol.d_noCertificado, ctrlvol.d_certificado, ctrlvol.f_fechaYHoraCorte, vta.d_tipoDeRegistro, vta.c_numeroUnicoTransaccionVenta, 
                         vta.c_numeroDispensario, vta.c_identificadorManguera, vta.m_volumenDespachado, vta.m_precioUnitarioProducto, vta.m_importeTotalTransaccion, vta.f_fechaYHoraTransaccionVenta, vta.d_claveProducto, 
                         vta.d_claveSubProducto, vta.c_composicionOctanajeDeGasolina, ctrlvol.c_ContolesVolumetricos_Id, ctrlvol.f_FechaCarga, subprod.d_SubProducto
FROM            mm_controlvolumetrico AS ctrlvol INNER JOIN
                         dd_vtadetalle AS vta ON ctrlvol.c_ControlVolumetrico = vta.c_ControlVolumetrico AND ctrlvol.c_ControlVolumetrico = vta.c_ControlVolumetrico INNER JOIN
                         cs_subproductos as subprod ON vta.d_claveSubProducto = subprod.d_claveSubProducto
GO

/**** TERMINA DE CREAR VISTAS ****/

/****** CREAR LAS FORENKEY ******/
ALTER TABLE [dbo].[mm_consolidado] ADD  DEFAULT (getdate()) FOR [Date]
GO
ALTER TABLE [dbo].[mm_consolidado] ADD  DEFAULT ((1)) FOR [c_Status]
GO
ALTER TABLE [dbo].[mm_controlvolumetrico] ADD  DEFAULT ((1)) FOR [b_Estatus]
GO
ALTER TABLE [dbo].[cs_subproductos]  WITH CHECK ADD FOREIGN KEY([d_claveProducto])
REFERENCES [dbo].[cs_productos] ([d_claveProducto])
GO
ALTER TABLE [dbo].[dd_dispensario]  WITH CHECK ADD FOREIGN KEY([c_ControlVolumetrico])
REFERENCES [dbo].[mm_controlvolumetrico] ([c_ControlVolumetrico])
GO
ALTER TABLE [dbo].[dd_dispensario]  WITH CHECK ADD FOREIGN KEY([c_ControlVolumetrico])
REFERENCES [dbo].[mm_controlvolumetrico] ([c_ControlVolumetrico])
GO
ALTER TABLE [dbo].[dd_dispensario]  WITH CHECK ADD FOREIGN KEY([c_ControlVolumetrico])
REFERENCES [dbo].[mm_controlvolumetrico] ([c_ControlVolumetrico])
GO
ALTER TABLE [dbo].[dd_existencias]  WITH CHECK ADD FOREIGN KEY([c_ControlVolumetrico])
REFERENCES [dbo].[mm_controlvolumetrico] ([c_ControlVolumetrico])
GO
ALTER TABLE [dbo].[dd_existencias]  WITH CHECK ADD FOREIGN KEY([c_ControlVolumetrico])
REFERENCES [dbo].[mm_controlvolumetrico] ([c_ControlVolumetrico])
GO
ALTER TABLE [dbo].[dd_reccabecera]  WITH CHECK ADD FOREIGN KEY([c_ControlVolumetrico])
REFERENCES [dbo].[mm_controlvolumetrico] ([c_ControlVolumetrico])
GO
ALTER TABLE [dbo].[dd_reccabecera]  WITH CHECK ADD FOREIGN KEY([c_ControlVolumetrico])
REFERENCES [dbo].[mm_controlvolumetrico] ([c_ControlVolumetrico])
GO
ALTER TABLE [dbo].[dd_recdetalle]  WITH CHECK ADD FOREIGN KEY([c_ControlVolumetrico])
REFERENCES [dbo].[mm_controlvolumetrico] ([c_ControlVolumetrico])
GO
ALTER TABLE [dbo].[dd_recdetalle]  WITH CHECK ADD FOREIGN KEY([c_ControlVolumetrico])
REFERENCES [dbo].[mm_controlvolumetrico] ([c_ControlVolumetrico])
GO
ALTER TABLE [dbo].[dd_recdocumentos]  WITH CHECK ADD FOREIGN KEY([c_ControlVolumetrico])
REFERENCES [dbo].[mm_controlvolumetrico] ([c_ControlVolumetrico])
GO
ALTER TABLE [dbo].[dd_recdocumentos]  WITH CHECK ADD FOREIGN KEY([c_ControlVolumetrico])
REFERENCES [dbo].[mm_controlvolumetrico] ([c_ControlVolumetrico])
GO
ALTER TABLE [dbo].[dd_tanques]  WITH CHECK ADD FOREIGN KEY([c_ControlVolumetrico])
REFERENCES [dbo].[mm_controlvolumetrico] ([c_ControlVolumetrico])
GO
ALTER TABLE [dbo].[dd_tanques]  WITH CHECK ADD FOREIGN KEY([c_ControlVolumetrico])
REFERENCES [dbo].[mm_controlvolumetrico] ([c_ControlVolumetrico])
GO
ALTER TABLE [dbo].[dd_vtacabecera]  WITH CHECK ADD FOREIGN KEY([c_ControlVolumetrico])
REFERENCES [dbo].[mm_controlvolumetrico] ([c_ControlVolumetrico])
GO
ALTER TABLE [dbo].[dd_vtacabecera]  WITH CHECK ADD FOREIGN KEY([c_ControlVolumetrico])
REFERENCES [dbo].[mm_controlvolumetrico] ([c_ControlVolumetrico])
GO
ALTER TABLE [dbo].[dd_vtadetalle]  WITH CHECK ADD FOREIGN KEY([c_ControlVolumetrico])
REFERENCES [dbo].[mm_controlvolumetrico] ([c_ControlVolumetrico])
GO
ALTER TABLE [dbo].[dd_vtadetalle]  WITH CHECK ADD FOREIGN KEY([c_ControlVolumetrico])
REFERENCES [dbo].[mm_controlvolumetrico] ([c_ControlVolumetrico])
GO

/********************* CREA  STORED **********************************/
CREATE PROCEDURE [dbo].[sp_InsertaConsolidado]  
(  
 @idControlVolumetrico bigint,  
 @fileName varchar(200),
 @RFC nvarchar(13),
 @permmisionario nvarchar(100)
)  
AS  
BEGIN  
declare @qry nvarchar(max), @valida int,  @valorEstMag decimal(4,2), @valorEstPre decimal(4,2);  
	
  --set @valorEstMag = (SELECT m_Valor FROM cs_valorestimulo WHERE c_subproducto = 1);    
  --set @valorEstPre = (SELECT m_Valor FROM cs_valorestimulo WHERE c_subproducto = 2);    

  set @valorEstMag =	(SELECT valor.m_valorMagna
						FROM [covol].[dbo].[cs_estacionesservicio] esta
						INNER JOIN [covol].[dbo].[cs_expendios] expe
						ON  esta.d_no_estacion_servicio = expe.d_no_estacion_servicio
						INNER JOIN cs_ZonaValorEstimulo valor
						ON valor.d_zona = esta.c_zona_cuarto_decreto
						WHERE			esta.d_rfc = @RFC 
						AND				expe.d_permiso= @permmisionario)

	set @valorEstPre = (SELECT valor.m_valorPremium
						FROM [covol].[dbo].[cs_estacionesservicio] esta
						INNER JOIN [covol].[dbo].[cs_expendios] expe
						ON  esta.d_no_estacion_servicio = expe.d_no_estacion_servicio
						INNER JOIN cs_ZonaValorEstimulo valor
						ON valor.d_zona = esta.c_zona_cuarto_decreto
						WHERE			esta.d_rfc = @RFC 
						AND				expe.d_permiso= @permmisionario)

  
  INSERT INTO [dbo].[mm_consolidado]([d_numeroPermisoCRE],[d_TipoGasolina],[m_LitrosDeVenta],[m_Total],[m_LtsExcedentes],[m_LtsEtimad],[m_MontoEstimulo],[m_valorEst],[d_claveSubProducto],[c_CtrolVol])  
  SELECT d_numeroPermisoCRE, (CASE WHEN d_claveSubProducto = 1 THEN 'Gasolina menor a 92 octanos' WHEN d_claveSubProducto = 2 THEN 'Gasolina mayor o igual a 92 octanos' WHEN d_claveSubProducto = 3 THEN 'Diesel' WHEN d_claveSubProducto = 4 THEN 'Diésel mar
ino' WHEN d_claveSubProducto = 5 THEN 'Otros' WHEN d_claveSubProducto = 6 THEN 'Biodiesel' END) AS TipoGasolina,     
                         SUM(m_volumenDespachado) AS 'LitrosDeVenta', SUM(m_importeTotalTransaccion) AS 'Total',    
                             (SELECT ISNULL(SUM(m_volumenDespachado), 0) AS Expr1    
                               FROM vw_reportecruces AS vwCtrolVol_2    
                               WHERE (m_volumenDespachado > 150) AND (d_claveSubProducto = vw_reportecruces.d_claveSubProducto)) AS 'LtsExcedentes', SUM(m_volumenDespachado) -    
                             (SELECT ISNULL(SUM(m_volumenDespachado), 0) AS Expr1    
                               FROM vw_reportecruces AS vwCtrolVol_2    
                               WHERE (m_volumenDespachado > 150) AND (d_claveSubProducto = vw_reportecruces.d_claveSubProducto)) AS 'LtsEtimad', (SUM(m_volumenDespachado) -    
                             (SELECT ISNULL(SUM(m_volumenDespachado), 0) AS Expr1    
                               FROM vw_reportecruces AS vwCtrolVol_2    
                               WHERE (m_volumenDespachado > 150) AND (d_claveSubProducto = vw_reportecruces.d_claveSubProducto))) * (CASE WHEN d_claveSubProducto = 1 THEN @valorEstmag WHEN d_claveSubProducto = 2 THEN @valorEstpre ELSE 0 END)     
                         AS 'MontoEstimulo',    
        (case when d_claveSubProducto = 1 then  @valorEstMag when d_claveSubProducto = 2 then  @valorEstPre else 0 end)  as 'valorEst'    
       ,d_claveSubProducto ,c_ControlVolumetrico FROM vw_reportecruces where c_ControlVolumetrico = @idControlVolumetrico  
    GROUP BY d_numeroPermisoCRE, d_claveSubProducto, c_ControlVolumetrico order by c_ControlVolumetrico, d_claveSubProducto;  
  
    --genera registro en resultado carga de generacion de consolidado  
    INSERT INTO [dbo].[mm_Log]  
           ([Date]  
           ,[Thread]  
           ,[Level]  
           ,[Logger]  
           ,[Message]  
          )  
     VALUES(GETDATE(), 0, 'INFO','D.B. Covol: sp_InsertaConsolidado','Se genero con exito el consolidado del archivo: ' + @fileName)  
end  
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ActualizarPerfil](
			@IdUsuario int,
			@IdPerfil int,
			@Nombre varchar(150) = null,
			@RFC varchar(100) = null,
			@carga bit,
			@catalogo bit,
			@cruce bit
)
AS
begin
	Begin Try
		UPDATE 				cs_usuario
		SET					c_perfil = @IdPerfil,
							d_nombre = @Nombre,
							d_RFC = @RFC,
							b_carga = @carga,
							b_catalogo = @catalogo,
							b_cruce = @cruce
		WHERE				c_usuario = @idUsuario
	End Try
   Begin Catch
      Select  @@Error, Substring (Error_Message(), 1, 230)
   End   Catch
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ActualizarProcesados]
(
@RFC NVARCHAR(13),
@FECINI NVARCHAR(10) = NULL,
@FECFIN NVARCHAR(10) = NULL,
@DINAMICA INT = 1 -- 1 PARA BUSQUEDA POR FECHA DE CARGA 2 PARA BUSQUEDA POR F_FECHAYHORATRANSACCIONVENTA
)
AS
BEGIN

	 DECLARE @FECINI_I DATETIME 
	 DECLARE @FECFIN_F DATETIME 

	 SET @FECINI_I = CONVERT(datetime, @FECINI,105)
	 SET @FECFIN_F = CONVERT(datetime, @FECFIN,105)
	 
	UPDATE MM_CONTROLVOLUMETRICO SET B_ESTATUS = @DINAMICA
	WHERE (D_RFC = @RFC) AND (CONVERT(DATE,f_fechaYHoraCorte) BETWEEN @FECINI_I AND @FECFIN_F);
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_ActualizarSubProducto](
@idSubProducto int,
@claveProducto varchar(2),
@claveSubProducto varchar(3),
@DetalleSubProducto varchar(100),
@Comentario varchar(100) = null
)
AS
begin
	Begin Try
		UPDATE 				cs_subproductos
		SET					d_claveProducto = @claveProducto,
							d_claveSubProducto = @claveSubProducto,
							d_SubProducto = @DetalleSubProducto,
							d_ComentarioSubProducto = @Comentario
		WHERE				c_SubProducto = @idSubProducto
	End Try
	Begin Catch
		Select @@Error, Substring (Error_Message(), 1, 230)
	End Catch
   Return 
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_ActualizarTipoProducto](
			@idProductos int,
			@claveProducto varchar(3),
			@Producto varchar(100),
			@Comentario varchar(100) = null
)
AS
begin
	Begin Try
		UPDATE 				cs_productos
		SET					d_claveProducto = @claveProducto,
							d_Producto = @Producto,
							d_ComentarioProducto = @Comentario
		WHERE				c_Productos = @idProductos
	End Try
   Begin Catch
      Select  @@Error, Substring (Error_Message(), 1, 230)
   End   Catch
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_ActualizarValorEstimulo](
	@idvalorestimulo int,
	@m_valorMagna decimal(4,2),
	@m_valorPremium	decimal(4,2)
)
AS
begin
	Begin Try
		UPDATE cs_ZonaValorEstimulo
		SET	 m_valorMagna = @m_valorMagna,
			 m_valorPremium = @m_valorPremium
		WHERE c_zonavalor = @idvalorestimulo
	End Try
   Begin Catch
      Select  @@Error, Substring (Error_Message(), 1, 230)
   End   Catch
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_AgregarPerfil](
		    @IdPerfil int,
		    @Nombre varchar(100),
		    @RFC varchar(13),
			@carga bit,
			@catalogo bit,
			@cruce bit)
AS
Declare @c_usuario BIGINT
begin
	
	Select @c_usuario = ISNULL(MAX(c_usuario),0) + 1 FROM cs_usuario

	Begin Try
		INSERT INTO			cs_usuario 
							(c_usuario, c_Perfil, d_nombre, d_RFC,  b_carga, b_catalogo, b_cruce)
		VALUES				(@c_usuario, @IdPerfil, @Nombre, @RFC, @carga, @catalogo, @cruce)
	End Try
   Begin Catch
      Select  @@Error, Substring (Error_Message(), 1, 230)
   End   Catch
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_AgregarSubProducto](
@claveProducto varchar(2),
@claveSubProducto varchar(3),
@SubProducto varchar(100),
@Comentario nvarchar(100) = null
)
AS
Declare @idSubProducto BIGINT
begin

	Select @idSubProducto = ISNULL(MAX(c_SubProducto),0) + 1 FROM cs_subproductos
	Begin Try
		INSERT INTO			cs_subproductos 
							(c_SubProducto,d_claveProducto,d_claveSubProducto,d_SubProducto,d_ComentarioSubProducto)
		VALUES				(@idSubProducto,@claveProducto,@claveSubProducto,@SubProducto,@Comentario)
	End Try
   Begin Catch
      Select  @@Error, Substring (Error_Message(), 1, 230)
   End   Catch
   Return 
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC sp_AgregarTipoProducto '20','PRUEBAS'
CREATE procedure [dbo].[sp_AgregarTipoProducto](
		    @claveProducto nvarchar(3),
			@Producto nvarchar(100),
			@Comentario nvarchar(100) = null
)
AS
Declare @Productos BIGINT
begin
	
	Select @Productos = ISNULL(MAX(c_Productos),0) + 1 FROM cs_productos

	Begin Try
		INSERT INTO			cs_productos 
							(c_Productos,d_claveProducto,d_Producto,d_ComentarioProducto)
		VALUES				(@Productos,@claveProducto,@Producto,@Comentario)
	End Try
   Begin Catch
      Select  @@Error, Substring (Error_Message(), 1, 230)
   End   Catch
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec sp_AgregarSubProducto '06','Biodiesel'
CREATE procedure [dbo].[sp_AgregarValorEstimulo](
			@subproducto	INT, 
			@mvalor		DECIMAL(4,2),
			@dvalor		VARCHAR(50),
			@comentario varchar(100)
)
AS
Declare @idvalorestimulo BIGINT
begin
	Select @idvalorestimulo = ISNULL(MAX(c_valorestimulo),0) + 1 FROM cs_valorestimulo
	Begin Try
		INSERT INTO			cs_valorestimulo 
							(c_valorestimulo,c_subproducto,m_Valor,d_valor,d_ComentarioValorEstimulo)
		VALUES				(@idvalorestimulo,@subproducto,@mvalor,@dvalor,@comentario)
	End Try
   Begin Catch
      Select  @@Error, Substring (Error_Message(), 1, 230)
   End   Catch
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Cabecera]  
(  
 @RFC NVARCHAR(13),  
 @NOCRE NVARCHAR(200)= NULL,  
 @FECINI NVARCHAR(10) = NULL,
 @FECFIN NVARCHAR(10) = NULL
)  
AS  
 BEGIN  
 SELECT TOP (1) D_VERSION AS 'VERSION', PERMISO AS 'NUMEROPERMISOCRE', D_RFC 'RFC', D_NOCERTIFICADO AS 'NOCERTIFICADO', D_CERTIFICADO AS 'CERTIFICADO'  
 FROM VW_REPORTECRUCES  
 WHERE D_RFC = @RFC  
 AND PERMISO LIKE CASE WHEN @NOCRE IS NULL THEN PERMISO ELSE @NOCRE END  
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Consolidado]
(
@RFC NVARCHAR(13),
@NOCRE NVARCHAR(200) = NULL,
@FECINI NVARCHAR(10) = NULL,
@FECFIN NVARCHAR(10) = NULL
)
AS
BEGIN
	DECLARE
	@VALORESTMAG DECIMAL(4,2),
	@VALORESTPRE DECIMAL(4,2)
	DECLARE @FECINI_I DATETIME 
	DECLARE @FECFIN_F DATETIME 

	 SET @FECINI_I = CONVERT(datetime, @FECINI,105)
	 SET @FECFIN_F = CONVERT(datetime, @FECFIN,105)
	
	 SET @VALORESTMAG =	(SELECT valor.m_valorMagna
						FROM [covol].[dbo].[cs_estacionesservicio] esta
						INNER JOIN [covol].[dbo].[cs_expendios] expe
						ON  esta.d_no_estacion_servicio = expe.d_no_estacion_servicio
						INNER JOIN cs_ZonaValorEstimulo valor
						ON valor.d_zona = esta.c_zona_cuarto_decreto
						WHERE			esta.d_rfc = @RFC 
						AND				expe.d_permiso= @NOCRE)

	SET @VALORESTPRE = (SELECT valor.m_valorPremium
						FROM [covol].[dbo].[cs_estacionesservicio] esta
						INNER JOIN [covol].[dbo].[cs_expendios] expe
						ON  esta.d_no_estacion_servicio = expe.d_no_estacion_servicio
						INNER JOIN cs_ZonaValorEstimulo valor
						ON valor.d_zona = esta.c_zona_cuarto_decreto
						WHERE			esta.d_rfc = @RFC 
						AND				expe.d_permiso= @NOCRE)


	SELECT ROW_NUMBER() OVER(PARTITION BY MAX(CAST(F_FECHAYHORACORTE AS DATE))ORDER BY (SELECT 1) ) AS 'INDEX',
	D_NUMEROPERMISOCRE AS 'NUMEROPERMISOCRE',
	(CASE WHEN D_CLAVESUBPRODUCTO = 1 THEN 'GASOLINA MENOR A 92 OCTANOS' WHEN D_CLAVESUBPRODUCTO = 2 THEN 'GASOLINA MAYOR O IGUAL A 92 OCTANOS' WHEN D_CLAVESUBPRODUCTO = 3 THEN 'DIESEL' WHEN D_CLAVESUBPRODUCTO = 4 THEN 'DIÉSEL MARINO' WHEN D_CLAVESUBPRODUCTO
	= 5 THEN 'OTROS' WHEN D_CLAVESUBPRODUCTO = 6 THEN 'BIODIESEL' END) AS 'TIPOGASOLINA',
	SUM(M_VOLUMENDESPACHADO) AS 'LITROSDEVENTA',
	SUM(M_IMPORTETOTALTRANSACCION) AS 'TOTAL',
	(SELECT ISNULL(SUM(M_VOLUMENDESPACHADO), 0) AS EXPR1 FROM VW_REPORTECRUCES AS VWCTROLVOL_2 WHERE (M_VOLUMENDESPACHADO > 150) AND (D_CLAVESUBPRODUCTO = VW_REPORTECRUCES.D_CLAVESUBPRODUCTO) AND D_RFC = @RFC) AS 'LTSEXCEDENTES',
	SUM(M_VOLUMENDESPACHADO) - (SELECT ISNULL(SUM(M_VOLUMENDESPACHADO), 0) AS EXPR1 FROM VW_REPORTECRUCES AS VWCTROLVOL_2 WHERE (M_VOLUMENDESPACHADO > 150) AND (D_CLAVESUBPRODUCTO = VW_REPORTECRUCES.D_CLAVESUBPRODUCTO) AND D_RFC = @RFC) AS 'LTSETIMAD',
	(SUM(M_VOLUMENDESPACHADO) - (SELECT ISNULL(SUM(M_VOLUMENDESPACHADO), 0) AS EXPR1 FROM VW_REPORTECRUCES AS VWCTROLVOL_2 WHERE (M_VOLUMENDESPACHADO > 150) AND (D_CLAVESUBPRODUCTO = VW_REPORTECRUCES.D_CLAVESUBPRODUCTO) AND D_RFC = @RFC)) * (CASE WHEN D_CLAVESUBPRODUCTO = 1 THEN @VALORESTMAG WHEN D_CLAVESUBPRODUCTO = 2 THEN @VALORESTPRE ELSE 0 END) AS 'MONTOESTIMULO',
	(CASE WHEN D_CLAVESUBPRODUCTO = 1 THEN @VALORESTMAG WHEN D_CLAVESUBPRODUCTO = 2 THEN @VALORESTPRE ELSE 0 END) AS 'VALOREST',
	D_CLAVESUBPRODUCTO AS 'CLAVESUBPRODUCTO',
	MIN(CONVERT(DATE,F_FECHAYHORATRANSACCIONVENTA)) AS 'FECINICIAL',
	MAX(CONVERT(DATE,F_FECHAYHORATRANSACCIONVENTA)) AS 'FECFINAL'
	FROM VW_REPORTECRUCES
	WHERE D_RFC = @RFC
	AND CONVERT(DATE, F_FECHAYHORATRANSACCIONVENTA,105) BETWEEN @FECINI_I AND @FECFIN_F
	AND Permiso LIKE CASE WHEN @NOCRE IS NULL THEN Permiso ELSE @NOCRE END
	GROUP BY D_NUMEROPERMISOCRE, YEAR(F_FECHAYHORATRANSACCIONVENTA), MONTH(F_FECHAYHORATRANSACCIONVENTA), D_CLAVESUBPRODUCTO
	ORDER BY YEAR(F_FECHAYHORATRANSACCIONVENTA), MONTH(F_FECHAYHORATRANSACCIONVENTA),D_CLAVESUBPRODUCTO
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ConsolidadoRFCPeriodo]
(
	@RFC NVARCHAR(13) =null,
	@NoCre NVARCHAR(200) = NULL,
    @FECINI DATE =null,
	@FECFIN DATE =null
)
AS
BEGIN

	DECLARE @VALORESTMAG DECIMAL(4,2)
	DECLARE @VALORESTPRE DECIMAL(4,2)

    SET @VALORESTMAG =	(SELECT valor.m_valorMagna
						FROM [covol].[dbo].[cs_estacionesservicio] esta
						INNER JOIN [covol].[dbo].[cs_expendios] expe
						ON  esta.d_no_estacion_servicio = expe.d_no_estacion_servicio
						INNER JOIN cs_ZonaValorEstimulo valor
						ON valor.d_zona = esta.c_zona_cuarto_decreto
						WHERE			esta.d_rfc = @RFC 
						AND				expe.d_permiso= @NOCRE)

	SET @VALORESTPRE = (SELECT valor.m_valorPremium
						FROM [covol].[dbo].[cs_estacionesservicio] esta
						INNER JOIN [covol].[dbo].[cs_expendios] expe
						ON  esta.d_no_estacion_servicio = expe.d_no_estacion_servicio
						INNER JOIN cs_ZonaValorEstimulo valor
						ON valor.d_zona = esta.c_zona_cuarto_decreto
						WHERE			esta.d_rfc = @RFC 
						AND				expe.d_permiso= @NOCRE)


	SELECT
	ROW_NUMBER() OVER(PARTITION BY max(CAST(DATEADD(day,(DATEPART(day,F_FECHAYHORACORTE)*-1)+1,F_FECHAYHORACORTE) AS DATE)) ORDER BY (SELECT 1) ) AS 'INDEX',
	max(CAST(DATEADD(day,(DATEPART(day,F_FECHAYHORACORTE)*-1)+1,F_FECHAYHORACORTE) AS DATE)) AS 'FECHACORTE',
	cons.D_NUMEROPERMISOCRE as 'NUMEROPERMISOCRE',
	cons.D_TIPOGASOLINA AS 'TIPOGASOLINA',
	SUM(cons.M_LITROSDEVENTA) AS LITROSDEVENTA,
	SUM(cons.M_TOTAL) AS TOTAL,
	SUM(cons.M_LTSEXCEDENTES) AS LTSEXCEDENTES,
	SUM(cons.M_LTSETIMAD) AS LTSETIMAD,
	SUM(cons.M_MONTOESTIMULO) AS 'MONTOESTIMULO',
	cons.M_VALOREST AS 'VALOREST',
	cons.D_CLAVESUBPRODUCTO as 'CLAVESUBPRODUCTO',
	MM_CONTROLVOLUMETRICO.D_RFC as 'RFC'
	FROM
	MM_CONSOLIDADO cons
	INNER JOIN MM_CONTROLVOLUMETRICO
	ON cons.C_CTROLVOL = MM_CONTROLVOLUMETRICO.C_CONTROLVOLUMETRICO
	WHERE (MM_CONTROLVOLUMETRICO.D_RFC = @RFC) AND CAST(MM_CONTROLVOLUMETRICO.F_FECHAYHORACORTE AS DATE) BETWEEN @FECINI AND dateadd(MONTH,1,@FECFIN)
	and MM_CONTROLVOLUMETRICO.d_numeroPermisoCRE like case when @NoCre is null then MM_CONTROLVOLUMETRICO.d_numeroPermisoCRE else @NoCre end
	GROUP BY cons.D_NUMEROPERMISOCRE, cons.D_TIPOGASOLINA, cons.M_VALOREST, cons.D_CLAVESUBPRODUCTO, MM_CONTROLVOLUMETRICO.D_RFC


END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ControlVolumetricosXML]
(
	@datosXML xml,
	@fileName nvarchar(200)
)
AS
	declare @xmlDocument xml, @usuario NVARCHAR(13) = 'JAGC7109055Z7';
	declare @intTotalREC int, @intTotalDOC int, @intTotalVTADetalle int, @IDCtrolVol bigint, @_validaReg INT;
	declare @totalregEXI int, @totalregDIS int, @totalregTQS int, @totalregRECcabecera int, @totalregVTAcabecera int;
BEGIN
	
	set @_validaReg = CAST((select TOP 1 1 as XML from mm_controlvolumetrico where cast(d_Xmldoc as nvarchar(max)) = cast(@datosXML as nvarchar(max))) AS INT)

   If @_validaReg IS NULL
	Begin Try
		SET @xmlDocument = @datosXML;
		--BEGIN TRANSACTION;  
		declare @newxml xml = (select replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(cast(@xmlDocument as nvarchar(max)), 'controlesvolumetricos:ControlesVolumetricos','ControlesVolumetricos'), 'controlesvolumetricos:EXI', 'EXI'),'controlesvolumetricos:REC','REC' ),'controlesvolumetricos:RECCabecera','RECCabecera'), 'controlesvolumetricos:RECDetalle', 'RECDetalle'),'controlesvolumetricos:RECDocumentos','RECDocumentos'),'controlesvolumetricos:VTA','VTA'), 'controlesvolumetricos:VTACabecera','VTACabecera'),'controlesvolumetricos:VTADetalle','VTADetalle'),'controlesvolumetricos:TQS','TQS'),'controlesvolumetricos:DIS','DIS'));
		--INSERTA CABECERA XML 
		INSERT INTO [dbo].[mm_controlvolumetrico]([c_ContolesVolumetricos_Id],[d_version],[d_rfc],[d_rfcProveedorSW],[d_noCertificado],[d_certificado],[f_fechaYHoraCorte],[d_numeroPermisoCRE],[d_sello],[d_Xmldoc], [c_totalregistroEXI],[c_totalregistrosRECCabecera],[c_totalregistroRECDetalle],[c_totalregistroRECDocumentos],[c_totalregistroVTACabecera],[c_totalregistroVTADetalle],[c_totalregistroTQS],[c_totalregistroDIS],[d_UsuarioCarga],[f_FechaCarga])
		SELECT
				ContolesVolumetricos_Id = 1,
				version = XTblEnc.XCol.value('(@version)[1]', 'nvarchar(10)'),
				rfc = XTblEnc.XCol.value('(@rfc)[1]', 'nvarchar(13)'),
				rfcProveedorSW = XTblEnc.XCol.value('(@rfc)[1]', 'nvarchar(13)'),
				noCertificado = XTblEnc.XCol.value('(@noCertificado)[1]', 'nvarchar(100)'),
				certificado = XTblEnc.XCol.value('(@certificado)[1]', 'nvarchar(max)'),
				fechaYHoraCorte = XTblEnc.XCol.value('(@fechaYHoraCorte)[1]', 'datetime'),
				numeroPermisoCRE = XTblEnc.XCol.value('(@numeroPermisoCRE)[1]', 'nvarchar(100)'),
				sello = XTblEnc.XCol.value('(@sello)[1]', 'nvarchar(max)'),
				Xmldoc = @datosXML,
				totalregistroEXI = null,
				totalregistrosRECCabecera = null,
				totalregistroRECDetalle = null,
				totalregistroRECDocumentos = null,
				totalregistroVTACabecera = null,
				totalregistroVTADetalle = null,
				totalregistroTQS = null,
				totalregistroDIS = null,
				UsuarioCarga = @usuario,
				FechaCarga = GETDATE()
				FROM @newxml.nodes('//ControlesVolumetricos') AS XTblEnc(XCol)
		set @IDCtrolVol = (SELECT @@IDENTITY)
		--set @idregreso = @IDCtrolVol;
		--INSERTA ELEMENTO EXI
		INSERT INTO [dbo].[dd_existencias]([c_numeroTanque],[d_claveProducto],[d_claveSubProducto],[c_composicionOctanajeDeGasolina],[d_gasolinaConEtanol],[m_composicionDeEtanolEnGasolina],[d_Otros],[d_Marca],[c_volumenUtil],[c_volumenFondaje],[c_volumenAgua],[c_volumenDisponible],[c_volumenExtraccion],[c_volumenRecepcion],[m_Temperatura],[f_fechaYHoraEstaMedicion],[f_fechaYHoraMedicionAnterior],[c_ControlVolumetrico])
		SELECT 
			numeroTanque = XTblEXI.XCol.value('(@numeroTanque)[1]','int'),
			claveProducto = XTblEXI.XCol.value('(@claveProducto)[1]','nvarchar(2)'),
			claveSubProducto = XTblEXI.XCol.value('(@claveSubProducto)[1]','varchar(1)'),
			composicionOctanajeDeGasolina = XTblEXI.XCol.value('(@composicionOctanajeDeGasolina)[1]','int'),
			gasolinaConEtanol = XTblEXI.XCol.value('(@gasolinaConEtanol)[1]','nvarchar(2)'),
			composicionDeEtanolEnGasolina = XTblEXI.XCol.value('(@composicionDeEtanolEnGasolina)[1]','decimal(4,2)'),
			Otros = XTblEXI.XCol.value('(@otros)[1]','nvarchar(100)'),
			Marca = XTblEXI.XCol.value('(@marca)[1]','nvarchar(100)'),
			volumenUtil = XTblEXI.XCol.value('(@volumenUtil)[1]','int'),
			volumenFondaje = XTblEXI.XCol.value('(@volumenFondaje)[1]','int'),
			volumenAgua = XTblEXI.XCol.value('(@volumenAgua)[1]','int'),
			volumenDisponible = XTblEXI.XCol.value('(@volumenDisponible)[1]','int'),
			volumenExtraccion = XTblEXI.XCol.value('(@volumenExtraccion)[1]','int'),
			volumenRecepcion = XTblEXI.XCol.value('(@volumenRecepcion)[1]','int'),
			temperatura = XTblEXI.XCol.value('(@temperatura)[1]','decimal(4,2)'),
			fechaYHoraEstaMedicion = XTblEXI.XCol.value('(@fechaYHoraEstaMedicion)[1]','datetime'),
			fechaYHoraMedicionAnterior = XTblEXI.XCol.value('(@fechaYHoraMedicionAnterior)[1]','datetime'),
			c_ControlVolumetrico = @IDCtrolVol --XTbl.XCol.value('(@IDCtrolVol)[1]','bigint')
		FROM @newxml.nodes('//ControlesVolumetricos/EXI') AS XTblEXI(XCol)
		
		set @totalregEXI = @@ROWCOUNT;
		
		--INSERTA ELEMENTO REC CABECERA tomo los valores de totalRecepciones y totalDocumentos
			set @intTotalREC = (SELECT totalRecepciones = XTblREC.XCol.value('(@totalRecepciones)[1]','int')
								FROM @newxml.nodes('//ControlesVolumetricos/REC') AS XTblREC(XCol))
			set @intTotalDOC = (SELECT totalDocumentos = XTblREC.XCol.value('(@totalDocumentos)[1]','int')
								FROM @newxml.nodes('//ControlesVolumetricos/REC') AS XTblREC(XCol))
		-- inicia insert REC CABECERA
		INSERT INTO [dbo].[dd_reccabecera]([c_folioUnicoRecepcion],[d_claveProducto],[d_claveSubProducto],[c_composicionOctanajeDeGasolina],[d_gasolinaConEtanol],[m_composicionDeEtanolEnGasolina],[d_Otros],[d_Marca],[c_folioUnicoRelacion],[c_totalRecepciones],[c_totalDocumentos],[c_ControlVolumetrico])
		SELECT 
			folioUnicoRecepcion = XTblRECEnca.XCol.value('(@folioUnicoRecepcion)[1]','int'),
			claveProducto = XTblRECEnca.XCol.value('(@claveProducto)[1]','nvarchar(2)'),
			claveSubProducto = XTblRECEnca.XCol.value('(@claveSubProducto)[1]','  nvarchar(1)'),
			composicionOctanajeDeGasolina = XTblRECEnca.XCol.value('(@composicionOctanajeDeGasolina)[1]','int'),
			gasolinaConEtanol = XTblRECEnca.XCol.value('(@gasolinaConEtanol)[1]','nvarchar(2)'),
			composicionDeEtanolEnGasolina = XTblRECEnca.XCol.value('(@volumenUtil)[1]','decimal(4,2)'),
			Otros = XTblRECEnca.XCol.value('(@otros)[1]','nvarchar(100)'),
			Marca = XTblRECEnca.XCol.value('(@marca)[1]','nvarchar(200)'),
			folioUnicoRelacion = XTblRECEnca.XCol.value('(@folioUnicoRelacion)[1]','int'),
			totalRecepciones = @intTotalREC,
			totalDocumentos = @intTotalDOC,
			c_ControlVolumetrico =  @IDCtrolVol
		FROM @newxml.nodes('//ControlesVolumetricos/REC/RECCabecera') AS XTblRECEnca(XCol)

		set @totalregRECcabecera = @@ROWCOUNT;
		
		--INSERTA ELEMENTO REC DETALLE
		INSERT INTO [dbo].[dd_recdetalle]([c_folioUnicoRecepcion],[c_numeroDeTanque],[c_volumenInicialTanque],[c_volumenFinalTanque],[c_volumenRecepcion],[m_Temperatura],[f_fechaYHoraRecepcion],[c_folioUnicoRelacion],[c_ControlVolumetrico])
		SELECT
			folioUnicoRecepcion = XTblRECDetalle.XCol.value('(@folioUnicoRecepcion)[1]','int'),
			numeroDeTanque  = XTblRECDetalle.XCol.value('(@numeroDeTanque)[1]','int'),
			volumenInicialTanque  = XTblRECDetalle.XCol.value('(@volumenInicialTanque)[1]','int'),
			volumenFinalTanque = XTblRECDetalle.XCol.value('(@volumenFinalTanque)[1]','int'),
			volumenRecepcion = XTblRECDetalle.XCol.value('(@volumenRecepcion)[1]','int'),
			Temperatura  = XTblRECDetalle.XCol.value('(@temperatura)[1]','decimal(4,2)'),
			fechaYHoraRecepcion  = XTblRECDetalle.XCol.value('(@fechaYHoraRecepcion)[1]','datetime'),
			folioUnicoRelacion = XTblRECDetalle.XCol.value('(@folioUnicoRelacion)[1]','int'),
			c_ControlVolumetrico = @IDCtrolVol
		FROM @newxml.nodes('//ControlesVolumetricos/REC/RECDetalle') AS XTblRECDetalle(XCol)
				
		--INSERTA ELEMENTO REC DOCUMENTOS
		INSERT INTO [dbo].[dd_recdocumentos]([c_folioUnicoRecepcion],[d_terminalAlmacenamientoYDistribucion],[d_permisoAlmacenamientoYDistribucion],[d_tipoDocumento],[f_fechaDocumento],[d_folioDocumentoRecepcion],[c_volumenDocumentado],[m_precioCompra],[d_permisoTransporte],[d_claveVehiculo],[c_folioUnicoRelacion],[d_tipoProveedor],[d_permisoImportacion],[d_RfcProveedor],[d_nombreProveedor],[d_permisoProveedor],[c_ControlVolumetrico])
		SELECT
			folioUnicoRecepcion = XTblRECDocs.XCol.value('(@folioUnicoRecepcion)[1]','int'),
			terminalAlmacenamientoYDistribucion = XTblRECDocs.XCol.value('(@terminalAlmacenamientoYDistribucion)[1]','nvarchar(3)'),
			permisoAlmacenamientoYDistribucion = XTblRECDocs.XCol.value('(@permisoAlmacenamientoYDistribucion)[1]','nvarchar(100)'),
			tipoDocumento = XTblRECDocs.XCol.value('(@tipoDocumento)[1]','nvarchar(2)'),
			fechaDocumento = XTblRECDocs.XCol.value('(@fechaDocumento)[1]',' datetime'),
			folioDocumentoRecepcion = XTblRECDocs.XCol.value('(@folioDocumentoRecepcion)[1]','nvarchar(36)'),
			volumenDocumentado = XTblRECDocs.XCol.value('(@volumenDocumentado)[1]','int'),
			precioCompra = XTblRECDocs.XCol.value('(@precioCompra)[1]','decimal(4,2)'),
			permisoTransporte = XTblRECDocs.XCol.value('(@permisoTransporte)[1]','nvarchar(100)'),
			claveVehiculo = XTblRECDocs.XCol.value('(@claveVehiculo)[1]','nvarchar(11)'),
			folioUnicoRelacion = XTblRECDocs.XCol.value('(@folioUnicoRelacion)[1]','int'),
			tipoProveedor = XTblRECDocs.XCol.value('(@tipoProveedor)[1]','nvarchar(12)'),
			permisoImportacion = XTblRECDocs.XCol.value('(@permisoImportacion)[1]','nvarchar(100)'),
			RfcProveedor = XTblRECDocs.XCol.value('(@RfcProveedor)[1]','nvarchar(13)'),
			nombreProveedor = XTblRECDocs.XCol.value('(@nombreProveedor)[1]','nvarchar(100)'),
			permisoProveedor = XTblRECDocs.XCol.value('(@permisoProveedor)[1]','nvarchar(100)'),
			c_ControlVolumetrico = @IDCtrolVol
		FROM  @newxml.nodes('//ControlesVolumetricos/REC/RECDocumentos') AS XTblRECDocs(XCol)
		
		-- INSERTA ELEMENTOS VTACabecera Y TOMA EL VALOR DE numTotalRegistrosDetalle 
		set @intTotalVTADetalle = (SELECT numTotalRegistrosDetalle = XTblVTA.XCol.value('(@numTotalRegistrosDetalle)[1]','int')
								FROM @newxml.nodes('//ControlesVolumetricos/VTA') AS XTblVTA(XCol))
		-- inicia insert VTACabecera
		INSERT INTO [dbo].[dd_vtacabecera]([c_numeroTotalRegistrosDetalle],[c_numeroDispensario],[c_identificadorManguera],[d_claveProducto],[d_claveSubProducto],[c_composicionOctanajeDeGasolina],[d_gasolinaConEtanol],[m_composicionDeEtanolEnGasolina],[d_Otros],[d_Marca],[m_sumatoriaVolumenDespachado],[m_sumatoriaVentas],[c_ControlVolumetrico])
		SELECT
			numeroTotalRegistrosDetalle = XTblVTAEnca.XCol.value('(@numeroTotalRegistrosDetalle)[1]','int'),
			numeroDispensario = XTblVTAEnca.XCol.value('(@numeroDispensario)[1]','int'),
			identificadorManguera = XTblVTAEnca.XCol.value('(@identificadorManguera)[1]','int'),
			claveProducto = XTblVTAEnca.XCol.value('(@claveProducto)[1]','nvarchar(2)'),
			claveSubProducto = XTblVTAEnca.XCol.value('(@claveSubProducto)[1]','nvarchar(1)'),
			composicionOctanajeDeGasolina = XTblVTAEnca.XCol.value('(@composicionOctanajeDeGasolina)[1]','int'),
			gasolinaConEtanol = XTblVTAEnca.XCol.value('(@gasolinaConEtanol)[1]','nvarchar(2)'),
			composicionDeEtanolEnGasolina = XTblVTAEnca.XCol.value('(@composicionDeEtanolEnGasolina)[1]','decimal(4,2)'),
			Otros = XTblVTAEnca.XCol.value('(@otros)[1]','nvarchar(100)'),
			Marca = XTblVTAEnca.XCol.value('(@marca)[1]','nvarchar(200)'),
			sumatoriaVolumenDespachado = XTblVTAEnca.XCol.value('(@sumatoriaVolumenDespachado)[1]','decimal(12,3)'),
			sumatoriaVentas = XTblVTAEnca.XCol.value('(@sumatoriaVentas)[1]','decimal(12,3)'),
			c_ControlVolumetrico = @IDCtrolVol
		FROM @newxml.nodes('//ControlesVolumetricos/VTA/VTACabecera') AS XTblVTAEnca(XCol)

		set @totalregVTAcabecera = @@ROWCOUNT;
		
		--INSERTA ELEMENTOS VTADetalle
		INSERT INTO [dbo].[dd_vtadetalle]([d_tipoDeRegistro],[c_numeroUnicoTransaccionVenta],[c_numeroDispensario],[c_identificadorManguera],[d_claveProducto],[d_claveSubProducto],[c_composicionOctanajeDeGasolina],[d_gasolinaConEtanol],[m_composicionDeEtanolEnGasolina],[d_Otros],[d_Marca],[m_volumenDespachado],[m_precioUnitarioProducto],[m_importeTotalTransaccion],[f_fechaYHoraTransaccionVenta],[c_ControlVolumetrico])
		SELECT
			tipoDeRegistro = XTblVTADeta.XCol.value('(@tipoDeRegistro)[1]', 'nvarchar(1)'),
			numeroUnicoTransaccionVenta = XTblVTADeta.XCol.value('(@numeroUnicoTransaccionVenta)[1]', 'int'),
			numeroDispensario = XTblVTADeta.XCol.value('(@numeroDispensario)[1]', 'int'),
			identificadorManguera = XTblVTADeta.XCol.value('(@identificadorManguera)[1]', 'int'),
			claveProducto = XTblVTADeta.XCol.value('(@claveProducto)[1]', 'nvarchar(2)'),
			claveSubProducto = XTblVTADeta.XCol.value('(@claveSubProducto)[1]', 'nvarchar(1)'),
			composicionOctanajeDeGasolina = XTblVTADeta.XCol.value('(@composicionOctanajeDeGasolina)[1]', 'int'),
			gasolinaConEtanol = XTblVTADeta.XCol.value('(@gasolinaConEtanol)[1]', 'nvarchar(2)'),
			composicionDeEtanolEnGasolina = XTblVTADeta.XCol.value('(@composicionDeEtanolEnGasolina)[1]', 'decimal(4,2)'),
			Otros = XTblVTADeta.XCol.value('(@otros)[1]', 'nvarchar(100)'),
			Marca = XTblVTADeta.XCol.value('(@marca)[1]', 'nvarchar(200)'),
			volumenDespachado = XTblVTADeta.XCol.value('(@volumenDespachado)[1]', 'decimal(6,3)'),
			precioUnitarioProducto = XTblVTADeta.XCol.value('(@precioUnitarioProducto)[1]', 'decimal(4,2)'),
			importeTotalTransaccion = XTblVTADeta.XCol.value('(@importeTotalTransaccion)[1]', 'decimal(10,3)'),
			fechaYHoraTransaccionVenta = XTblVTADeta.XCol.value('(@fechaYHoraTransaccionVenta)[1]', 'datetime'),
			c_ControlVolumetrico = @IDCtrolVol
		FROM @newxml.nodes('//ControlesVolumetricos/VTA/VTADetalle') AS XTblVTADeta(XCol)
		
		--INSERTA ELEMENTOS TQS
		INSERT INTO [dbo].[dd_tanques]([c_numeroTanque],[d_claveProducto],[d_claveSubProducto],[c_composicionOctanajeDeGasolina],[d_gasolinaConEtanol],[m_composicionDeEtanolEnGasolina],[d_Otros],[d_Marca],[c_capacidadTotalTanque],[c_capacidadOperativaTanque],[c_capacidadUtilTanque],[c_capacidadFondajeTanque],[c_volumenMinimoOperacion],[d_estadoTanque],[c_ControlVolumetrico])
		SELECT
			numeroTanque = XTblTQS.XCol.value('(@numeroTanque)[1]', 'int'),
			claveProducto = XTblTQS.XCol.value('(@claveProducto)[1]', 'nvarchar(2)'),
			claveSubProducto = XTblTQS.XCol.value('(@claveSubProducto)[1]', 'nvarchar(1)'),
			composicionOctanajeDeGasolina = XTblTQS.XCol.value('(@composicionOctanajeDeGasolina)[1]', 'int'),
			gasolinaConEtanol = XTblTQS.XCol.value('(@gasolinaConEtanol)[1]', 'nvarchar(2)'),
			composicionDeEtanolEnGasolina = XTblTQS.XCol.value('(@composicionDeEtanolEnGasolina)[1]', 'decimal(4,2)'),
			Otros = XTblTQS.XCol.value('(@otros)[1]', 'nvarchar(100)'),
			Marca = XTblTQS.XCol.value('(@marca)[1]', 'nvarchar(200)'),
			capacidadTotalTanque = XTblTQS.XCol.value('(@capacidadTotalTanque)[1]', 'int'),
			capacidadOperativaTanque = XTblTQS.XCol.value('(@capacidadOperativaTanque)[1]', 'int'),
			capacidadUtilTanque = XTblTQS.XCol.value('(@capacidadUtilTanque)[1]', 'int'),
			capacidadFondajeTanque = XTblTQS.XCol.value('(@capacidadFondajeTanque)[1]', 'int'),
			volumenMinimoOperacion = XTblTQS.XCol.value('(@volumenMinimoOperacion)[1]', 'int'),
			estadoTanque = XTblTQS.XCol.value('(@estadoTanque)[1]', 'nvarchar(1)'),
			c_ControlVolumetrico = @IDCtrolVol
		FROM @newxml.nodes('//ControlesVolumetricos/TQS') AS XTblTQS(XCol)
		
		set @totalregTQS = @@ROWCOUNT;
		
		--INSERTA ELEMENTOS DIS
		INSERT INTO [dbo].[dd_dispensario]([c_numeroDispensario],[c_identificadorManguera],[d_claveProducto],[d_claveSubProducto],[c_composicionOctanajeDeGasolina],[c_gasolinaConEtanol],[m_composicionDeEtanolEnGasolina],[d_Otros],[d_Marca],[c_ControlVolumetrico])
		SELECT
			numeroDispensario = XTblDIS.XCol.value('(@numeroDispensario)[1]', 'int'),
			identificadorManguera = XTblDIS.XCol.value('(@identificadorManguera)[1]', 'int'),
			claveProducto = XTblDIS.XCol.value('(@claveProducto)[1]', 'nvarchar(2)'),
			claveSubProducto = XTblDIS.XCol.value('(@claveSubProducto)[1]', 'nvarchar(1)'),
			composicionOctanajeDeGasolina = XTblDIS.XCol.value('(@composicionOctanajeDeGasolina)[1]', 'int'),
			gasolinaConEtanol = XTblDIS.XCol.value('(@gasolinaConEtanol)[1]', 'nvarchar(2)'),
			composicionDeEtanolEnGasolina = XTblDIS.XCol.value('(@composicionDeEtanolEnGasolina)[1]', 'decimal(4,2)'),
			Otros = XTblDIS.XCol.value('(@otros)[1]', 'nvarchar(100)'),
			Marca = XTblDIS.XCol.value('(@marca)[1]', 'nvarchar(200)'),
			c_ControlVolumetrico = @IDCtrolVol
		FROM @newxml.nodes('//ControlesVolumetricos/DIS') AS XTblDIS(XCol)

		set @totalregDIS = @@ROWCOUNT;

		update mm_controlvolumetrico set c_totalregistroEXI = @totalregEXI, 
				c_totalregistrosRECCabecera = @totalregRECcabecera,
				c_totalregistroRECDetalle = @intTotalREC,
				c_totalregistroRECDocumentos = @intTotalDOC,
				c_totalregistroVTACabecera = @totalregVTAcabecera,
				c_totalregistroVTADetalle = @intTotalVTADetalle,
				c_totalregistroTQS = @totalregTQS,
				c_totalregistroDIS = @totalregDIS,
				d_fileName = @fileName
				where c_ControlVolumetrico = @IDCtrolVol

		--*********************************
		declare @RFC_ nvarchar(13), @permmisionario_ nvarchar(200)
		--SET @idregreso = 0;
		SET @xmlDocument = @datosXML;
		declare @newxmlA_ xml = (select replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(cast(@xmlDocument as nvarchar(max)), 'controlesvolumetricos:ControlesVolumetricos','ControlesVolumetricos'), 'controlesvolumetricos:EXI', 'EXI'),'controlesvolumetricos:REC','REC' ),'controlesvolumetricos:RECCabecera','RECCabecera'), 'controlesvolumetricos:RECDetalle', 'RECDetalle'),'controlesvolumetricos:RECDocumentos','RECDocumentos'),'controlesvolumetricos:VTA','VTA'), 'controlesvolumetricos:VTACabecera','VTACabecera'),'controlesvolumetricos:VTADetalle','VTADetalle'),'controlesvolumetricos:TQS','TQS'),'controlesvolumetricos:DIS','DIS'));
		
		(SELECT @RFC_ = XTblEnc.XCol.value('(@rfc)[1]', 'nvarchar(13)') FROM @newxmlA_.nodes('//ControlesVolumetricos') AS XTblEnc(XCol))
		(SELECT @permmisionario_ = XTblEnc.XCol.value('(@numeroPermisoCRE)[1]', 'nvarchar(100)') FROM @newxmlA_.nodes('//ControlesVolumetricos') AS XTblEnc(XCol))
		
		INSERT INTO [dbo].[mm_resultadoCarga]
           ([d_Date],[Level],[d_RFC],[d_Permisionario],[d_Message],[c_TotalARchivos],[d_fileName])
		values(getdate(),'INFO',@RFC_,@permmisionario_,'Archivo procesado exitosamente id: ' + cast(@IDCtrolVol as varchar(10)), 1,@fileName);
		exec [dbo].[sp_InsertaConsolidado] @IDCtrolVol,@fileName,@RFC_,@permmisionario_;
		
		--***************************************************
	End Try
	Begin Catch
			Select  @@Error, Substring (Error_Message(), 1, 230)
	End   Catch
  
  else
   begin
	    declare @RFC nvarchar(13), @permmisionario nvarchar(200)
		SET @xmlDocument = @datosXML;
		declare @newxmlA xml = (select replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(cast(@xmlDocument as nvarchar(max)), 'controlesvolumetricos:ControlesVolumetricos','ControlesVolumetricos'), 'controlesvolumetricos:EXI', 'EXI'),'controlesvolumetricos:REC','REC' ),'controlesvolumetricos:RECCabecera','RECCabecera'), 'controlesvolumetricos:RECDetalle', 'RECDetalle'),'controlesvolumetricos:RECDocumentos','RECDocumentos'),'controlesvolumetricos:VTA','VTA'), 'controlesvolumetricos:VTACabecera','VTACabecera'),'controlesvolumetricos:VTADetalle','VTADetalle'),'controlesvolumetricos:TQS','TQS'),'controlesvolumetricos:DIS','DIS'));
		
		(SELECT @RFC = XTblEnc.XCol.value('(@rfc)[1]', 'nvarchar(13)') FROM @newxmlA.nodes('//ControlesVolumetricos') AS XTblEnc(XCol))
		(SELECT @permmisionario = XTblEnc.XCol.value('(@numeroPermisoCRE)[1]', 'nvarchar(100)') FROM @newxmlA.nodes('//ControlesVolumetricos') AS XTblEnc(XCol))

		INSERT INTO [dbo].[mm_resultadoCarga]
           ([d_Date],[Level],[d_RFC],[d_Permisionario],[d_Message],[c_TotalARchivos],[d_fileName])
		values(getdate(),'WARN',@RFC,@permmisionario,'Archivos Incorrectos : El Archivo ya fue cargado. ', 1,@fileName) 
	end
   
   If Isnull(@@Error, 0) <> 0
      Begin
         Select 'Error.: ' + Rtrim(Ltrim(Cast(@@Error As Varchar))) + ' ' + Substring (Error_Message(), 1, 230)
		INSERT INTO mm_Log([Date],[Thread],[Level],[Logger],[Message],[Exception])
		VALUES(GETDATE(),'sp_InsertaConsolidado','ERROR',@@Error,@@Error,@@ERROR)
         Return 
      End
   return
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[sp_cruceroControlVolumetrico]
(
@rfc nvarchar(13),
@NoCre nvarchar(200) =Null,
@FECINI NVARCHAR(10) = NULL,
@FECFIN NVARCHAR(10) = NULL
)
As
Begin

	DECLARE @FECINI_I DATETIME 
	DECLARE @FECFIN_F DATETIME 

	SET @FECINI_I = CONVERT(datetime, @FECINI,105)
	SET @FECFIN_F = CONVERT(datetime, @FECFIN,105)

	SELECT
	c_ControlVolumetrico as 'ControlVolumetrico',
	d_noCertificado as 'noCertificado',
	d_certificado as 'certificado',
	f_fechaYHoraCorte as 'fechaYHoraCorte',
	d_tipoDeRegistro as 'tipoDeRegistro',
	c_numeroUnicoTransaccionVenta as 'numeroUnicoTransaccionVenta',
	c_numeroDispensario as 'numeroDispensario',
	c_identificadorManguera as 'identificadorManguera',
	m_volumenDespachado as 'volumenDespachado',
	m_precioUnitarioProducto as 'precioUnitarioProducto',
	m_importeTotalTransaccion as 'importeTotalTransaccion',
	f_fechaYHoraTransaccionVenta as 'fechaYHoraTransaccionVenta',
	d_numeroPermisoCRE as 'numeroPermisoCRE',
	d_claveSubProducto as 'claveSubProducto',
	d_SubProducto as 'SubProducto',
	min(convert(date,f_fechaYHoraTransaccionVenta)) as 'fecInicial',
	max(convert(date,f_fechaYHoraTransaccionVenta)) as 'fecFinal',
	min(convert(date,f_FechaCarga)) as 'fecInicialOper',
	max(convert(date,f_FechaCarga)) as 'fecFinalOper'
	FROM vw_reportecruces
	WHERE d_rfc = @rfc AND CONVERT(DATE, f_fechaYHoraTransaccionVenta,105) BETWEEN @FECINI_I AND @FECFIN_F
	and Permiso like case when @NoCre is null then Permiso else @NoCre end
	GROUP BY c_ControlVolumetrico,d_noCertificado,d_certificado,f_fechaYHoraCorte,d_tipoDeRegistro,
	c_numeroUnicoTransaccionVenta,c_numeroDispensario,c_identificadorManguera,m_volumenDespachado,m_precioUnitarioProducto,
	m_importeTotalTransaccion,f_fechaYHoraTransaccionVenta,d_numeroPermisoCRE,d_claveSubProducto,d_SubProducto
	order by d_claveSubProducto
End
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_EliminarPerfil]
(
	@IdUsuario int
)
AS
begin
	Begin Try

		DELETE FROM cs_usuario WHERE c_usuario =  @idUsuario
	
	End Try
   Begin Catch
      Select  @@Error, Substring (Error_Message(), 1, 230)
   End   Catch
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_EliminarSubProducto]
(
	@idSubProducto int
)
AS
begin
	Begin Try
		DELETE FROM cs_subproductos WHERE c_SubProducto = @idSubProducto
	End Try
   Begin Catch
      Select  @@Error, Substring (Error_Message(), 1, 230)
   End   Catch
   Return 
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_EliminarTipoProducto]
(
	@idProductos int
)
AS
begin
	Begin Try
		DELETE FROM cs_productos WHERE c_Productos =  @idProductos
	End Try
   Begin Catch
      Select  @@Error, Substring (Error_Message(), 1, 230)
   End   Catch
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_EliminarValorEstimulo]
(
	@idvalorestimulo	int
)
AS
begin
	Begin Try
		DELETE FROM cs_valorestimulo WHERE c_valorestimulo =  @idvalorestimulo
	End Try
   Begin Catch
      Select  @@Error, Substring (Error_Message(), 1, 230)
   End   Catch
   Return 
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Excedentes]  
(  
 @RFC NVARCHAR(13) = NULL,
 @NOCRE NVARCHAR(200) = NULL,
 @FECINI NVARCHAR(10) = NULL,
 @FECFIN NVARCHAR(10) = NULL
)  
AS  
BEGIN  

	 DECLARE @FECINI_I DATETIME 
	 DECLARE @FECFIN_F DATETIME 

	 SET @FECINI_I = CONVERT(datetime, @FECINI,105)
	 SET @FECFIN_F = CONVERT(datetime, @FECFIN,105)

	 SELECT  
	  C_CONTROLVOLUMETRICO AS 'CONTROLVOLUMETRICO',  
	  D_NOCERTIFICADO AS 'NOCERTIFICADO',  
	  D_CERTIFICADO AS 'CERTIFICADO',  
	  F_FECHAYHORACORTE AS 'FECHAYHORACORTE',  
	  D_TIPODEREGISTRO AS 'TIPODEREGISTRO',  
	  C_NUMEROUNICOTRANSACCIONVENTA AS 'NUMEROUNICOTRANSACCIONVENTA',  
	  C_NUMERODISPENSARIO AS 'NUMERODISPENSARIO',  
	  C_IDENTIFICADORMANGUERA AS 'IDENTIFICADORMANGUERA',  
	  M_VOLUMENDESPACHADO AS 'VOLUMENDESPACHADO',  
	  M_PRECIOUNITARIOPRODUCTO AS 'PRECIOUNITARIOPRODUCTO',  
	  M_IMPORTETOTALTRANSACCION AS 'IMPORTETOTALTRANSACCION',  
	  F_FECHAYHORATRANSACCIONVENTA AS 'FECHAYHORATRANSACCIONVENTA',  
	  D_NUMEROPERMISOCRE AS 'NUMEROPERMISOCRE',  
	  D_CLAVESUBPRODUCTO AS 'CLAVESUBPRODUCTO',  
	  D_SUBPRODUCTO AS 'SUBPRODUCTO',  
	  MIN(CONVERT(DATE,F_FECHAYHORATRANSACCIONVENTA)) AS 'FECINICIAL',  
	  MAX(CONVERT(DATE,F_FECHAYHORATRANSACCIONVENTA)) AS 'FECFINAL',  
	  MIN(CONVERT(DATE,F_FECHACARGA)) AS 'FECINICIALOPER',  
	  MAX(CONVERT(DATE,F_FECHACARGA)) AS 'FECFINALOPER'  
	 FROM VW_REPORTECRUCES VWCTROLVOL  
	 WHERE D_RFC = @RFC AND M_VOLUMENDESPACHADO > 150 AND CONVERT(DATE, F_FECHAYHORATRANSACCIONVENTA,105) BETWEEN @FECINI_I AND @FECFIN_F  
	  GROUP BY C_CONTROLVOLUMETRICO,D_NOCERTIFICADO,D_CERTIFICADO,F_FECHAYHORACORTE,D_TIPODEREGISTRO,  
	  C_NUMEROUNICOTRANSACCIONVENTA,C_NUMERODISPENSARIO,C_IDENTIFICADORMANGUERA,M_VOLUMENDESPACHADO  
	  ,M_PRECIOUNITARIOPRODUCTO,M_IMPORTETOTALTRANSACCION,F_FECHAYHORATRANSACCIONVENTA  
	  ,D_NUMEROPERMISOCRE,D_CLAVESUBPRODUCTO,D_SUBPRODUCTO  
	 ORDER BY D_CLAVESUBPRODUCTO  
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_LOG](
@FechaLogIni datetime = null,
@FechaLogFin datetime = null,
@level NVARCHAR(10) = NULL
)
AS
begin
	Begin Try
		SELECT [c_mmLog],[Date],[Level],[Logger],[Message]
		FROM [Covol].[dbo].[mm_Log]
		WHERE Level = @level and Date between @FechaLogIni and @FechaLogFin
		ORDER BY date DESC
	End Try
   Begin Catch
      Select  @@Error, Substring (Error_Message(), 1, 230)
   End   Catch
   Return 
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_MapaEstacionesServ]  
(  
@entidadFed nvarchar(50)=null,
@zona nvarchar(50)=null
)  
AS  
begin  
  SELECT   est.D_ENTIDAD AS 'ENTIDAD', est.D_RFC AS 'RFC',  
  stuff((  
   SELECT ', ' + b.c_zona_cuarto_decreto  
   FROM CS_ESTACIONESSERVICIO b  
   WHERE  
   b.d_rfc=est.d_rfc  
   and b.d_entidad like  case when @ENTIDADFED is null then  b.d_entidad   else @ENTIDADFED end 
   and b.c_zona_cuarto_decreto like case when @zona is null then b.c_zona_cuarto_decreto else @zona end 
   group by c_zona_cuarto_decreto  
   FOR XML PATH('')  
   ), 1, 1, '')   
  as 'zonas', COUNT(est.D_RFC) AS 'PERMISIONARIOS'  
  FROM     CS_ESTACIONESSERVICIO est INNER JOIN CS_ENTIDADESFEDERATIVAS ON est.D_ENTIDAD = CS_ENTIDADESFEDERATIVAS.D_ENTIDAD  
  WHERE    est.D_ENTIDAD LIKE case when @ENTIDADFED is null then est.D_ENTIDAD  else @ENTIDADFED end 
  and est.c_zona_cuarto_decreto like case when @zona is null then est.c_zona_cuarto_decreto else @zona end 
   AND CS_ENTIDADESFEDERATIVAS.B_ACTIVO = 1  
  GROUP BY est.D_ENTIDAD, est.D_RFC  
  order by  est.D_ENTIDAD , est.D_RFC  
end  
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_MapaEstacionesServDet]
(
@ENTIDADFED NVARCHAR(50),
@RFC NVARCHAR(13)
)
AS
BEGIN
		SELECT EX.D_NO_ESTACION_SERVICIO AS 'IdentificadorEstacion',c_zona_cuarto_decreto as 'zona', EX.D_PERMISO AS 'PERMISO', EX.D_RAZONSOCIAL AS 'RAZONSOCIAL', EX.D_MUNICIPIO AS 'MUNICIPIO'
        FROM   CS_EXPENDIOS AS EX INNER JOIN CS_ESTACIONESSERVICIO AS ES ON EX.D_NO_ESTACION_SERVICIO = ES.D_NO_ESTACION_SERVICIO 
								  INNER JOIN CS_ENTIDADESFEDERATIVAS ON ES.D_ENTIDAD = CS_ENTIDADESFEDERATIVAS.D_ENTIDAD
		WHERE  ES.D_RFC LIKE @RFC AND ES.D_ENTIDAD LIKE @ENTIDADFED AND CS_ENTIDADESFEDERATIVAS.B_ACTIVO = 1
		ORDER BY 'MUNICIPIO', 'PERMISO'
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROC [dbo].[sp_ObtenerCatalogoPerfiles] as
begin
	SELECT 0 as 'idPerfil',
		   'Seleccion Perfil..'  as 'dperfil'
	UNION
	SELECT c_Perfil as 'idPerfil',
		   isnull(d_perfil,'') as 'dperfil'
	FROM   cs_perfil
	order by 1
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_ObtenerDetalleCarga]  
@FECHALOGINI NVARCHAR(10) = NULL,
@FECHALOGFIN NVARCHAR(10) = NULL,
@LEVEL NVARCHAR(10),  
@RFC NVARCHAR(13),  
@CRE NVARCHAR(24)  
AS  
BEGIN  

 DECLARE @FECINI_I DATETIME 
 DECLARE @FECFIN_F DATETIME 

 SET @FECINI_I = CONVERT(datetime, @FECHALOGINI,105)
 SET @FECFIN_F = CONVERT(datetime, @FECHALOGFIN,105) 
 
 SELECT ISNULL(D_RFC,'') AS 'RFC', ISNULL(D_PERMISIONARIO,'') AS 'PERMISIONARIO',D_DATE AS 'FECHA', LEVEL, D_MESSAGE AS 'MENSAJE', D_FILENAME AS 'ARCHIVO'  
 FROM MM_RESULTADOCARGA  
 WHERE  
 LEVEL LIKE CASE WHEN @LEVEL LIKE 'ALL' THEN LEVEL ELSE @LEVEL END  
 AND D_DATE BETWEEN @FECINI_I AND @FECFIN_F  

 AND ISNULL(D_RFC,'') LIKE CASE WHEN @RFC IS NULL THEN '' ELSE @RFC END
 AND ISNULL(D_PERMISIONARIO,'') LIKE CASE WHEN @CRE IS NULL THEN '' ELSE @CRE END  
 ORDER BY D_DATE, D_FILENAME  
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_ObtenerEstadisticaLogMarcadores]
AS
BEGIN
	SELECT [LEVEL],SUM(REGISTROS) AS'REGISTROS' FROM (
		--SELECT [LEVEL],COUNT(D_FILENAME) OVER(PARTITION BY [D_FILENAME] order by [LEVEL]) AS'REGISTROS'
		SELECT [LEVEL],COUNT(D_FILENAME) AS'REGISTROS'
		FROM [MM_RESULTADOCARGA]
		WHERE [D_DATE] BETWEEN DATEADD(MONTH,-1,GETDATE()) AND GETDATE()
		GROUP BY [LEVEL] ,[D_FILENAME]
	)t1
GROUP BY [LEVEL] 
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROC [dbo].[sp_ObtenerPerfil]  @rfc varchar(13)= ''
as
begin
	SELECT a.c_usuario as 'IdUsuario',
		   isnull(p.c_Perfil,'') as 'IdPerfil',
		   isnull(p.d_perfil,'') as 'dperfil',
		   isnull(a.d_nombre,'') as 'Nombre',
		   isnull(a.d_RFC,'') as 'RFC',
		   isnull(a.b_carga,'') as 'carga',
		   isnull(a.b_catalogo,'') as 'catalogo',
		   isnull(a.b_cruce,'') as 'cruce'
	FROM   cs_usuario a
	JOIN   cs_perfil p on a.c_perfil = p.c_Perfil
	WHERE  (A.d_RFC = @rfc or @rfc  ='')
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_ObtenerResultadoCarga]    
@FECHALOGINI DATE = NULL,    
@FECHALOGFIN DATE = NULL,    
@LEVEL NVARCHAR(10) = NULL    
AS    
BEGIN    
 SELECT COUNT(C_MMRESULTADO) AS TOTALARCHIVOS, D_DATE as 'fecha', level, D_RFC as 'RFC', ISNULL(D_PERMISIONARIO,'') AS 'PERMISIONARIO'    
 FROM MM_RESULTADOCARGA    
 WHERE D_DATE BETWEEN @FECHALOGINI AND @FECHALOGFIN    
 and Level = case when @LEVEL like 'ALL' then Level else @LEVEL end    
 GROUP BY D_DATE, D_RFC, D_PERMISIONARIO, level
 END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_ObtenerSubProducto] as 
begin
SELECT c_SubProducto as 'idSubProducto', 
	   isnull(d_claveProducto,'') as 'claveProducto', 
	   isnull(d_claveSubProducto,'') as 'claveSubProducto',
	   isnull(d_SubProducto,'') as 'DetalleSubProducto',
	   isnull(d_ComentarioSubProducto,'') as 'Comentario'
FROM   cs_subproductos
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_ObtenerTipoProducto] as
begin
	SELECT c_Productos as 'idProducto',
		   isnull(d_claveProducto,'') as 'claveProducto',
		   isnull(d_Producto,'') as 'Producto',
		   isnull(d_ComentarioProducto,'') as 'Comentario'
	FROM   cs_productos
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec [dbo].[sp_ObtenerSubProducto]

CREATE procedure [dbo].[sp_ObtenerValorEstimulo]
AS
begin
		SELECT c_valorestimulo as 'idvalorestimulo'
				,c_subproducto as 'claveSubProducto'
				,m_Valor as 'valor'
				,isnull(d_valor,'') as 'descripcionvalor'
				,isnull(d_ComentarioValorEstimulo,'') as 'Comentario'
		FROM    cs_valorestimulo
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[sp_PendientesConsolidado]  
(@EstadoFile int = 1)  
As  
Begin  
 SELECT   
  d_rfc AS RFC,  
  COUNT(d_rfc) AS Archivos,  
  d_numeroPermisoCRE as'numeroPermisoCRE',  
  min(convert(date,f_fechaYHoraCorte)) as 'fecInicial',  
  max(convert(date,f_fechaYHoraCorte)) as 'fecFinal',  
  min(convert(date,f_FechaCarga)) as 'fecInicialOper',  
  max(convert(date,f_FechaCarga)) as 'fecFinalOper'  
 FROM mm_controlvolumetrico  
 where b_Estatus = @EstadoFile  
 GROUP BY d_rfc, d_numeroPermisoCRE  
End
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[sp_PendientesDetalleConsolidado]
(
@RFC nvarchar(13),
@numeroPermisoCRE nvarchar(21),
@EstadoFile int = 1
)
As
Begin
	SELECT
	D_RFC AS 'RFC',
	D_NUMEROPERMISOCRE AS 'NUMEROPERMISOCRE',
	max(CAST(DATEADD(day,(DATEPART(day,F_FECHAYHORACORTE)*-1)+1,F_FECHAYHORACORTE) AS DATE)) AS 'FECHACORTE',
	max(CAST(F_FECHAYHORACORTE AS DATE)) AS 'fechacarga',
	COUNT(C_CONTROLVOLUMETRICO) AS ARCHIVOS
	FROM MM_CONTROLVOLUMETRICO
	WHERE (d_rfc = @RFC) AND (d_numeroPermisoCRE=@numeroPermisoCRE) AND (b_Estatus = @EstadoFile)
	GROUP BY D_RFC,D_NUMEROPERMISOCRE
End
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ResultadoCarga]
(
	@datosXML xml,
	--@datosXML nvarchar(max),
	@res_level nvarchar(20),
	@res_message nvarchar(max),
	@fileName nvarchar(200)
)
AS
BEGIN
	Begin Try

		declare @xmlDocument xml
		SET @xmlDocument = @datosXML;
		BEGIN TRANSACTION;  
		declare @newxml xml = (select replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(cast(@xmlDocument as nvarchar(max)), 'controlesvolumetricos:ControlesVolumetricos','ControlesVolumetricos'), 'controlesvolumetricos:EXI', 'EXI'),'controlesvolumetricos:REC','REC' ),'controlesvolumetricos:RECCabecera','RECCabecera'), 'controlesvolumetricos:RECDetalle', 'RECDetalle'),'controlesvolumetricos:RECDocumentos','RECDocumentos'),'controlesvolumetricos:VTA','VTA'), 'controlesvolumetricos:VTACabecera','VTACabecera'),'controlesvolumetricos:VTADetalle','VTADetalle'),'controlesvolumetricos:TQS','TQS'),'controlesvolumetricos:DIS','DIS'));
		declare @RFC nvarchar(13), @permisionario nvarchar(100);
		(SELECT @RFC = XTblEnc.XCol.value('(@rfc)[1]', 'nvarchar(13)') FROM @newxml.nodes('//ControlesVolumetricos') AS XTblEnc(XCol))
		(SELECT @permisionario = XTblEnc.XCol.value('(@numeroPermisoCRE)[1]', 'nvarchar(100)') FROM @newxml.nodes('//ControlesVolumetricos') AS XTblEnc(XCol))
		
		INSERT INTO [dbo].[mm_resultadoCarga]([d_Date],[Level],[d_RFC],[d_Permisionario],[d_Message],[c_TotalARchivos],[d_fileName])
		VALUES (getdate(), @res_level, @RFC, @permisionario,@res_message,1,@fileName)
		COMMIT;
	End Try

		Begin Catch
		
		End   Catch
   return 
end

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rptControlVol]
(
@RFC NVARCHAR(13) = NULL,
@NOCRE NVARCHAR(200) = NULL,
@TIPOPRODUCTO NVARCHAR(1) = NULL,
@TIPODEREGISTRO NVARCHAR(1) = NULL,
@FECINI NVARCHAR(10) = NULL,
@FECFIN NVARCHAR(10) = NULL
)
AS
BEGIN  
     DECLARE @FECINI_I DATETIME 
	 DECLARE @FECFIN_F DATETIME 

	 SET @FECINI_I = CONVERT(datetime, @FECINI,105)
	 SET @FECFIN_F = CONVERT(datetime, @FECFIN,105)

	 SELECT  
	 ROW_NUMBER() OVER(PARTITION BY MAX(CAST(CTRLVOL.F_FECHAYHORACORTE AS DATE))ORDER BY (SELECT 1) ) AS 'INDEX',  
	 CTRLVOL.D_RFC as 'RFC',  
	 CTRLVOL.d_numeroPermisoCRE AS 'numeroPermisoCRE',  
	 (SELECT COUNT(D_RFC) FROM MM_CONTROLVOLUMETRICO WHERE MM_CONTROLVOLUMETRICO.D_RFC = CTRLVOL.D_RFC GROUP BY D_RFC) AS ARCHIVOS,  
	 MIN(CONVERT(DATE, CTRLVOL.F_FECHAYHORACORTE)) AS FECINICIALOPER,  
	 MAX(CONVERT(DATE, CTRLVOL.F_FECHAYHORACORTE)) AS FECFINALOPER  
  
	 FROM MM_CONTROLVOLUMETRICO AS CTRLVOL INNER JOIN  
	 DD_VTADETALLE AS VTA ON CTRLVOL.C_CONTROLVOLUMETRICO = VTA.C_CONTROLVOLUMETRICO AND CTRLVOL.C_CONTROLVOLUMETRICO = VTA.C_CONTROLVOLUMETRICO INNER JOIN  
	 CS_SUBPRODUCTOS AS SUBPROD ON VTA.D_CLAVESUBPRODUCTO = SUBPROD.D_CLAVESUBPRODUCTO  
	 WHERE CONVERT(DATE, CTRLVOL.F_FECHAYHORACORTE,105) BETWEEN @FECINI_I AND @FECFIN_F AND
	 CTRLVOL.D_RFC LIKE CASE WHEN @RFC IS NULL THEN CTRLVOL.D_RFC ELSE @RFC END AND  
	 VTA.D_CLAVESUBPRODUCTO = CASE WHEN @TIPOPRODUCTO IS NULL THEN VTA.D_CLAVESUBPRODUCTO ELSE @TIPOPRODUCTO END AND 
	 VTA.D_TIPODEREGISTRO = CASE WHEN @TIPODEREGISTRO IS NULL THEN VTA.D_TIPODEREGISTRO ELSE @TIPODEREGISTRO END AND 
	 CTRLVOL.D_NUMEROPERMISOCRE like CASE WHEN @NOCRE IS NULL THEN CTRLVOL.D_NUMEROPERMISOCRE ELSE @NOCRE END
	 GROUP BY CTRLVOL.D_RFC,CTRLVOL.d_numeroPermisoCRE --CTRLVOL.F_FECHAYHORACORTE,  
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rptControlVolDeta]  
(  
 @RFC NVARCHAR(13) = NULL,  
 @NOCRE NVARCHAR(200) = NULL,  
 @TIPOPRODUCTO NVARCHAR(1) = NULL,  
 @TIPODEREGISTRO NVARCHAR(1) = NULL,  
 @FECINI NVARCHAR(10) = NULL,
 @FECFIN NVARCHAR(10) = NULL
)  
AS  
BEGIN  

 DECLARE @FECINI_I DATETIME 
 DECLARE @FECFIN_F DATETIME 

 SET @FECINI_I = CONVERT(datetime, @FECINI,105)
 SET @FECFIN_F = CONVERT(datetime, @FECFIN,105)

 SELECT  
 ROW_NUMBER() OVER(PARTITION BY MIN(DATEADD(DAY,(DATEPART(DAY,VTA.F_FECHAYHORATRANSACCIONVENTA)*-1)+1,VTA.F_FECHAYHORATRANSACCIONVENTA)) ORDER BY (SELECT 5) ) AS 'INDEX',  
 CTRLVOL.D_RFC AS 'RFC',  
 CTRLVOL.D_NUMEROPERMISOCRE AS 'NUMEROPERMISOCRE',  
 MIN(CONVERT(DATE, VTA.F_FECHAYHORATRANSACCIONVENTA)) AS 'FECHACORTE',  
 MAX(CONVERT(DATE, VTA.F_FECHAYHORATRANSACCIONVENTA)) AS 'FECHACARGA'  
 FROM MM_CONTROLVOLUMETRICO AS CTRLVOL INNER JOIN  
 DD_VTADETALLE AS VTA ON CTRLVOL.C_CONTROLVOLUMETRICO = VTA.C_CONTROLVOLUMETRICO AND CTRLVOL.C_CONTROLVOLUMETRICO = VTA.C_CONTROLVOLUMETRICO INNER JOIN  
 CS_SUBPRODUCTOS AS SUBPROD ON VTA.D_CLAVESUBPRODUCTO = SUBPROD.D_CLAVESUBPRODUCTO INNER JOIN CS_TIPOREGISTRO ON VTA.D_TIPODEREGISTRO = CS_TIPOREGISTRO.D_CLAVEREGISTRO  
 WHERE  
 VTA.F_FECHAYHORATRANSACCIONVENTA BETWEEN @FECINI_I AND DATEADD(DAY,1,@FECFIN_F)  
 AND CTRLVOL.D_RFC LIKE CASE WHEN @RFC IS NULL THEN CTRLVOL.D_RFC ELSE @RFC END
 AND CTRLVOL.D_NUMEROPERMISOCRE like CASE WHEN @NOCRE IS NULL THEN  CTRLVOL.D_NUMEROPERMISOCRE ELSE @NOCRE END
 AND VTA.D_CLAVESUBPRODUCTO = CASE WHEN @TIPOPRODUCTO IS NULL THEN VTA.D_CLAVESUBPRODUCTO ELSE @TIPOPRODUCTO END  
 AND VTA.D_TIPODEREGISTRO = CASE WHEN @TIPODEREGISTRO IS NULL THEN VTA.D_TIPODEREGISTRO ELSE @TIPODEREGISTRO END  
 GROUP BY CTRLVOL.D_RFC,CTRLVOL.d_numeroPermisoCRE  
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rptCtrolVolVtaMovimientos]
(
	@RFC NVARCHAR(13) = NULL,
	@TIPOPRODUCTO NVARCHAR(1) = NULL,
	@TIPODEREGISTRO NVARCHAR(1) = NULL,
	@FECINI DATE = NULL,
	@FECFIN DATE = NULL
)
AS
BEGIN
		SELECT	
		CTRLVOL.C_CONTROLVOLUMETRICO AS 'CONTROLVOLUMETRICO',
			VTA.C_NUMEROUNICOTRANSACCIONVENTA AS 'NUMEROUNICOTRANSACCIONVENTA',
			VTA.C_NUMERODISPENSARIO AS 'NUMERODISPENSARIO',
			VTA.C_IDENTIFICADORMANGUERA AS 'IDENTIFICADORMANGUERA',
		CTRLVOL.D_NUMEROPERMISOCRE AS 'NUMEROPERMISOCRE',
		CTRLVOL.D_NOCERTIFICADO AS 'NOCERTIFICADO',
		CTRLVOL.D_CERTIFICADO AS 'CERTIFICADO',
		CTRLVOL.D_RFC AS 'RFC',
			VTA.D_CLAVEPRODUCTO AS 'CLAVEPRODUCTO',
			VTA.D_CLAVESUBPRODUCTO AS 'CLAVESUBPRODUCTO',
		SUBPROD.D_SUBPRODUCTO AS 'SUBPRODUCTO',
			VTA.D_TIPODEREGISTRO AS 'TIPODEREGISTRO',
CS_TIPOREGISTRO.D_REGISTRO AS 'REGISTRO',
			VTA.M_VOLUMENDESPACHADO AS 'VOLUMENDESPACHADO',
			VTA.M_PRECIOUNITARIOPRODUCTO AS 'PRECIOUNITARIOPRODUCTO', 
			VTA.M_IMPORTETOTALTRANSACCION AS 'IMPORTETOTALTRANSACCION',
		CTRLVOL.F_FECHAYHORACORTE AS 'FECHAHORACORTE',
			VTA.F_FECHAYHORATRANSACCIONVENTA AS 'FECHAVENTA'
FROM	MM_CONTROLVOLUMETRICO AS CTRLVOL INNER JOIN
		DD_VTADETALLE AS VTA ON CTRLVOL.C_CONTROLVOLUMETRICO = VTA.C_CONTROLVOLUMETRICO AND CTRLVOL.C_CONTROLVOLUMETRICO = VTA.C_CONTROLVOLUMETRICO INNER JOIN
        CS_SUBPRODUCTOS AS SUBPROD ON VTA.D_CLAVESUBPRODUCTO = SUBPROD.D_CLAVESUBPRODUCTO INNER JOIN
        CS_TIPOREGISTRO ON VTA.D_TIPODEREGISTRO = CS_TIPOREGISTRO.D_CLAVEREGISTRO
WHERE   convert(date,VTA.F_FECHAYHORATRANSACCIONVENTA) BETWEEN @FECINI AND @FECFIN AND
		(CTRLVOL.D_RFC LIKE CASE WHEN @RFC IS NULL THEN CTRLVOL.D_RFC ELSE @RFC END) AND 
		VTA.D_CLAVESUBPRODUCTO = CASE WHEN @TIPOPRODUCTO IS NULL THEN VTA.D_CLAVESUBPRODUCTO ELSE @TIPOPRODUCTO END AND
		VTA.D_TIPODEREGISTRO = CASE WHEN @TIPODEREGISTRO IS NULL THEN VTA.D_TIPODEREGISTRO ELSE @TIPODEREGISTRO END
GROUP BY CTRLVOL.D_RFC, VTA.D_TIPODEREGISTRO, VTA.C_NUMEROUNICOTRANSACCIONVENTA, VTA.C_NUMERODISPENSARIO, VTA.C_IDENTIFICADORMANGUERA, VTA.D_CLAVEPRODUCTO, VTA.D_CLAVESUBPRODUCTO, SUBPROD.D_SUBPRODUCTO, 
         CS_TIPOREGISTRO.D_REGISTRO, VTA.M_VOLUMENDESPACHADO, VTA.M_PRECIOUNITARIOPRODUCTO, VTA.M_IMPORTETOTALTRANSACCION, VTA.F_FECHAYHORATRANSACCIONVENTA, CTRLVOL.C_CONTROLVOLUMETRICO, CTRLVOL.D_NOCERTIFICADO, 
         CTRLVOL.D_CERTIFICADO, CTRLVOL.F_FECHAYHORACORTE, CTRLVOL.D_NUMEROPERMISOCRE
ORDER BY VTA.F_FECHAYHORATRANSACCIONVENTA, VTA.D_CLAVESUBPRODUCTO
	
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sps_ConsolidadoReporte]
(
	@rfc nvarchar(13) = null,
	@tipoProducto nvarchar(1) = null,
	@tipoDeRegistro nvarchar(1) = null,
	@fecIni date = Null,
	@fecFin date = Null
)
As
Begin
	declare @valorEstMag DECIMAL(4,2) = NULL, @valorEstPre DECIMAL(4,2) = NULL

	SELECT @valorEstMag =  m_Valor FROM cs_valorestimulo WHERE c_subproducto = 1;
	SELECT @valorEstPre = m_Valor FROM cs_valorestimulo WHERE c_subproducto = 2;
	
	SELECT ROW_NUMBER() over(partition by max(cast(f_fechaYHoraCorte as date))order by (select 1) ) as 'index',
		d_numeroPermisoCRE as 'numPermisoCRE',
		d_claveSubProducto as 'claveSubProducto',
		(CASE WHEN d_claveSubProducto = 1 THEN 'Gasolina menor a 92 octanos' WHEN d_claveSubProducto = 2 THEN 'Gasolina mayor o igual a 92 octanos' WHEN d_claveSubProducto = 3 THEN 'Diesel' WHEN d_claveSubProducto = 4 THEN 'Diésel marino' WHEN d_claveSubProducto = 5 THEN 'Otros' WHEN d_claveSubProducto = 6 THEN 'Biodiesel' END) AS 'TipoGasolina',
		SUM(m_volumenDespachado) AS 'LitrosDeVenta',
		SUM(m_importeTotalTransaccion) AS 'Total',
		(SELECT ISNULL(SUM(m_volumenDespachado), 0) AS Expr1 FROM vw_reportecruces AS vwCtrolVol_2 WHERE (m_volumenDespachado > 150) AND (d_claveSubProducto = vw_reportecruces.d_claveSubProducto) and d_rfc = @rfc) AS 'LtsExcedentes',
		SUM(m_volumenDespachado) - (SELECT ISNULL(SUM(m_volumenDespachado), 0) AS Expr1 FROM vw_reportecruces AS vwCtrolVol_2 WHERE (m_volumenDespachado > 150) AND (d_claveSubProducto = vw_reportecruces.d_claveSubProducto) and d_rfc = @rfc) AS 'LtsEtimad',
		(SUM(m_volumenDespachado) - (SELECT ISNULL(SUM(m_volumenDespachado), 0) AS Expr1 FROM vw_reportecruces AS vwCtrolVol_2 WHERE (m_volumenDespachado > 150) AND (d_claveSubProducto = vw_reportecruces.d_claveSubProducto) and d_rfc = @rfc)) * (CASE WHEN d_claveSubProducto = 1 THEN @valorEstMag WHEN d_claveSubProducto = 2 THEN @valorEstPre ELSE 0 END) AS 'MontoEstimulo',
		(case when d_claveSubProducto = 1 then @valorEstMag when d_claveSubProducto = 2 then @valorEstPre else 0 end) as 'valorEst',
		min(convert(date,f_fechaYHoraTransaccionVenta)) as 'fecInicial',
		max(convert(date,f_fechaYHoraTransaccionVenta)) as 'fecFinal',
		YEAR(f_fechaYHoraTransaccionVenta) AS 'AÑO',
		MONTH(f_fechaYHoraTransaccionVenta) AS 'MES'
	FROM vw_reportecruces
	wHERE   (f_fechaYHoraTransaccionVenta BETWEEN @fecIni AND @fecFin) AND
		(d_rfc LIKE CASE WHEN @rfc IS NULL THEN d_rfc ELSE @rfc END) AND 
		d_claveSubProducto = CASE WHEN @tipoProducto IS NULL THEN d_claveSubProducto ELSE @tipoProducto END AND
		d_tipoDeRegistro = CASE WHEN @tipoDeRegistro IS NULL THEN d_tipoDeRegistro ELSE @tipoDeRegistro END
	GROUP BY year(f_fechaYHoraTransaccionVenta), month(f_fechaYHoraTransaccionVenta), d_numeroPermisoCRE,d_claveSubProducto
	ORDER BY year(f_fechaYHoraTransaccionVenta), month(f_fechaYHoraTransaccionVenta),d_claveSubProducto	
End
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SPS_GENERA_ABC]      
(      
 @TABLA VARCHAR(100)      
) AS      
 
DECLARE @MAX_VARIABLES INT      
DECLARE @OBJECT_ID INT = (SELECT TOP(1) T.object_id FROM sys.tables T WHERE T.name = @TABLA)      
 
IF @OBJECT_ID IS NULL      
BEGIN      
 SELECT 'LA TABLA NO EXISTE' AS SENTENCIA      
 RETURN      
END      
 
DECLARE @TAB CHAR(4) = '    '      
DECLARE @RESULTADO TABLE      
(      
 ID INT IDENTITY(1, 1),      
 SENTENCIA VARCHAR(500)      
)      
 
DECLARE @COLUMNAS TABLE      
(      
 ID INT IDENTITY(1, 1),      
 NOMBRE VARCHAR(100),       
 TIPO VARCHAR(100),      
 LLAVE INT,
 ISIDENTITY bit
)      
 
INSERT INTO @COLUMNAS (NOMBRE, TIPO, LLAVE,ISIDENTITY)      
SELECT       
 C.name,       
 UPPER(TS.name),      
 CASE WHEN KU.COLUMN_NAME IS NULL THEN 0 ELSE 1 END,
 c.is_identity     
FROM       
 sys.columns C      
 INNER JOIN sys.types TS      
  ON C.system_type_id = TS.system_type_id      
 LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC      
  ON TC.TABLE_NAME = @TABLA      
  AND TC.constraint_type = 'primary key'      
 LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KU      
  ON TC.TABLE_NAME = KU.TABLE_NAME      
  AND C.name = KU.COLUMN_NAME      
  AND TC.constraint_name = KU.constraint_name          
WHERE      
 C.object_id = @OBJECT_ID        
 AND TS.user_type_id <> 256      
ORDER BY      
 C.column_id      
 
 
INSERT INTO @RESULTADO (SENTENCIA) VALUES      
('CREATE PROCEDURE ABC_' + @TABLA),      
('('),      
(@TAB + '@OPCION VARCHAR(20),')      
INSERT INTO @RESULTADO (SENTENCIA)      
SELECT       
 @TAB + '@' + C.name + ' ' + UPPER(TS.name) +       
  CASE C.system_type_id       
  WHEN 231 THEN '(' + CASE WHEN C.max_length < 1 THEN 'MAX' ELSE CONVERT(VARCHAR,C.max_length) END + ')' --NVARCHAR      
  WHEN 167 THEN '(' + CASE WHEN C.max_length < 1 THEN 'MAX' ELSE CONVERT(VARCHAR,C.max_length) END + ')' --VARCHAR      
  WHEN 175 THEN '(' + CASE WHEN C.max_length < 1 THEN 'MAX' ELSE CONVERT(VARCHAR,C.max_length) END + ')' --CHAR      
  WHEN 106 THEN '(' + CONVERT(VARCHAR, C.precision) + ',' + CONVERT(VARCHAR, C.scale) + ')'      
  ELSE '' END      
  + CASE WHEN KU.COLUMN_NAME IS NULL THEN ' = NULL,' ELSE ',' END      
FROM       
 sys.columns C      
 INNER JOIN sys.types TS      
  ON C.system_type_id = TS.system_type_id      
 LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC      
  ON TC.TABLE_NAME = @TABLA      
  AND TC.constraint_type = 'primary key'      
 LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KU      
  ON TC.TABLE_NAME = KU.TABLE_NAME      
  AND C.name = KU.COLUMN_NAME      
  AND TC.constraint_name = KU.constraint_name          
WHERE      
 C.object_id = @OBJECT_ID      
 AND TS.user_type_id <> 256        
ORDER BY      
 C.column_id      
 
SET @MAX_VARIABLES = (SELECT MAX(ID) FROM @RESULTADO)      
 
UPDATE TOP(1)       
 @RESULTADO       
SET       
 SENTENCIA = SUBSTRING(SENTENCIA, 1, LEN(SENTENCIA) - 1)      
WHERE      
 ID = @MAX_VARIABLES      
 
 
INSERT INTO @RESULTADO (SENTENCIA) VALUES      
(') AS'),      
('BEGIN'),      
(@TAB + 'BEGIN TRY'),      
(@TAB + @TAB + 'IF @OPCION = ''SELECT'''),      
(@TAB + @TAB + @TAB + 'BEGIN'),      
(@TAB + @TAB + @TAB + @TAB + 'SELECT')      
 
INSERT INTO @RESULTADO (SENTENCIA)      
SELECT       
 @TAB + @TAB + @TAB + @TAB + @TAB + NOMBRE + ', '      
FROM       
 @COLUMNAS      
ORDER BY      
 ID      
 
SET @MAX_VARIABLES = (SELECT MAX(ID) FROM @RESULTADO)      
 
UPDATE TOP(1)       
 @RESULTADO       
SET       
 SENTENCIA = REPLACE(SENTENCIA, ',', '')      
WHERE      
 ID = @MAX_VARIABLES      
 
INSERT INTO @RESULTADO (SENTENCIA) VALUES      
(@TAB + @TAB + @TAB + @TAB + 'FROM '),       
(@TAB + @TAB + @TAB + @TAB + @TAB + @TABLA + ' WITH(NOLOCK)')      
 
DECLARE @SENTENCIA_WHERE TABLE      
(      
 ID INT IDENTITY(1, 1),      
 SENTENCIA VARCHAR(200)      
)      
 
IF EXISTS (SELECT TOP(1) 0 FROM @COLUMNAS WHERE LLAVE = 1)      
BEGIN      
 INSERT INTO @SENTENCIA_WHERE (SENTENCIA) VALUES      
 (@TAB + @TAB + @TAB + @TAB + 'WHERE')      
 
 INSERT INTO @SENTENCIA_WHERE (SENTENCIA)      
 SELECT @TAB + @TAB + @TAB + @TAB + @TAB + NOMBRE + ' = @' + NOMBRE + ' AND' FROM @COLUMNAS WHERE LLAVE = 1            
 SET @MAX_VARIABLES = (SELECT MAX(ID) FROM @SENTENCIA_WHERE)      
 
 UPDATE TOP(1)       
  @SENTENCIA_WHERE       
 SET       
  SENTENCIA = REPLACE(SENTENCIA, 'AND', '')      
 WHERE      
  ID = @MAX_VARIABLES      
END      
 
INSERT INTO @RESULTADO (SENTENCIA)      
SELECT SENTENCIA FROM @SENTENCIA_WHERE ORDER BY ID      
 
INSERT INTO @RESULTADO (SENTENCIA) VALUES      
(@TAB + @TAB + @TAB + @TAB +'RETURN'),      
(@TAB + @TAB + @TAB + 'END'),      
(@TAB + @TAB),      
(@TAB + @TAB + 'ELSE IF @OPCION = ''INSERT'''),      
(@TAB + @TAB + @TAB + 'BEGIN'),      
(@TAB + @TAB + @TAB + @TAB + 'INSERT INTO ' + @TABLA),      
(@TAB + @TAB + @TAB + @TAB + '(')      
 
INSERT INTO @RESULTADO (SENTENCIA)       
SELECT @TAB + @TAB + @TAB + @TAB + @TAB + NOMBRE + ',' FROM @COLUMNAS where ISIDENTITY = 0 ORDER BY ID      
 
SET @MAX_VARIABLES = (SELECT MAX(ID) FROM @RESULTADO)      
 
UPDATE TOP(1)       
 @RESULTADO       
SET       
 SENTENCIA = REPLACE(SENTENCIA, ',', '')      
WHERE      
 ID = @MAX_VARIABLES      
 
INSERT INTO @RESULTADO (SENTENCIA) VALUES      
(@TAB + @TAB + @TAB + @TAB + ')'),      
(@TAB + @TAB + @TAB + @TAB + 'VALUES'),      
(@TAB + @TAB + @TAB + @TAB + '(')        
 
INSERT INTO @RESULTADO (SENTENCIA)       
SELECT @TAB + @TAB + @TAB + @TAB + @TAB + '@' + NOMBRE + ',' FROM @COLUMNAS where ISIDENTITY = 0 ORDER BY ID      
 
SET @MAX_VARIABLES = (SELECT MAX(ID) FROM @RESULTADO)      
 
UPDATE TOP(1)       
 @RESULTADO       
SET       
 SENTENCIA = REPLACE(SENTENCIA, ',', '')      
WHERE      
 ID = @MAX_VARIABLES      
 
INSERT INTO @RESULTADO (SENTENCIA) VALUES      
(@TAB + @TAB + @TAB + @TAB + ')'),      
(@TAB + @TAB + @TAB + @TAB),      
(@TAB + @TAB + @TAB + @TAB + 'SELECT ''1'' AS CORRECTO, ''INSERT'' AS MENSAJE'),      
(@TAB + @TAB + @TAB + @TAB + 'RETURN'),      
(@TAB + @TAB + @TAB + 'END'),      
(@TAB + @TAB),      
(@TAB + @TAB + 'ELSE IF @OPCION = ''UPDATE'''),      
(@TAB + @TAB + @TAB + 'BEGIN'),      
(@TAB + @TAB + @TAB + @TAB + 'UPDATE TOP(1)'),      
(@TAB + @TAB + @TAB + @TAB + @TAB + @TABLA),      
(@TAB + @TAB + @TAB + @TAB + 'SET')      
 
INSERT INTO @RESULTADO (SENTENCIA)      
SELECT @TAB + @TAB + @TAB + @TAB + @TAB + NOMBRE + ' = ISNULL(@' + NOMBRE + ', ' + NOMBRE + '),' FROM @COLUMNAS WHERE LLAVE = 0 and ISIDENTITY = 0 ORDER BY ID      
 
SET @MAX_VARIABLES = (SELECT MAX(ID) FROM @RESULTADO)      
 
UPDATE TOP(1)       
 @RESULTADO       
SET       
 SENTENCIA = SUBSTRING(SENTENCIA, 1, LEN(SENTENCIA) - 1)      
WHERE      
 ID = @MAX_VARIABLES      
 
INSERT INTO @RESULTADO (SENTENCIA)      
SELECT SENTENCIA FROM @SENTENCIA_WHERE ORDER BY ID      
 
INSERT INTO @RESULTADO (SENTENCIA) VALUES      
(@TAB + @TAB + @TAB + @TAB),      
(@TAB + @TAB + @TAB + @TAB + 'SELECT ''1'' AS CORRECTO, ''UPDATE REGISTROS: '' + CONVERT(VARCHAR, @@ROWCOUNT) AS MENSAJE'),      
(@TAB + @TAB + @TAB + @TAB + 'RETURN'),      
(@TAB + @TAB + @TAB + 'END'),      
(@TAB + @TAB),      
(@TAB + @TAB + 'ELSE IF @OPCION = ''UPDATE NULL'''),      
(@TAB + @TAB + @TAB + 'BEGIN'),      
(@TAB + @TAB + @TAB + @TAB + 'UPDATE TOP(1)'),      
(@TAB + @TAB + @TAB + @TAB + @TAB + @TABLA),      
(@TAB + @TAB + @TAB + @TAB + 'SET')      
 
INSERT INTO @RESULTADO (SENTENCIA)      
SELECT @TAB + @TAB + @TAB + @TAB + @TAB + NOMBRE + ' = @' + NOMBRE + ',' FROM @COLUMNAS WHERE LLAVE = 0 and ISIDENTITY = 0 ORDER BY ID      
 
SET @MAX_VARIABLES = (SELECT MAX(ID) FROM @RESULTADO)      
 
UPDATE TOP(1)       
 @RESULTADO       
SET       
 SENTENCIA = REPLACE(SENTENCIA, ',', '')      
WHERE      
 ID = @MAX_VARIABLES      
 
INSERT INTO @RESULTADO (SENTENCIA)      
SELECT SENTENCIA FROM @SENTENCIA_WHERE ORDER BY ID      
 
INSERT INTO @RESULTADO (SENTENCIA) VALUES      
(@TAB + @TAB + @TAB + @TAB),      
(@TAB + @TAB + @TAB + @TAB + 'SELECT ''1'' AS CORRECTO, ''UPDATE REGISTROS: '' + CONVERT(VARCHAR, @@ROWCOUNT) AS MENSAJE'),      
(@TAB + @TAB + @TAB + @TAB + 'RETURN'),      
(@TAB + @TAB + @TAB + 'END'),      
(@TAB + @TAB),      
(@TAB + @TAB + 'ELSE IF @OPCION = ''DELETE'''),      
(@TAB + @TAB + @TAB + 'BEGIN'),   
(@TAB + @TAB + @TAB + @TAB + 'DELETE TOP(1)'),      
(@TAB + @TAB + @TAB + @TAB + @TAB + @TABLA)      
 
INSERT INTO @RESULTADO (SENTENCIA)      
SELECT SENTENCIA FROM @SENTENCIA_WHERE ORDER BY ID      
 
INSERT INTO @RESULTADO (SENTENCIA) VALUES      
(@TAB + @TAB + @TAB + @TAB),      
(@TAB + @TAB + @TAB + @TAB + 'SELECT ''1'' AS CORRECTO, ''DELETE REGISTROS: '' + CONVERT(VARCHAR, @@ROWCOUNT) AS MENSAJE'),      
(@TAB + @TAB + @TAB + @TAB + 'RETURN'),      
(@TAB + @TAB + @TAB + 'END'),      
(@TAB + @TAB),      
(@TAB + @TAB + 'SELECT ''0'' AS CORRECTO, ''OPCIONES VÁLIDAS: SELECT, INSERT, UPDATE Y DELETE'' AS MENSAJE'),      
(@TAB + 'END TRY'),      
(@TAB + 'BEGIN CATCH'),      
(@TAB + @TAB + 'SELECT ''0'' AS CORRECTO, ERROR_MESSAGE() AS MENSAJE'),      
(@TAB + 'END CATCH'),      
('END')      
 
SELECT SENTENCIA FROM @RESULTADO 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SPS_ObtenZonaValorxEntidades]
(@ZONA VARCHAR(4)=null)
AS
BEGIN
SELECT ZVE.c_zonavalor,ZVE.D_ZONA AS 'IDENTIFICADOR', ZVE.m_valorMagna, ZVE.m_valorPremium, STUFF(
		(SELECT DISTINCT ', ' + ES.D_ENTIDAD 
			FROM CS_ESTACIONESSERVICIO ES
			INNER JOIN CS_ZONAVALORESTIMULO ZE 
			ON ZE.D_ZONA = ES.C_ZONA_CUARTO_DECRETO
			WHERE ES.C_ZONA_CUARTO_DECRETO LIKE ZVE.D_ZONA 
			FOR XML PATH('')),
			1,2,'') AS 'ENTIDADES'
	FROM CS_ZONAVALORESTIMULO ZVE
	WHERE ZVE.D_ZONA LIKE CASE WHEN @ZONA IS NULL THEN ZVE.D_ZONA ELSE @ZONA END
END
GO

/********************* TERMINA CREA  STORED **********************************/

USE [master]
GO
ALTER DATABASE [covol] SET  READ_WRITE 
GO
