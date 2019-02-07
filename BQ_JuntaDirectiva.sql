# --Consulta que muestra las órdenes de cada mes que fueron usadas para los cálculos financieros.
# -IMPORTANTE: Revisar mes a mes por qué varía la data.
SELECT
	BQ_ProductsLines.FechaOrden,
	BQ_ProductsLines.IdOrden,
	BQ_ProductsLines.StatusID,
	BQ_ProductsLines.EstadoOrden,
	BQ_ProductsLines.Producto,
	BQ_ProductsLines.Cantidad,
	BQ_ProductsLines.Subtotal_IVA,
	BQ_ProductsLines.Subtotal_SinIVA,
	BQ_ProductsLines.TotalCosto_IVA,
	BQ_ProductsLines.TotalCosto_SinIVA
FROM
	BQ_ProductsLines
WHERE
	BQ_ProductsLines.FechaOrden >= '2018-08-01';




# -- USAR ESTE QUERY PARA ALIMENTAR DATA DE GSHEETS "Data Gráfica Informe Junta Directiva v1", hoja: "Data Query (Ingreso y costo bruto)".
# - Importante tener presente que un escenario es con todos los estados ACEPTADOS y el otro es sin códigos 10 y 11.

    
# --Query Resumen GEELBE
# -Todos los estados.
SELECT
	BQ_ProductsLines.Anio_Mes AS 'Anio_mes',
	COUNT(DISTINCT(BQ_ProductsLines.IdOrden)) AS '# Orden',	
    SUM(BQ_ProductsLines.Subtotal_SinIVA) AS 'Ingreso sin IVA',
    SUM(BQ_ProductsLines.TotalCosto_SinIVA) AS 'Costo sin IVA'
FROM
	BQ_ProductsLines
WHERE
	BQ_ProductsLines.FechaOrden >= '2018-01-01'
GROUP BY
	Anio_mes;
    
# -Sin estados: Devolución de Dinero (10) y Reversado (11).
SELECT
	BQ_ProductsLines.Anio_Mes AS 'Anio_mes',
	COUNT(DISTINCT(BQ_ProductsLines.IdOrden)) AS '# Orden',
    SUM(BQ_ProductsLines.Subtotal_SinIVA) AS 'Ingreso sin IVA',
    SUM(BQ_ProductsLines.TotalCosto_SinIVA) AS 'Costo sin IVA'
FROM
	BQ_ProductsLines
WHERE
	BQ_ProductsLines.FechaOrden >= '2018-01-01' AND
	BQ_ProductsLines.StatusID <> '10' AND
	BQ_ProductsLines.StatusID <> '11'    
GROUP BY
	Anio_mes;
    

# -Davivienda
# -Todos los estados. (Es excluye ventas por Marketplace, identificados como NULL en IVA.
SELECT
	BQ_ProductsLines.Anio_Mes AS 'Anio_mes',
	COUNT(DISTINCT(BQ_ProductsLines.IdOrden)) AS '# Orden',	
    SUM(BQ_ProductsLines.Subtotal_SinIVA) AS 'Ingreso sin IVA',
    SUM(BQ_ProductsLines.TotalCosto_SinIVA) AS 'Costo sin IVA'
FROM
	BQ_ProductsLines
WHERE
	BQ_ProductsLines.FechaOrden >= '2018-01-01' AND
    BQ_ProductsLines.IVA IS NOT NULL
GROUP BY
	Anio_mes;
    
# -Sin estados: Devolución de Dinero (10) y Reversado (11). (Se excluye ventas por Marketplace, identificados como NULL en IVA.
SELECT
	BQ_ProductsLines.Anio_Mes AS 'Anio_mes',
	COUNT(DISTINCT(BQ_ProductsLines.IdOrden)) AS '# Orden',	
    SUM(BQ_ProductsLines.Subtotal_SinIVA) AS 'Ingreso sin IVA',
    SUM(BQ_ProductsLines.TotalCosto_SinIVA) AS 'Costo sin IVA'
FROM
	BQ_ProductsLines
