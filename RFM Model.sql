SELECT
    BQ_Orders.Email,
    MIN(BQ_Orders.FechaOrden) AS 'FechaPrimerOrden',
    MAX(BQ_Orders.FechaOrden) AS 'FechaUltimaOrden',
    SUM(BQ_Orders.Total) AS 'Total',
    COUNT(BQ_Orders.IdOrden) AS 'Frecuency',
    ROUND((SUM(BQ_Orders.Total) / COUNT(BQ_Orders.IdOrden)),0) AS 'MonetaryValue',
    (DATEDIFF(CURDATE(), MAX(BQ_Orders.FechaOrden))) AS 'Recency'
FROM
	BQ_Orders
WHERE
	BQ_Orders.StatusAgrupado = 'Aceptada' AND
    BQ_Orders.FechaOrden BETWEEN DATE_SUB(CURDATE(), INTERVAL 365 DAY) AND CURDATE()
GROUP BY
	BQ_Orders.Email;
    
SELECT
	*
FROM
	BQ_Orders
WHERE
	BQ_Orders.StatusAgrupado = 'Aceptada' AND
    BQ_Orders.FechaOrden BETWEEN DATE_SUB(CURDATE(), INTERVAL 365 DAY) AND CURDATE();