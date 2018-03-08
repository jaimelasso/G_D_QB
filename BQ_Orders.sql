SELECT
   	CAST(geelbe.orders.created AS DATE) AS 'Fecha_orden',
   	geelbe.orders.id AS 'ID_Orden',
    geelbe.users.email AS 'email',
   	geelbe.orders.statusId AS 'StatusID',
   	geelbe.orders_status.name AS 'Status',    
   	geelbe.orders.subtotal AS 'Subtotal',
   	geelbe.orders.tax AS 'Tax',
   	geelbe.orders.discount 'Descuento',
   	geelbe.orders.credits AS 'Creditos',
   	geelbe.orders.shipping AS 'Costo_envio',
   	geelbe.orders.total AS 'Total',
   	(geelbe.orders.subtotal-geelbe.orders.tax) AS 'Subtotal_SinIVA',
   	geelbe.payment_methods.name AS 'Metodo_pago',
   	geelbe.users.sex AS 'Genero',
	geelbe.orders.sourceId,
CASE
	WHEN geelbe.orders.sourceId = 1 THEN 'Web' 
	WHEN geelbe.orders.sourceId = 2 THEN 'Movil App' 
	WHEN geelbe.orders.sourceId = 3 THEN 'POS' 
	WHEN geelbe.orders.sourceId = 5 THEN 'Tienda asociada' 
	WHEN geelbe.orders.sourceId = 6 THEN 'Movil Web'
END AS 'Source_name',

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
	(geelbe.orders.created > '2010-01-01 00:00:00') AND
	(geelbe.orders.statusId = 2 OR
	 geelbe.orders.statusId = 4 OR
	 geelbe.orders.statusId = 5 OR
	 geelbe.orders.statusId = 6 OR
	 geelbe.orders.statusId = 10 OR
	 geelbe.orders.statusId = 12 OR
	 geelbe.orders.statusId = 11)

ORDER BY geelbe.orders.created;