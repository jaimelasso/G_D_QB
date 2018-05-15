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
    
    
    
# --- Reporte: KPI's Comité General
# -- Área: Geelbe
# -- Hoja: Ranking Campañas - $ Ventas
# -- Nombre conector MySQL: Geelbe - Campaigns Top 10
    
SELECT
	BQ_ProductsLines.FechaOrden,
    YEAR(BQ_ProductsLines.FechaOrden) AS 'Anio',
    MONTHNAME(BQ_ProductsLines.FechaOrden) AS 'Mes',
    BQ_ProductsLines.Linea,
    BQ_ProductsLines.Campana,
    BQ_ProductsLines.Marca,
    BQ_ProductsLines.NombreProveedor,
    BQ_ProductsLines.NIT,
    SUM(BQ_ProductsLines.Cantidad) AS 'Cantidad',
    SUM(BQ_ProductsLines.Subtotal_IVA) AS 'Subtotal_IVA',
    SUM(BQ_ProductsLines.Subtotal_SinIVA) AS 'Subtotal_SinIVA',
    (SUM(BQ_ProductsLines.Subtotal_IVA) / SUM(BQ_ProductsLines.Cantidad)) AS 'TiquetePromedio',
    SUM(BQ_ProductsLines.Contribucion_IVA) AS 'Contribucion_IVA',
    SUM(BQ_ProductsLines.Contribucion_SinIVA) AS 'Contribucion_SinIVA',
    (SUM(BQ_ProductsLines.Contribucion_IVA) / SUM(BQ_ProductsLines.Subtotal_IVA)) AS 'MargenContribucion'
FROM
	BQ_ProductsLines
GROUP BY
	Anio, Mes, BQ_ProductsLines.Linea, BQ_ProductsLines.Campana, BQ_ProductsLines.Marca, BQ_ProductsLines.NombreProveedor
ORDER BY
	BQ_ProductsLines.FechaOrden;
    
# --- Reporte: KPI's Comité General
# -- Área: Geelbe
# -- Hoja: Ranking Productos - $ Ventas
# -- Nombre conector MySQL: Geelbe - Products Top 10
    
SELECT
	BQ_ProductsLines.FechaOrden,
    YEAR(BQ_ProductsLines.FechaOrden) AS 'Anio',
    MONTHNAME(BQ_ProductsLines.FechaOrden) AS 'Mes',
    BQ_ProductsLines.Linea,
    BQ_ProductsLines.Producto,
    BQ_ProductsLines.Marca,
    BQ_ProductsLines.NombreProveedor,
    BQ_ProductsLines.NIT,
    SUM(BQ_ProductsLines.Cantidad) AS 'Cantidad',
    SUM(BQ_ProductsLines.Subtotal_IVA) AS 'Subtotal_IVA',
    SUM(BQ_ProductsLines.Subtotal_SinIVA) AS 'Subtotal_SinIVA',
    (SUM(BQ_ProductsLines.Subtotal_IVA) / SUM(BQ_ProductsLines.Cantidad)) AS 'TiquetePromedio',
    SUM(BQ_ProductsLines.Contribucion_IVA) AS 'Contribucion_IVA',
    SUM(BQ_ProductsLines.Contribucion_SinIVA) AS 'Contribucion_SinIVA',
    (SUM(BQ_ProductsLines.Contribucion_IVA) / SUM(BQ_ProductsLines.Subtotal_IVA)) AS 'MargenContribucion'
FROM
	BQ_ProductsLines
GROUP BY
	Anio, Mes, BQ_ProductsLines.Linea, BQ_ProductsLines.Producto, BQ_ProductsLines.Marca, BQ_ProductsLines.NombreProveedor
ORDER BY
	BQ_ProductsLines.FechaOrden;
    
# --- Reporte: KPI's Comité General
# -- Área: Geelbe
# -- Hoja: Ranking Proveedores - $ Ventas
# -- Nombre conector MySQL: Geelbe - Proveedores Top 10
    
SELECT
	BQ_ProductsLines.FechaOrden,
    YEAR(BQ_ProductsLines.FechaOrden) AS 'Anio',
    MONTHNAME(BQ_ProductsLines.FechaOrden) AS 'Mes',
    BQ_ProductsLines.Linea,
    BQ_ProductsLines.NombreProveedor AS 'Proveedor',
    BQ_ProductsLines.Marca,
    BQ_ProductsLines.NIT,
    SUM(BQ_ProductsLines.Cantidad) AS 'Cantidad',
    SUM(BQ_ProductsLines.Subtotal_IVA) AS 'Subtotal_IVA',
    SUM(BQ_ProductsLines.Subtotal_SinIVA) AS 'Subtotal_SinIVA',
    (SUM(BQ_ProductsLines.Subtotal_IVA) / SUM(BQ_ProductsLines.Cantidad)) AS 'TiquetePromedio',
    SUM(BQ_ProductsLines.Contribucion_IVA) AS 'Contribucion_IVA',
    SUM(BQ_ProductsLines.Contribucion_SinIVA) AS 'Contribucion_SinIVA',
    (SUM(BQ_ProductsLines.Contribucion_IVA) / SUM(BQ_ProductsLines.Subtotal_IVA)) AS 'MargenContribucion'
FROM
	BQ_ProductsLines
GROUP BY
	Anio, Mes, BQ_ProductsLines.Linea, BQ_ProductsLines.IdProveedor, BQ_ProductsLines.Marca
ORDER BY
	BQ_ProductsLines.FechaOrden;