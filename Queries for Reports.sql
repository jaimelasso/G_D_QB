# --- Reporte: Adquisiciones por canal (Google Analytics)
# --- Área: Marketing

SELECT
	BQ_Acquisitions.Orden,
    BQ_Acquisitions.FechaOrden,
    BQ_Acquisitions.AnioOrden,
    BQ_Acquisitions.MesOrden,
    BQ_Acquisitions.Email,
    BQ_Acquisitions.Status,
    BQ_Acquisitions.TipoOrden,
    BQ_Acquisitions.FuenteFinal
FROM
	BQ_Acquisitions
WHERE
	BQ_Acquisitions.FechaOrden >= '2018-03-21 00:00:00'; 
    

SELECT
	*
FROM
	BQ_Acquisitions
WHERE
	BQ_Acquisitions.FechaOrden >= '2018-03-21 00:00:00';