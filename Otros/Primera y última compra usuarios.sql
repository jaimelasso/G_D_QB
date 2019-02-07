SELECT
	BQ_Orders.IdUsuario,
	users.email,
	MIN(BQ_Orders.FechaOrden) AS 'Primer Pedido',
	MAX(BQ_Orders.FechaOrden) AS 'Ultimo Pedido',
	COUNT(DISTINCT(BQ_Orders.IdOrden)) AS '# Ordenes'
FROM
	BQ_Orders
LEFT JOIN
	users ON (BQ_Orders.IdUsuario = users.id)
WHERE
	BQ_Orders.StatusAgrupado = 'Aceptada'
GROUP BY
	users.email;