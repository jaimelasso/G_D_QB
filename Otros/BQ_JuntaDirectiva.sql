# --Ordenes totales, GMV y Tiquete Promedio
# Nota: Tener presente variación de cantidades debido a órdenes con subtotal 0 en tabla orders. Dato referencia: Enero 2018 (5.505).
# Nota: Se toma variable "orders.Total" para cálculo GMV debido a diferencias entre BackOffice y tabla BDD.

SELECT
	YEAR(BQ_Orders.FechaOrden) * 100 + month(BQ_Orders.FechaOrden) AS 'Anio_mes',
    COUNT(DISTINCT(BQ_Orders.IdOrden)) AS 'Cantidad ordenes',
    ROUND(SUM(BQ_Orders.Total), 0) AS 'GMV',
    ROUND(SUM(BQ_Orders.Total) / COUNT(DISTINCT(BQ_Orders.IdOrden)), 0) AS 'Tiquete Promedio'
FROM
	BQ_Orders
WHERE
	BQ_Orders.StatusAgrupado = 'Aceptada'
GROUP BY Anio_mes
ORDER BY Anio_mes ASC;

# --Contribución Bruta ($)
# Cálculo: Venta Bruta (Subtotal IVA) - Costo Bruto (Total Costo IVA)

SELECT
	YEAR(BQ_ProductsLines.FechaOrden) * 100 + month(BQ_ProductsLines.FechaOrden) AS 'Anio_mes',
	ROUND(SUM(BQ_ProductsLines.Subtotal_IVA), 0) AS 'Subtotal IVA',
    ROUND(SUM(BQ_ProductsLines.TotalCosto_IVA), 0) AS 'Costo IVA',
    ROUND((SUM(BQ_ProductsLines.Subtotal_IVA) - SUM(BQ_ProductsLines.TotalCosto_IVA)), 0) AS 'Contribución Bruta'
FROM
	BQ_ProductsLines
GROUP BY Anio_mes
ORDER BY Anio_mes ASC;

# --Cantidad de nuevas marcas
# Pendiente.

# --Venta por categoría en GMV (%)
# Se calculan valores absolutos. En GSheets se transforma en %.

SELECT
	YEAR(BQ_ProductsLines.FechaOrden) * 100 + month(BQ_ProductsLines.FechaOrden) AS 'Anio_mes',
	BQ_ProductsLines.Linea AS 'Linea',
	SUM(BQ_ProductsLines.Subtotal_IVA) AS 'Subtotal IVA',
	SUM(BQ_ProductsLines.)	


# --------------------------------------------------------------- MARKETING

# --Active Costumers

SELECT
	YEAR(BQ_Orders.FechaOrden) * 100 + month(BQ_Orders.FechaOrden) AS 'Anio_mes',
	COUNT(DISTINCT(BQ_Orders.Email)) AS 'Active Costumers'
FROM
	BQ_Orders
WHERE
	BQ_Orders.StatusAgrupado = 'Aceptada'
GROUP BY Anio_mes
ORDER BY Anio_mes ASC;

# --Adquisiciones por fuente
# Para cálculos por fuente, se deben quitar # dependiendo del análisis.
SELECT
	YEAR(BQ_Acquisitions.FechaOrden) * 100 + month(BQ_Acquisitions.FechaOrden) AS 'Anio_mes',
	COUNT(DISTINCT(BQ_Acquisitions.Orden)) AS 'Adquisiciones'
FROM
	BQ_Acquisitions
WHERE
	BQ_Acquisitions.TipoOrden = 'Adquisición'
    #AND BQ_Acquisitions.Source_name = 'Movil App'
    #AND BQ_Acquisitions.Source_name = 'Movil Web'
    #AND BQ_Acquisitions.Source_name = 'Web'
GROUP BY Anio_mes
ORDER BY Anio_mes ASC;

#-- Ordenes aceptadas vs rechazadas

SELECT
	YEAR(BQ_Orders.FechaOrden) * 100 + month(BQ_Orders.FechaOrden) AS 'Anio_mes',
	COUNT(BQ_Orders.IdOrden),
    BQ_Orders.StatusAgrupado AS 'StatusA'
FROM
	BQ_Orders 
