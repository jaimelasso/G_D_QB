# --- Query from: BQ_Product_Lines
# ---Query genérico de consultas puntuales

SELECT
    CONCAT(YEAR(BQ_ProductsLines.FechaOrden), MONTH(BQ_ProductsLines.FechaOrden)) AS 'Anio_Mes',
    SUM(BQ_ProductsLines.Subtotal_IVA) AS 'Subtotal_IVA',
    SUM(BQ_ProductsLines.Subtotal_SinIVA) AS 'Subtotal_SinIVA'
FROM
	BQ_ProductsLines
GROUP BY
	Anio_Mes;




select * from BQ_ProductsLines;

# --- Query from: BQ_Product_Lines
# --- Consulta: TOP 10 - Campañas
# --- Agrupación por: Año_mes, Línea, Campaña, Marca y Proveedor

SELECT
	BQ_ProductsLines.FechaOrden,
    CONCAT(YEAR(BQ_ProductsLines.FechaOrden), MONTH(BQ_ProductsLines.FechaOrden)) AS 'Anio_Mes',
    BQ_ProductsLines.Linea,
    BQ_ProductsLines.Campana,
    BQ_ProductsLines.Marca,
    BQ_ProductsLines.NombreProveedor,
    SUM(BQ_ProductsLines.Cantidad) AS 'Cantidad',
    SUM(BQ_ProductsLines.Subtotal_IVA) AS 'Subtotal_IVA',
    SUM(BQ_ProductsLines.Subtotal_SinIVA) AS 'Subtotal_SinIVA'
FROM
	BQ_ProductsLines
GROUP BY
	Anio_Mes, BQ_ProductsLines.Linea, BQ_ProductsLines.Campana, BQ_ProductsLines.Marca, BQ_ProductsLines.NombreProveedor
ORDER BY
	BQ_ProductsLines.FechaOrden;



    


# ---Consulta Ranking Top mujer
# Hacer un ranking de los tops de mujer (camisas, Camisetas, blusas, incluso vestidos) Mas vendidos desde el 2015, excluyendo deportivos.

SELECT
	BQ_ProductsLines.FechaOrden,
    BQ_ProductsLines.IdOrden,
    BQ_ProductsLines.Linea,
    BQ_ProductsLines.Categoria,
    BQ_ProductsLines.categoriaId,
    BQ_ProductsLines.Producto,
    BQ_ProductsLines.value AS 'Talla',
    BQ_ProductsLines.PrecioVenta,
    BQ_ProductsLines.Cantidad,
    BQ_ProductsLines.Subtotal_IVA AS 'Subtotal_IVA',
    BQ_ProductsLines.Subtotal_SinIVA AS 'Subtotal_SinIVA'
FROM BQ_ProductsLines
WHERE
	BQ_ProductsLines.categoriaId = 'G02010101' OR
    BQ_ProductsLines.categoriaId = 'G02010106' OR
    BQ_ProductsLines.categoriaId = 'G02010202' OR
    BQ_ProductsLines.categoriaId = 'G02010209';











# ---- Query from: BQ_Acquisitions

SELECT
	BQ_Acquisitions.created,
    BQ_Acquisitions.Orden,
    BQ_Acquisitions.TipoOrden
FROM
	BQ_Acquisitions
WHERE
	BQ_Acquisitions.created >= '2018-03-01 00:00:00';


# ---- Query from: BQ_Orders

SELECT * FROM BQ_Orders;

SELECT
	CONCAT(YEAR(BQ_Orders.FechaOrden), MONTH(BQ_Orders.FechaOrden)) AS 'Anio_Mes',
    SUM(BQ_Orders.Total) AS 'Total'
FROM
	BQ_Orders
WHERE
    BQ_Orders.StatusAgrupado = 'Aceptada'
GROUP BY
    Anio_Mes;
    
    
    