# -- Query de cálculo de subtotales sin iva y con iva para producto.
# - Importante tener presente que un escenario es con todos los estados y el otro es sin códigos 10 y 11.
# - Estos filtros se realizan en Excel.
# - Importante: Ajustar Query para que haga sumatorias automáticas.

SELECT 
	BQ_ProductsLines.FechaOrden,
    BQ_ProductsLines.IdOrden,
    BQ_ProductsLines.StatusID,
    BQ_ProductsLines.IdProducto,
    BQ_ProductsLines.CostoVenta,
    BQ_ProductsLines.Subtotal_IVA,
    BQ_ProductsLines.Subtotal_SinIVA,
    BQ_ProductsLines.IVA
FROM
	BQ_ProductsLines
WHERE
	BQ_ProductsLines.FechaOrden >= '2017-01-01 00:00:00' AND              
    (BQ_ProductsLines.StatusID = '2'
				OR BQ_ProductsLines.StatusID = '4'
				OR BQ_ProductsLines.StatusID = '5'
				OR BQ_ProductsLines.StatusID = '6'
				OR BQ_ProductsLines.StatusID = '12'
				OR BQ_ProductsLines.StatusID = '10'
				OR BQ_ProductsLines.StatusID = '11');
                

