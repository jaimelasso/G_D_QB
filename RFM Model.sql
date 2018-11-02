DROP TABLE IF EXISTS BQ_RFM;

CREATE TABLE BQ_RFM (
	ID int NOT NULL AUTO_INCREMENT,
    userId int,
    Email varchar(50),
    firstOrder date,
    lastOrder date,
    activityPeriod int,
    frecuency int,
    recency int,
    monetaryValue int,
    recencyGroup varchar (30),
    rScore int,
    frecuencyGroup varchar (30),
    fScore int,
    monetaryValueGroup varchar (30),
    mScore int,
    PRIMARY KEY (ID),
    FOREIGN KEY (userId) REFERENCES users(id)
);

INSERT INTO BQ_RFM
SELECT
(@cnt := @cnt + 1) AS ID,
	users.id AS 'userId',
   BQ_Orders.Email AS 'Email',
   MIN(BQ_Orders.FechaOrden) AS 'firstOrder',
   MAX(BQ_Orders.FechaOrden) AS 'lastOrder',
   (DATEDIFF(MAX(BQ_Orders.FechaOrden), MIN(BQ_Orders.FechaOrden))) + 1 AS 'activityPeriod',
   COUNT(BQ_Orders.IdOrden) AS 'frecuency',
   (DATEDIFF(CURDATE(), MAX(BQ_Orders.FechaOrden))) AS 'recency',
   SUM(BQ_Orders.Total) AS 'monetaryValue',
	
   CASE
		WHEN (DATEDIFF(CURDATE(), MAX(BQ_Orders.FechaOrden))) <= 180 THEN 'A (0 - 180 days)'
		WHEN (DATEDIFF(CURDATE(), MAX(BQ_Orders.FechaOrden))) <= 513 THEN 'B (181 - 513 days)'
		WHEN (DATEDIFF(CURDATE(), MAX(BQ_Orders.FechaOrden))) <= 1037 THEN 'C (514 - 1037 days)'
		WHEN (DATEDIFF(CURDATE(), MAX(BQ_Orders.FechaOrden))) <= 1687 THEN 'D (1038 - 1687 days)'
	ELSE 'E (> 1687 days)'
   END AS 'recencyGroup',
   CASE
		WHEN (DATEDIFF(CURDATE(), MAX(BQ_Orders.FechaOrden))) <= 180 THEN 5
		WHEN (DATEDIFF(CURDATE(), MAX(BQ_Orders.FechaOrden))) <= 513 THEN 4
		WHEN (DATEDIFF(CURDATE(), MAX(BQ_Orders.FechaOrden))) <= 1037 THEN 3
		WHEN (DATEDIFF(CURDATE(), MAX(BQ_Orders.FechaOrden))) <= 1687 THEN 2
	ELSE 1
   END AS 'rScore',

   CASE
		WHEN COUNT(BQ_Orders.IdOrden) = 1 THEN '1 order'
		WHEN (COUNT(BQ_Orders.IdOrden) = 2 OR COUNT(BQ_Orders.IdOrden) = 3) THEN '2 - 3 orders'
	ELSE '> 3 orders'
   END AS 'frecuencyGroup',
   CASE
		WHEN COUNT(BQ_Orders.IdOrden) = 1 THEN 1
		WHEN (COUNT(BQ_Orders.IdOrden) = 2 OR COUNT(BQ_Orders.IdOrden) = 3) THEN 2
	ELSE 3
   END AS 'fScore', 

   CASE
		WHEN SUM(BQ_Orders.Total) < 106980 THEN 'Low (0 - $106.980)'
		WHEN SUM(BQ_Orders.Total) < 342720 THEN 'Medium ($106.981 - $342.720)'		
	ELSE 'High (> $342.720)'
   END AS 'monetaryValueGroup',
   CASE
		WHEN SUM(BQ_Orders.Total) < 106980 THEN 1
		WHEN SUM(BQ_Orders.Total) < 342720 THEN 2
	ELSE 3
   END AS 'mScore'

FROM
	BQ_Orders
    CROSS JOIN (SELECT @cnt := 0) AS dummy
LEFT JOIN
	users ON (BQ_Orders.IdUsuario = users.id)
WHERE
	BQ_Orders.StatusAgrupado = 'Aceptada'
	AND BQ_Orders.IdUsuario IS NOT NULL
GROUP BY
	BQ_Orders.Email;
    
SELECT * FROM BQ_RFM;