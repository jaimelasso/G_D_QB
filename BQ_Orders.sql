DROP TABLE BQ_Orders;

CREATE TABLE BQ_Orders
SELECT
   	CAST(geelbe.orders.created AS DATE) AS 'FechaOrden',
   	geelbe.orders.id AS 'IdOrden',
    geelbe.users.email AS 'Email',
   	geelbe.orders_status.name AS 'StatusOrden',
CASE
	WHEN (geelbe.orders_status.id = 2 OR
		  geelbe.orders_status.id = 4 OR
		  geelbe.orders_status.id = 5 OR
		  geelbe.orders_status.id = 6 OR
		  geelbe.orders_status.id = 10 OR
		  geelbe.orders_status.id = 11 OR
		  geelbe.orders_status.id = 12) THEN 'Aceptada'
	ELSE 'Rechazada'
END AS 'StatusAgrupado',
   	geelbe.orders.tax AS 'IVA',
   	geelbe.orders.subtotal AS 'Subtotal_IVA',
    ROUND((geelbe.orders.subtotal / ((geelbe.orders.tax + 100) / 100)),1) AS 'Subtotal_SinIVA',    
   	geelbe.orders.discount 'Descuento',
   	geelbe.orders.credits AS 'Creditos',
   	geelbe.orders.shipping AS 'CostoEnvio',
   	geelbe.orders.total AS 'Total',
   	geelbe.payment_methods.name AS 'MetodoPago',
   	geelbe.users.sex AS 'Genero',
	geelbe.orders.sourceId,
CASE
	WHEN geelbe.orders.sourceId = 1 THEN 'Web' 
	WHEN geelbe.orders.sourceId = 2 THEN 'Movil App' 
	WHEN geelbe.orders.sourceId = 3 THEN 'POS' 
	WHEN geelbe.orders.sourceId = 5 THEN 'Tienda asociada' 
	WHEN geelbe.orders.sourceId = 6 THEN 'Movil Web'
END AS 'FuenteOriginal',

CASE
	WHEN geelbe.orders.referer LIKE '%App Android%' THEN 'App Android'
	WHEN geelbe.orders.referer LIKE '%App iOS%' THEN 'App iOS'
	WHEN (geelbe.orders.referer IS NULL AND geelbe.orders.sourceId = 1) THEN 'Web'    
	WHEN (geelbe.orders.referer IS NULL AND geelbe.orders.sourceId = 2) THEN 'Movil Web'
    WHEN (geelbe.orders.referer IS NULL AND geelbe.orders.sourceId = 6) THEN 'Movil Web'
END AS 'FuenteFinal'

FROM geelbe.orders

LEFT JOIN geelbe.users 
ON (geelbe.users.id = geelbe.orders.userid) 

LEFT JOIN geelbe.orders_status
ON (geelbe.orders.statusId = geelbe.orders_status.id) 

LEFT JOIN geelbe.payment_methods
ON (geelbe.payment_methods.id = geelbe.orders.paymentMethodId)

LEFT JOIN geelbe.sources
ON (geelbe.sources.id = geelbe.orders.sourceId)

WHERE
	(geelbe.orders.created > '2010-01-01 00:00:00')

ORDER BY geelbe.orders.created;