WHERE
	BQ_ProductsLines.FechaOrden >= '2018-01-01' AND
    BQ_ProductsLines.IVA IS NOT NULL AND
	BQ_ProductsLines.StatusID <> '10' AND
	BQ_ProductsLines.StatusID <> '11'   
GROUP BY
	Anio_mes;

------------------------

# ---USAR ESTE QUERY PARA ALIMENTAR DATA DE GSHEETS "Data Gráfica Informe Junta Directiva v1", hoja: "Data Estados Financieros".
# --QUERY RESUMEN GEELBE
# -Parte 1
SELECT
	YEAR(BQ_Orders.FechaOrden) * 100 + month(BQ_Orders.FechaOrden) AS 'Anio_mes',
    COUNT(DISTINCT(BQ_Orders.IdOrden)) AS 'Cantidad ordenes',
    ROUND(SUM(BQ_Orders.Total), 0) AS 'GMV',
    ROUND(SUM(BQ_Orders.Total) / COUNT(DISTINCT(BQ_Orders.IdOrden)), 0) AS 'Tiquete Promedio',
    SUM(BQ_Orders.CostoEnvio) AS 'Costo de Envío',
    SUM(BQ_Orders.Descuento) AS 'Descuentos',
    SUM(BQ_Orders.Creditos) AS 'Creditos'
FROM
	BQ_Orders
WHERE
	BQ_Orders.StatusAgrupado = 'Aceptada'
GROUP BY Anio_mes
ORDER BY Anio_mes ASC;

# -Parte 2
SELECT
	YEAR(BQ_ProductsLines.FechaOrden) * 100 + month(BQ_ProductsLines.FechaOrden) AS 'Anio_mes',
    SUM(BQ_ProductsLines.Subtotal_IVA) AS 'Subtotal IVA',
    SUM(BQ_ProductsLines.Subtotal_SinIVA) AS 'Subtotal sin IVA',
    SUM(BQ_ProductsLines.TotalCosto_IVA) AS 'Costo IVA',
    SUM(BQ_ProductsLines.Subtotal_IVA - BQ_ProductsLines.Subtotal_SinIVA) AS 'IVA en $'
FROM
	BQ_ProductsLines
WHERE
	BQ_ProductsLines.FechaOrden >= '2018-01-01'
GROUP BY Anio_mes
ORDER BY Anio_mes ASC;


# --QUERY RESUMEN DAVIVIENDA
# -Parte 1
SELECT
	YEAR(BQ_Orders.FechaOrden) * 100 + month(BQ_Orders.FechaOrden) AS 'Anio_mes',
    COUNT(DISTINCT(BQ_Orders.IdOrden)) AS 'Cantidad ordenes',
    ROUND(SUM(BQ_Orders.Total), 0) AS 'GMV',
    ROUND(SUM(BQ_Orders.Total) / COUNT(DISTINCT(BQ_Orders.IdOrden)), 0) AS 'Tiquete Promedio',
    SUM(BQ_Orders.CostoEnvio) AS 'Costo de Envío',
    SUM(BQ_Orders.Descuento) AS 'Descuentos',
    SUM(BQ_Orders.Creditos) AS 'Creditos'
FROM
	BQ_Orders
WHERE
	BQ_Orders.StatusAgrupado = 'Aceptada' AND
    BQ_Orders.IVA <> 0
GROUP BY Anio_mes
ORDER BY Anio_mes ASC;

# -Parte 2
SELECT
	YEAR(BQ_ProductsLines.FechaOrden) * 100 + month(BQ_ProductsLines.FechaOrden) AS 'Anio_mes',
    SUM(BQ_ProductsLines.Subtotal_IVA) AS 'Subtotal IVA',
    SUM(BQ_ProductsLines.Subtotal_SinIVA) AS 'Subtotal sin IVA',
    SUM(BQ_ProductsLines.TotalCosto_IVA) AS 'Costo IVA',
    SUM(BQ_ProductsLines.Subtotal_IVA - BQ_ProductsLines.Subtotal_SinIVA) AS 'IVA en $'
FROM
	BQ_ProductsLines
