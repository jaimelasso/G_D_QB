# -- Query de cálculo de subtotales sin iva y con iva para producto.
# - Importante tener presente que un escenario es con todos los estados ACEPTADOS y el otro es sin códigos 10 y 11.
# - Estos filtros se realizan en Excel.
# - Importante: Ajustar Query para que haga sumatorias automáticas.

SELECT 
	YEAR(BQ_ProductsLines.FechaOrden) AS 'Anio',
    MONTHNAME(BQ_ProductsLines.FechaOrden) AS 'Mes',
    YEAR(BQ_ProductsLines.FechaOrden) * 100 + MONTHNAME(BQ_ProductsLines.FechaOrden) AS 'Anio_mes',    
    BQ_ProductsLines.IdOrden,
    BQ_ProductsLines.StatusID,
    BQ_ProductsLines.IdProducto,
    BQ_ProductsLines.TotalCosto_IVA,
    BQ_ProductsLines.TotalCosto_SinIVA,
    BQ_ProductsLines.Subtotal_IVA,
    BQ_ProductsLines.Subtotal_SinIVA,
    BQ_ProductsLines.IVA,
	orders_status.name AS 'Status Orden'
FROM
	BQ_ProductsLines
LEFT JOIN orders_status
	ON (orders_status.id = BQ_ProductsLines.StatusID)
WHERE
	BQ_ProductsLines.FechaOrden >= '2018-01-01 00:00:00';