WHERE 
	BQ_Orders.FechaOrden >= '2017-05-01 00:00:00'
GROUP BY Anio_mes, StatusA
ORDER BY Anio_mes, StatusA ASC;


#-- Detalle ordenes rechazas
SELECT
	YEAR(BQ_Orders.FechaOrden) * 100 + month(BQ_Orders.FechaOrden) AS 'Anio_mes',
	COUNT(BQ_Orders.IdOrden),
    BQ_Orders.StatusOrden AS 'Status'
FROM
	BQ_Orders 
WHERE 
	BQ_Orders.FechaOrden >= '2017-05-01 00:00:00'
    AND BQ_Orders.StatusAgrupado = 'Rechazada'
GROUP BY Anio_mes, Status
ORDER BY Anio_mes, Status ASC;

# Ventas por Categoría (%)
SELECT
	YEAR(BQ_ProductsLines.FechaOrden) 'Anio',
    BQ_ProductsLines.Linea AS 'Linea',
    SUM(BQ_ProductsLines.Subtotal_IVA) AS 'Ventas'
FROM
	BQ_ProductsLines
WHERE 
	BQ_ProductsLines.FechaOrden >= '2018-01-01 00:00:00'
GROUP BY Anio, Linea
ORDER BY Anio, Linea ASC;

# --Usuarios con más de una orden por periodo
# Nota: Se debe exportar a excel, hacer tabla dinámica y filtrar solo por los de más de 1 orden.
SELECT
	YEAR(BQ_Orders.FechaOrden) * 100 + month(BQ_Orders.FechaOrden) AS 'Anio_mes',
	BQ_Orders.Email AS 'Usuario',
    COUNT(BQ_Orders.IdOrden) AS 'Cantidad Ordenes'
FROM
	BQ_Orders
WHERE 
	BQ_Orders.FechaOrden >= '2018-01-01 00:00:00'
    AND BQ_Orders.StatusAgrupado = 'Aceptada'
GROUP BY Anio_mes, Usuario
ORDER BY Anio_mes ASC;


SELECT
	BQ_Orders.FechaOrden,
	BQ_Orders.Email AS 'Usuario',
    BQ_Orders.IdOrden AS 'Cantidad Ordenes'
FROM
	BQ_Orders
WHERE 
	BQ_Orders.FechaOrden >= '2018-01-01 00:00:00'
    AND BQ_Orders.StatusAgrupado = 'Aceptada'
GROUP BY Usuario
ORDER BY Anio_mes ASC;


# QUERIES CAMILO: MARCAS, CAMPAÑAS Y PROVEEDORES ACTIVOS.
camilo.mondragon [09:16]
select year(products.created)*100+month(products.created), count(distinct(products.id)) as productos,  count(distinct(products.manufacturerId)) as Marcas,count(distinct(manufacturers_providers.providerId)) as Proveedores
from products

left join manufacturers_providers
on(products.manufacturerId=manufacturers_providers.manufacturerId)
group by year(products.created)*100+month(products.created)


select year(campaigns.start)*100+month(campaigns.start),count(distinct(campaigns.id))
from campaigns

group by year(campaigns.start)*100+month(campaigns.start)





# ----------------------------------- ESTADOS FINANCIEROS ------------------------------------------------------------


# --Ordenes aceptadas y GMV.
SELECT
	YEAR(BQ_Orders.FechaOrden) * 100 + MONTH(BQ_Orders.FechaOrden) AS 'Anio_Mes',
    ROUND(SUM(BQ_Orders.Total), 0) AS 'GMV',
    COUNT(DISTINCT(BQ_Orders.IdOrden)) AS 'Cantidad Ordenes'
FROM
	BQ_Orders
WHERE
	BQ_Orders.StatusAgrupado = 'Aceptada'
GROUP BY
	Anio_Mes;
    
# -- ACQ
SELECT
	YEAR(BQ_Acquisitions.created) * 100 + MONTH(BQ_Acquisitions.created) AS 'Anio_Mes',
    COUNT(DISTINCT(BQ_Acquisitions.id)) AS 'Adquisiciones'
FROM
	BQ_Acquisitions
WHERE
	BQ_Acquisitions.TipoOrden = 'Adquisicion'
GROUP BY
	Anio_Mes;
	
