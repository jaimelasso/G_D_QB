# --------------- ADQUISICIONES INCLUYENTO LA TOTALIDAD DE ORDENES Y NO SOLO LAS ACEPTADAS

DROP TABLE BQ_AcquisitionsSimulated;

CREATE TABLE BQ_AcquisitionsSimulated
SELECT
	orders.id AS 'Orden',
	CAST(orders.created AS DATE) AS 'FechaOrden',
	YEAR(orders.created) AS 'AnioOrden',
	MONTHNAME(orders.created) AS 'MesOrden',
	users.email AS 'Email',
	orders.statusId AS 'Status',
	orders.created,
	FechaPrimerPedido,
	(orders.created) - (FechaPrimerPedido) AS Edadcompra,
	orders.id,
	CASE
		WHEN (orders.created) - (FechaPrimerPedido) = '0' THEN 'Adquisicion'
		ELSE 'Recompra'
	END AS 'TipoOrden',
    
	CASE
		WHEN orders.sourceId = 1 THEN 'Web' 
		WHEN orders.sourceId = 2 THEN 'Movil App' 
		WHEN orders.sourceId = 3 THEN 'POS' 
		WHEN orders.sourceId = 5 THEN 'Tienda asociada' 
		WHEN orders.sourceId = 6 THEN 'Movil Web'
	END AS 'Source_name',

	CASE
		WHEN orders.referer LIKE '%App Android%' THEN 'App Android'
		WHEN orders.referer LIKE '%App iOS%' THEN 'App iOS'
		WHEN (orders.referer IS NULL AND orders.sourceId = 1) THEN 'Web'    
		WHEN (orders.referer IS NULL AND orders.sourceId = 2) THEN 'Movil Web'
		WHEN (orders.referer IS NULL AND orders.sourceId = 6) THEN 'Movil Web'
	END AS 'FuenteFinal'        
        
	FROM
		orders
			LEFT JOIN
		users ON (users.id = orders.userid)
			LEFT JOIN
		(SELECT 
			primero.email, FechaPrimerPedido, primero.id
		FROM
			(SELECT 
			users.email,
				MIN(orders.created) AS FechaPrimerPedido,
				orders.id
		FROM
			orders
		LEFT JOIN users ON (users.id = orders.userid)
		WHERE
			(email NOT LIKE '%prueba%')
				AND (users.name NOT LIKE '%prueba%')
				AND (users.surname != '%prueba%')
				AND (users.id IS NOT NULL)
		GROUP BY users.email) primero
		LEFT JOIN (SELECT 
			users.email,
				orders.created AS fechaorden,
				orders.subtotal,
				orders.discount,
				orders.shipping,
				orders.total,
				orders.id
		FROM
			orders
		LEFT JOIN users ON (users.id = orders.userid)
		WHERE
			(email NOT LIKE '%prueba%')
				AND (users.name NOT LIKE '%prueba%')
				AND (users.surname != '%prueba%')
				AND (users.id IS NOT NULL)
		GROUP BY users.email) AS segundo ON primero.email = segundo.email
			AND primero.FechaPrimerPedido = segundo.fechaorden) AS lala ON users.email = lala.email
	WHERE
			(users.email NOT LIKE '%prueba%')
			AND (users.name NOT LIKE '%prueba%')
			AND (users.surname != '%prueba%')
			AND (users.id IS NOT NULL);