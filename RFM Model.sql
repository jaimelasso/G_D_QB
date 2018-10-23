DROP TABLE IF EXISTS BQ_RFM;

CREATE TABLE BQ_RFM
SELECT
    BQ_Orders.Email,
    MIN(BQ_Orders.FechaOrden) AS 'Fecha primera Orden',
    MAX(BQ_Orders.FechaOrden) AS 'Fecha última Orden',
    (DATEDIFF(MAX(BQ_Orders.FechaOrden), MIN(BQ_Orders.FechaOrden))) AS 'Periodo Actividad',
    COUNT(BQ_Orders.IdOrden) AS 'Frecuency',
    ((DATEDIFF(MAX(BQ_Orders.FechaOrden), MIN(BQ_Orders.FechaOrden)))) / (COUNT(BQ_Orders.IdOrden)) AS 'día/órden',
    ((COUNT(BQ_Orders.IdOrden) / (DATEDIFF(MAX(BQ_Orders.FechaOrden), MIN(BQ_Orders.FechaOrden))))) AS 'orden/día',    
    (DATEDIFF(CURDATE(), MAX(BQ_Orders.FechaOrden))) AS 'Recency',
    SUM(BQ_Orders.Total) AS 'Ventas',    
    ROUND((SUM(BQ_Orders.Total) / COUNT(BQ_Orders.IdOrden)),0) AS 'MonetaryValue'
FROM
	BQ_Orders
WHERE
	BQ_Orders.StatusAgrupado = 'Aceptada' AND
    BQ_Orders.FechaOrden BETWEEN DATE_SUB(CURDATE(), INTERVAL 365 DAY) AND CURDATE()
GROUP BY
	BQ_Orders.Email;
    

# --- EXCLUIDAS

    CASE
		WHEN (DATEDIFF(CURDATE(), MAX(BQ_Orders.FechaOrden))) <= 27 THEN 'A'
        WHEN (DATEDIFF(CURDATE(), MAX(BQ_Orders.FechaOrden))) <= 87 THEN 'B'
        WHEN (DATEDIFF(CURDATE(), MAX(BQ_Orders.FechaOrden))) <= 165 THEN 'C'
        WHEN (DATEDIFF(CURDATE(), MAX(BQ_Orders.FechaOrden))) <= 256 THEN 'D'
        WHEN (DATEDIFF(CURDATE(), MAX(BQ_Orders.FechaOrden))) <= 365 THEN 'E'
        ELSE 'F'
    END AS 'RecencyGroup',


    CASE
		WHEN COUNT(BQ_Orders.IdOrden) = 1 THEN 'C'
        WHEN COUNT(BQ_Orders.IdOrden) <= 3 THEN 'B'
        WHEN COUNT(BQ_Orders.IdOrden) > 3 THEN 'A'
	END AS 'FrecuencyGroup',







# --Consulta completa
SELECT * FROM BQ_RFM;


  
# --Recencia
SELECT
	BQ_RFM.RecencyGroup,
    COUNT(DISTINCT(BQ_RFM.Email)) AS 'Usuarios',
    SUM(BQ_RFM.Ventas) AS 'Ventas'
FROM
	BQ_RFM
GROUP BY BQ_RFM.RecencyGroup;

# --Frecuencia
SELECT
	BQ_RFM.FrecuencyGroup,
    COUNT(DISTINCT(BQ_RFM.Email)) AS 'Usuarios',
    SUM(BQ_RFM.Ventas) AS 'Ventas'
FROM
	BQ_RFM
GROUP BY BQ_RFM.FrecuencyGroup;