WHERE
	BQ_ProductsLines.FechaOrden >= '2018-01-01' AND
	BQ_ProductsLines.IVA IS NOT NULL
GROUP BY Anio_mes
ORDER BY Anio_mes ASC;

#ACQ para ambas vitrinas Geelbe y Davivienda.
SELECT
	YEAR(BQ_Acquisitions.created) * 100 + MONTH(BQ_Acquisitions.created) AS 'Anio_Mes',
    COUNT(DISTINCT(BQ_Acquisitions.id)) AS 'Adquisiciones'
FROM
	BQ_Acquisitions
WHERE
	BQ_Acquisitions.TipoOrden = 'Adquisicion'
GROUP BY
	Anio_Mes;

----------------------------------------------------------------------------------------------------------------------------------------------


# --Ordenes totales, GMV y Tiquete Promedio
# -Hoja: "Ventas", Tablas: 1, 2 y 3.
# Nota 1: Tener presente variación de cantidades debido a órdenes con subtotal 0 en tabla orders. Dato referencia: Enero 2018 (5.505).
# Nota 2: Se toma variable "orders.Total" para cálculo GMV debido a diferencias entre BackOffice y tabla BDD.

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

# --Ventas
# -Hoja: "Data nuevas gráficas", Tablas: 4
SELECT
	YEAR(BQ_ProductsLines.FechaOrden) * 100 + month(BQ_ProductsLines.FechaOrden) AS 'Anio_mes',
	ROUND(SUM(BQ_ProductsLines.Subtotal_SinIVA), 0) AS 'Subtotal Sin IVA'
FROM
	BQ_ProductsLines
GROUP BY Anio_mes
ORDER BY Anio_mes ASC;


# --5) Contribución Bruta ($)
# -Hoja: "Ventas", Tablas: 5.
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

# --Venta por categoría en GMV (%) (PENDIENTE)
# Se calcula con base a Subtotal_IVA ya que el GMV no puede ser discriminado (aún) por Línea.
# Query usado para análisis: Unidades vendidas, Tiquete promedio, Descuento promedio y margen de contribución.
# Hacer tabla dinámica en Excel para obtener ventas acumuladas 2018.
SELECT
	YEAR(BQ_ProductsLines.FechaOrden) * 100 + MONTH(BQ_ProductsLines.FechaOrden) AS 'Anio_mes',
    BQ_ProductsLines.Linea AS 'Linea',
    SUM(BQ_ProductsLines.Cantidad) AS 'Unidades vendidas',
    SUM(BQ_ProductsLines.Subtotal_IVA) AS 'Ventas',
    SUM(BQ_ProductsLines.Subtotal_SinIVA) AS 'Ventas sin IVA',
    COUNT(DISTINCT(BQ_ProductsLines.IdOrden)) AS 'Cantidad ordenes',
    ROUND(SUM(BQ_ProductsLines.Subtotal_IVA) / COUNT(DISTINCT(BQ_ProductsLines.IdOrden)), 0) AS 'Tiquete Promedio',
    1 - (SUM(BQ_ProductsLines.PrecioVenta) / SUM(BQ_ProductsLines.PrecioMercado)) AS '% Descuento',
    1 - (SUM(BQ_ProductsLines.TotalCosto_IVA) / SUM(BQ_ProductsLines.Subtotal_IVA)) AS '% Contribucion'
FROM
	BQ_ProductsLines
WHERE
	BQ_ProductsLines.FechaOrden >= '2018-01-01 00:00:00'
GROUP BY
	Anio_mes, Linea
ORDER BY
	Anio_mes, Linea ASC;





# --% Descuento y % Contribución TOTAL
# -Hoja: "Data Nuevas Gráficas", Tablas: 10 y 11.
SELECT
	YEAR(BQ_ProductsLines.FechaOrden) * 100 + MONTH(BQ_ProductsLines.FechaOrden) AS 'Anio_mes',
    1 - (SUM(BQ_ProductsLines.PrecioVenta) / SUM(BQ_ProductsLines.PrecioMercado)) AS '% Descuento',
    1 - (SUM(BQ_ProductsLines.TotalCosto_IVA) / SUM(BQ_ProductsLines.Subtotal_IVA)) AS '% Contribucion'
