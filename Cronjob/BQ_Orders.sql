DROP TABLE IF EXISTS BQ_Orders;

CREATE TABLE BQ_Orders
SELECT
	orders.created AS 'MesDiaHora',
   	CAST(orders.created AS DATE) AS 'FechaOrden',
    YEAR(orders.created) * 100 + MONTH(orders.created) AS 'Anio_Mes',
   	orders.id AS 'IdOrden',
    users.id AS 'IdUsuario',
    users.email AS 'Email',
   	orders_status.name AS 'StatusOrden',
CASE
	WHEN (orders_status.id = 2 OR
		  orders_status.id = 4 OR
		  orders_status.id = 5 OR
		  orders_status.id = 6 OR
		  orders_status.id = 10 OR
		  orders_status.id = 11 OR
		  orders_status.id = 12) THEN 'Aceptada'
	WHEN (orders.total = 0) THEN 'Eliminada'
	ELSE 'Rechazada'
END AS 'StatusAgrupado',
   	orders.tax AS 'IVA',
   	orders.subtotal AS 'Subtotal_IVA',
    ROUND((orders.subtotal - orders.tax),1) AS 'Subtotal_SinIVA',
   	orders.discount 'Descuento',
   	orders.credits AS 'Creditos',
   	orders.shipping AS 'CostoEnvio',
   	orders.total AS 'Total',
   	payment_methods.name AS 'MetodoPago',
   	users.sex AS 'Genero',
	orders.sourceId,
CASE
	WHEN orders.sourceId = 1 THEN 'Web' 
	WHEN orders.sourceId = 2 THEN 'Movil App' 
	WHEN orders.sourceId = 3 THEN 'POS' 
	WHEN orders.sourceId = 5 THEN 'Tienda asociada' 
	WHEN orders.sourceId = 6 THEN 'Movil Web'
END AS 'FuenteOriginal',

CASE
	WHEN orders.referer LIKE '%App Android%' THEN 'App Android'
	WHEN orders.referer LIKE '%App iOS%' THEN 'App iOS'
	WHEN (orders.referer IS NULL AND orders.sourceId = 1) THEN 'Web'    
	WHEN (orders.referer IS NULL AND orders.sourceId = 2) THEN 'Movil Web'
    WHEN (orders.referer IS NULL AND orders.sourceId = 6) THEN 'Movil Web'
END AS 'FuenteFinal'

FROM orders

LEFT JOIN users 
ON (users.id = orders.userid) 

LEFT JOIN orders_status
ON (orders.statusId = orders_status.id) 

LEFT JOIN payment_methods
ON (payment_methods.id = orders.paymentMethodId)

LEFT JOIN sources
ON (sources.id = orders.sourceId)

WHERE
	(orders.created > '2010-01-01 00:00:00')

ORDER BY orders.created;