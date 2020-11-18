use Covol
go

DROP FUNCTION [dbo].[fn_split];
GO

DROP FUNCTION [dbo].[fn_split_string_to_column];
GO

DROP TABLE [dbo].[cs_subproductos];
GO

DROP TABLE [dbo].[dd_vtadetalle];
GO

DROP TABLE [dbo].[cs_EntidadesFederativas];
GO

DROP TABLE [dbo].[cs_estacionesservicio];
GO

DROP TABLE [dbo].[cs_estadotanque];
GO

DROP TABLE [dbo].[cs_expendios];
GO

DROP TABLE [dbo].[cs_marcas];
GO

DROP TABLE [dbo].[cs_perfil];
GO

DROP TABLE [dbo].[cs_productos];
GO

DROP TABLE [dbo].[cs_statuscruce];
GO

DROP TABLE [dbo].[cs_tiporegistro];
GO

DROP TABLE [dbo].[cs_usuario];
GO

DROP TABLE [dbo].[cs_valorestimulo];
GO

DROP TABLE [dbo].[cs_ZonaValorEstimulo];
GO

DROP TABLE [dbo].[dd_dispensario];
GO

DROP TABLE [dbo].[dd_existencias];
GO

DROP TABLE [dbo].[dd_reccabecera];
GO

DROP TABLE [dbo].[dd_recdetalle];
GO

DROP TABLE [dbo].[dd_recdocumentos];
GO

DROP TABLE [dbo].[dd_tanques];
GO

DROP TABLE [dbo].[dd_vtacabecera];
GO

DROP TABLE [dbo].[mm_consolidado];
GO

DROP TABLE [dbo].[mm_Log];
GO

DROP TABLE [dbo].[mm_resultadoCarga];
GO

DROP TABLE [dbo].[mm_controlvolumetrico];
GO

DROP VIEW [dbo].[vw_reportecruces];
GO

DROP PROCEDURE [dbo].[sp_ActualizarPerfil];
GO

DROP PROCEDURE [dbo].[sp_ActualizarProcesados];
GO

DROP PROCEDURE [dbo].[sp_ActualizarSubProducto];
GO

DROP PROCEDURE [dbo].[sp_ActualizarTipoProducto];
GO

DROP PROCEDURE [dbo].[sp_ActualizarValorEstimulo];
GO

DROP PROCEDURE [dbo].[sp_AgregarPerfil];
GO

DROP PROCEDURE [dbo].[sp_AgregarSubProducto];
GO

DROP PROCEDURE [dbo].[sp_AgregarTipoProducto];
GO

DROP PROCEDURE [dbo].[sp_AgregarValorEstimulo];
GO

DROP PROCEDURE [dbo].[sp_Cabecera];
GO

DROP PROCEDURE [dbo].[sp_Consolidado];
GO

DROP PROCEDURE [dbo].[sp_ConsolidadoRFCPeriodo];
GO

DROP PROCEDURE [dbo].[sp_ControlVolumetricosXML];
GO

DROP PROCEDURE [dbo].[sp_cruceroControlVolumetrico];
GO

DROP PROCEDURE [dbo].[sp_EliminarPerfil];
GO

DROP PROCEDURE [dbo].[sp_EliminarSubProducto];
GO

DROP PROCEDURE [dbo].[sp_EliminarTipoProducto];
GO

DROP PROCEDURE [dbo].[sp_EliminarValorEstimulo];
GO

DROP PROCEDURE [dbo].[sp_Excedentes];
GO

DROP PROCEDURE [dbo].[sp_InsertaConsolidado];
GO

DROP PROCEDURE [dbo].[sp_LOG];
GO

DROP PROCEDURE [dbo].[sp_MapaEstacionesServ];
GO

DROP PROCEDURE [dbo].[sp_MapaEstacionesServDet];
GO

DROP PROCEDURE [dbo].[sp_ObtenerCatalogoPerfiles];
GO

DROP PROCEDURE [dbo].[sp_ObtenerDetalleCarga];
GO

DROP PROCEDURE [dbo].[sp_ObtenerEstadisticaLogMarcadores];
GO

DROP PROCEDURE [dbo].[sp_ObtenerPerfil];
GO

DROP PROCEDURE [dbo].[sp_ObtenerResultadoCarga];
GO

DROP PROCEDURE [dbo].[sp_ObtenerSubProducto];
GO

DROP PROCEDURE [dbo].[sp_ObtenerTipoProducto];
GO

DROP PROCEDURE [dbo].[sp_ObtenerValorEstimulo];
GO

DROP PROCEDURE [dbo].[sp_PendientesConsolidado];
GO

DROP PROCEDURE [dbo].[sp_PendientesDetalleConsolidado];
GO

DROP PROCEDURE [dbo].[sp_ResultadoCarga];
GO

DROP PROCEDURE [dbo].[sp_rptControlVol];
GO

DROP PROCEDURE [dbo].[sp_rptControlVolDeta];
GO

DROP PROCEDURE [dbo].[sp_rptCtrolVolVtaMovimientos];
GO

DROP PROCEDURE [dbo].[sps_ConsolidadoReporte];
GO

DROP PROCEDURE [dbo].[SPS_GENERA_ABC];
GO

DROP PROCEDURE [dbo].[SPS_ObtenZonaValorxEntidades];
GO