FROM
	BQ_ProductsLines
WHERE
	BQ_ProductsLines.FechaOrden >= '2018-01-01 00:00:00'
GROUP BY
	Anio_mes
ORDER BY
	Anio_mes ASC;


# -Productos, Marcas y Proveedores activos
# -Hoja: "Data Nuevas Gráficas", Tablas: 12 y 13.
SELECT 
    YEAR(products.created) * 100 + MONTH(products.created) AS 'Anio_mes',
    COUNT(DISTINCT (products.id)) AS productos,
    COUNT(DISTINCT (products.manufacturerId)) AS Marcas,
    COUNT(DISTINCT (manufacturers_providers.providerId)) AS Proveedores
FROM
    products
        LEFT JOIN
    manufacturers_providers ON (products.manufacturerId = manufacturers_providers.manufacturerId)
GROUP BY YEAR(products.created) * 100 + MONTH(products.created);


# -Campañas activas
# -Hoja: "Data Nuevas Gráficas", Tablas: 14.
SELECT 
    YEAR(campaigns.start) * 100 + MONTH(campaigns.START) AS 'Anio_Mes',
    COUNT(DISTINCT (campaigns.id)) AS '# Campañas'
FROM
    campaigns
GROUP BY YEAR(campaigns.start) * 100 + MONTH(campaigns.start);






# --------------------------------------------------------------- MARKETING

# --Usuarios con más de una orden por periodo
# -Hoja: "Mercadeo", Tablas: 4.
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

# --Pendiente clasificar Query
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


# --Active Costumers
# -Hoja: "Mercadeo", Tablas: 5.
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
	BQ_Acquisitions.Source_name AS 'Fuente',
	COUNT(DISTINCT(BQ_Acquisitions.Orden)) AS 'Adquisiciones'
FROM
	BQ_Acquisitions
WHERE
	BQ_Acquisitions.TipoOrden = 'Adquisición'
   #AND BQ_Acquisitions.Source_name = 'Web'
   #AND BQ_Acquisitions.Source_name = 'Movil Web'
   AND BQ_Acquisitions.Source_name = 'Movil App'
GROUP BY Anio_mes, Fuente
ORDER BY Anio_mes ASC;



# --------------------------------------------------------------- OPERACIONES

#--Tiempo promedio de entrega
# -Se toma de archivo GSheets de operaciones: "1. Operaciones Geelbe-QBC-Davivienda"

#--Cantidad de mensajes recibidos (FreshDesk + VentasPop)
# 1. 


#-- Ordenes aceptadas vs rechazadas

SELECT
	Rechazos.Anio_mes,
    COUNT(Rechazos.Email) AS '# Ordenes rechazadas con filtro',
    SUM(Rechazos.Ordenes) AS '# Órdenes rechazadas total'
FROM
	(SELECT
		BQ_Orders.Anio_Mes AS 'Anio_mes',
		BQ_Orders.Email AS 'Email',
		COUNT(DISTINCT(BQ_Orders.IdOrden)) AS 'Ordenes',
		BQ_Orders.Subtotal_IVA AS 'Venta'
	FROM
		BQ_Orders
	WHERE
		BQ_Orders.StatusAgrupado = 'Rechazada'
		AND BQ_Orders.FechaOrden >= '2017-01-01'
	GROUP BY
		Anio_Mes, Email, Venta) as Rechazos
GROUP BY
	Rechazos.Anio_mes;    


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
	


# ---------------------------------------------- SIN USO -----------------------------------------
# - Estos filtros se realizan en Excel (antes) - Se han generados queries para resumen de información. 

# - Este Query es por si se requiere detalle (Ya no se usa)
SELECT 
	YEAR(BQ_ProductsLines.FechaOrden) AS 'Anio',
    MONTHNAME(BQ_ProductsLines.FechaOrden) AS 'Mes',
    YEAR(BQ_ProductsLines.FechaOrden) * 100 + MONTH(BQ_ProductsLines.FechaOrden) AS 'Anio_mes',    
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