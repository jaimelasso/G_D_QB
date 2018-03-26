
SELECT
	geelbe.orders.id AS 'Orden',
	CAST(geelbe.orders.created AS DATE) AS 'FechaOrden',
	YEAR(geelbe.orders.created) AS 'AnioOrden',
	MONTHNAME(geelbe.orders.created) AS 'MesOrden',
	users.email AS 'Email',
	geelbe.orders.statusId AS 'Status',
	geelbe.orders.created,
	FechaPrimerPedido,
	(geelbe.orders.created) - (FechaPrimerPedido) AS Edadcompra,
	orders.id,
	CASE
		WHEN (geelbe.orders.created) - (FechaPrimerPedido) = '0' THEN 'Adquisicion'
		ELSE 'Recompra'
	END AS 'TipoOrden',
    
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
        
	FROM
		geelbe.orders
			LEFT JOIN
		geelbe.users ON (geelbe.users.id = geelbe.orders.userid)
			LEFT JOIN
		(SELECT 
			primero.email, FechaPrimerPedido, primero.id
		FROM
			(SELECT 
			users.email,
				MIN(geelbe.orders.created) AS FechaPrimerPedido,
				orders.id
		FROM
			geelbe.orders
		LEFT JOIN geelbe.users ON (geelbe.users.id = geelbe.orders.userid)
		WHERE
			(geelbe.orders.statusId = '2'
				OR geelbe.orders.statusId = '4'
				OR geelbe.orders.statusId = '5'
				OR geelbe.orders.statusId = '6'
				OR geelbe.orders.statusId = '12'
				OR geelbe.orders.statusId = '10'
				OR geelbe.orders.statusId = '11')
				AND (email NOT LIKE '%prueba%')
				AND (users.name NOT LIKE '%prueba%')
				AND (users.surname != '%prueba%')
				AND (geelbe.users.id IS NOT NULL)
		GROUP BY users.email) primero
		LEFT JOIN (SELECT 
			users.email,
				geelbe.orders.created AS fechaorden,
				geelbe.orders.subtotal,
				orders.discount,
				orders.shipping,
				orders.total,
				orders.id
		FROM
			geelbe.orders
		LEFT JOIN geelbe.users ON (geelbe.users.id = geelbe.orders.userid)
		WHERE
			(geelbe.orders.statusId = '2'
				OR geelbe.orders.statusId = '4'
				OR geelbe.orders.statusId = '5'
				OR geelbe.orders.statusId = '6'
				OR geelbe.orders.statusId = '12'
				OR geelbe.orders.statusId = '10'
				OR geelbe.orders.statusId = '11')
				AND (email NOT LIKE '%prueba%')
				AND (users.name NOT LIKE '%prueba%')
				AND (users.surname != '%prueba%')
				AND (geelbe.users.id IS NOT NULL)
		GROUP BY users.email) AS segundo ON primero.email = segundo.email
			AND primero.FechaPrimerPedido = segundo.fechaorden) AS lala ON users.email = lala.email
	WHERE
		(geelbe.orders.statusId = '2'
			OR geelbe.orders.statusId = '4'
			OR geelbe.orders.statusId = '5'
			OR geelbe.orders.statusId = '6'
			OR geelbe.orders.statusId = '12'
			OR geelbe.orders.statusId = '10'
			OR geelbe.orders.statusId = '11')
			AND (users.email NOT LIKE '%prueba%')
			AND (users.name NOT LIKE '%prueba%')
			AND (users.surname != '%prueba%')
			AND (geelbe.users.id IS NOT NULL);