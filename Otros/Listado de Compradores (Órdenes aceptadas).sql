#-- Listado de Compradores Geelbe
SELECT
	users.id AS 'ID Usuario',
	users.doc AS 'Documento',
	users.NAME AS 'Nombre',
	users.surname AS 'Apellido',
	users.email AS 'Correo',
	users.tel AS 'Teléfono',
	COUNT(DISTINCT(BQ_Orders.IdOrden)) AS '# Ordenes',
	COUNT(DISTINCT(BQ_Orders.IdUsuario)) AS '# Usuarios mismo Email'
FROM
	BQ_Orders
LEFT JOIN
	users ON (users.id = BQ_Orders.IdUsuario)
WHERE
	BQ_Orders.StatusAgrupado = 'Aceptada'
	AND BQ_Orders.IdUsuario IS NOT NULL
GROUP BY
	BQ_Orders.Email;