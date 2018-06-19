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

# --- VALIDACIÓN DATA INFORME JUNTA DIRECTIVA

SELECT
	BQ_ProductsLines.FechaOrden,
    BQ_ProductsLines.IdOrden,
    BQ_ProductsLines.Producto,
    BQ_ProductsLines.IdProducto,
    BQ_ProductsLines.IVA,
    BQ_ProductsLines.CostoVenta,
    BQ_ProductsLines.PrecioVenta
FROM
	BQ_ProductsLines
WHERE
	BQ_ProductsLines.FechaOrden >= '2018-01-01 00:00:00';


SELECT
    CONCAT(YEAR(BQ_Orders.FechaOrden), MONTH(BQ_Orders.FechaOrden)) AS 'Anio_Mes',	
    SUM(BQ_Orders.CostoEnvio) AS 'CostoEnvio'
FROM
	BQ_Orders
WHERE
	BQ_Orders.FechaOrden >= '2018-01-01 00:00:00' AND
    BQ_Orders.StatusAgrupado = 'Aceptada'
GROUP BY
	Anio_Mes;


SELECT
    CONCAT(YEAR(BQ_ProductsLines.FechaOrden), MONTH(BQ_ProductsLines.FechaOrden)) AS 'Anio_Mes',	
    SUM(BQ_ProductsLines.Contribucion_IVA),
    SUM(BQ_ProductsLines.Contribucion_SinIVA)
FROM
	BQ_ProductsLines
WHERE
	BQ_ProductsLines.FechaOrden >= '2018-01-01 00:00:00'
GROUP BY
	Anio_Mes;


SELECT
    CONCAT(YEAR(BQ_ProductsLines.FechaOrden), MONTH(BQ_ProductsLines.FechaOrden)) AS 'Anio_Mes',	
    SUM(BQ_ProductsLines.Contribucion_IVA),
    SUM(BQ_ProductsLines.Contribucion_SinIVA)
FROM
	BQ_ProductsLines
WHERE
	BQ_ProductsLines.FechaOrden >= '2018-01-01 00:00:00'
GROUP BY
	Anio_Mes;


# ---
SELECT
	BQ_ProductsLines.FechaOrden,
    YEAR(BQ_ProductsLines.FechaOrden) AS 'Anio',
    MONTHNAME(BQ_ProductsLines.FechaOrden) AS 'Mes',
    BQ_ProductsLines.IdOrden,
    BQ_ProductsLines.Linea,
    BQ_ProductsLines.Marca,
    BQ_ProductsLines.Producto,
    BQ_ProductsLines.Campana
FROM
	BQ_ProductsLines
WHERE
	BQ_ProductsLines.FechaOrden >= '2018-03-27 00:00:00';

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
    BQ_ProductsLines.NIT,
    SUM(BQ_ProductsLines.Cantidad) AS 'Cantidad',
    SUM(BQ_ProductsLines.Subtotal_IVA) AS 'Subtotal_IVA',
    SUM(BQ_ProductsLines.Subtotal_SinIVA) AS 'Subtotal_SinIVA'
FROM
	BQ_ProductsLines
GROUP BY
	Anio_Mes, BQ_ProductsLines.Linea, BQ_ProductsLines.Campana, BQ_ProductsLines.Marca, BQ_ProductsLines.NombreProveedor
ORDER BY
	BQ_ProductsLines.FechaOrden;





# --- Consulta: Ranking de campañas OK
# --- Agrupación por: Año, Mes, Línea, Campaña, Marca, Proveedor

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
    

SELECT * FROM BQ_ProductsLines WHERE BQ_ProductsLines.FechaOrden >= '2018-01-01 00:00:00';



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
	BQ_Acquisitions.FechaOrden,
    BQ_Acquisitions.Orden,
    BQ_Acquisitions.TipoOrden,
    BQ_Acquisitions.Email
FROM
	BQ_Acquisitions;

    
#WHERE
#	BQ_Acquisitions.created >= '2018-03-27 00:00:00';


# ---- Query from: BQ_Orders

SELECT * FROM BQ_Orders;

SELECT
	CONCAT(YEAR(BQ_Orders.FechaOrden), MONTH(BQ_Orders.FechaOrden)) AS 'Anio_Mes',
    YEAR(BQ_Orders.FechaOrden) AS 'Anio', 
    MONTH(BQ_Orders.FechaOrden) AS 'Mes',
    BQ_Orders.IdOrden,
    BQ_Orders.Email	
FROM
	BQ_Orders
WHERE
    BQ_Orders.StatusAgrupado = 'Aceptada' AND
    BQ_Orders.FechaOrden >= '2017-01-01 00:00:00';
    

SELECT
	CONCAT(YEAR(BQ_ProductsLines.FechaOrden), MONTH(BQ_ProductsLines.FechaOrden)) AS 'Anio_Mes',
    SUM(BQ_ProductsLines.Subtotal_IVA) AS 'Subtotal_IVA',
    SUM(BQ_ProductsLines.Subtotal_SinIVA) AS 'Subtotal_SinIVA',
    SUM(BQ_ProductsLines.TotalCosto_IVA) AS 'TotalCosto_IVA',
    SUM(BQ_ProductsLines.TotalCosto_SinIVA) AS 'TotalCosto_SinIVA'
FROM
	BQ_ProductsLines
WHERE
    BQ_ProductsLines.FechaOrden >= '2017-01-01 00:00:00'
GROUP BY
	Anio_Mes;
    
SELECT * FROM BQ_ProductsLines WHERE BQ_ProductsLines.FechaOrden >= '2018-03-01 00:00:00';

SELECT
	*
FROM
	orders
WHERE orders.id = '927138';

SELECT
	*
FROM
	orders_products
WHERE orders_products.orderId = '927138';

