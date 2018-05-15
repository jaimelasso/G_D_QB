SELECT
    SUM(BQ_Orders.Subtotal_IVA),
    SUM(BQ_Orders.Total)
FROM
	BQ_Orders
WHERE
	BQ_Orders.FechaOrden >= '2018-03-01 00:00:00' AND
    BQ_Orders.FechaOrden <= '2018-03-31 11:59:59' AND
    BQ_Orders.StatusAgrupado = 'Aceptada';
    
SELECT
	BQ_Orders.FechaOrden,
    BQ_Orders.IdOrden,
    BQ_Orders.StatusOrden,
    BQ_Orders.Subtotal_IVA,
    BQ_Orders.Total
FROM
	BQ_Orders
WHERE
	BQ_Orders.FechaOrden >= '2018-01-01 00:00:00' AND
    BQ_Orders.FechaOrden <= '2018-01-31 11:59:59' AND
    BQ_Orders.StatusAgrupado = 'Aceptada'; 
    
    
SELECT
	BQ_ProductsLines.FechaOrden,
    BQ_ProductsLines.IdOrden,
    BQ_ProductsLines.StatusID,
    BQ_ProductsLines.Producto,
    BQ_ProductsLines.Cantidad,
    BQ_ProductsLines.PrecioVenta,
    BQ_ProductsLines.CostoVenta,
    BQ_ProductsLines.Subtotal_IVA,
    BQ_ProductsLines.Subtotal_SinIVA,
    BQ_ProductsLines.TotalCosto_IVA,
    BQ_ProductsLines.TotalCosto_SinIVA
FROM
	BQ_ProductsLines
WHERE
	BQ_ProductsLines.FechaOrden >= '2018-02-01 00:00:00' AND
    BQ_ProductsLines.FechaOrden <= '2018-02-28 11:59:59';
    
SELECT * FROM orders_products WHERE orders_products.orderId = '2020116';
SELECT * FROM BQ_ProductsLines WHERE BQ_ProductsLines.IdOrden = '2020116';
    
SELECT * FROM orders_products;
    
SELECT * FROM users WHERE users.email = 'angelitogonzabuitrago@gmail.com';

SELECT * FROM orders_products WHERE orders_products.orderId = '2007848';

SELECT * FROM BQ_ProductsLines;

SELECT
	BQ_ProductsLines.FechaOrden,
	YEAR(BQ_ProductsLines.FechaOrden) AS 'Anio',
    MONTHNAME(BQ_ProductsLines.FechaOrden) AS 'Mes',
	BQ_ProductsLines.IdOrden,
    SUM(BQ_ProductsLines.Cantidad)
FROM
	BQ_ProductsLines
GROUP BY
	BQ_ProductsLines.IdOrden;
    
    
    
    
SELECT
	BQ_Acquisitions.AnioOrden AS 'Anio',
    BQ_Acquisitions.MesOrden AS 'Mes',
    BQ_Acquisitions.Email AS 'Email',
    BQ_Acquisitions.Orden AS 'OrderID',
    BQ_Acquisitions.TipoOrden AS 'TipoOrden'
FROM
	BQ_Acquisitions;
    
SELECT users.email FROM users;

SELECT
	BQ_Acquisitions.FechaOrden,
    BQ_Acquisitions.Email,
    BQ_Acquisitions.Orden,
    BQ_Acquisitions.Source_name
FROM
	BQ_Acquisitions
WHERE
	BQ_Acquisitions.Email = 'jaime@corp.geelbe.com';
    
SELECT * FROM BQ_ProductsLines WHERE BQ_ProductsLines.FechaOrden >= '2017-01-01 00:00:00';

SELECT * FROM BQ_Acquisitions WHERE BQ_Acquisitions.FechaOrden >= '2018-01-01 00:00:00';

SELECT
	COUNT(DISTINCT(orders.userId))
FROM
	orders
		WHERE
			(orders.statusId = '2'
				OR orders.statusId = '4'
				OR orders.statusId = '5'
				OR orders.statusId = '6'
				OR orders.statusId = '12'
				OR orders.statusId = '10'
				OR orders.statusId = '11');
                
                
                
# Cantidad total de usuarios activos a la fecha

SELECT
	COUNT(DISTINCT(BQ_Orders.Email)) AS 'Cantidad Usuarios',
    COUNT(BQ_Orders.IdOrden) AS 'Cantidad ordenes'
FROM
	BQ_Orders
WHERE
	BQ_Orders.StatusAgrupado = 'Aceptada' AND
    BQ_Orders.FechaOrden BETWEEN DATE_SUB(CURDATE(), INTERVAL 365 DAY) AND CURDATE();
    
    


SELECT
	BQ_ProductsLines.Contribucion_IVA
FROM
	BQ_ProductsLines;
    
    
SELECT
	BQ_Orders.FechaOrden,
    BQ_Orders.IdOrden,
    BQ_Orders.Email
FROM
	BQ_Orders
WHERE
	BQ_Orders.FechaOrden >= '2016-01-01 00:00:00' AND
    BQ_Orders.StatusAgrupado = 'Aceptada';

SELECT
	BQ_Acquisitions.FechaOrden,
    BQ_Acquisitions.Orden,
    BQ_Acquisitions.TipoOrden
FROM
	BQ_Acquisitions
WHERE
	BQ_Acquisitions.FechaOrden >= '2016-01-01 00:00:00';
    
    
    
# --------------
    
    
SELECT * FROM geelbe.orders_groups
WHERE geelbe.orders_groups.orderId = '734888';

 

#---
SELECT * FROM BQ_OrdersDiscounts 
WHERE BQ_OrdersDiscounts.FechaOrden >= '2018-04-01 00:00:00' 
        AND BQ_OrdersDiscounts.StatusAgrupado = 'Aceptada';


#---
SELECT
	BQ_OrdersDiscounts.Anio,
    BQ_OrdersDiscounts.Mes,
    SUM(BQ_OrdersDiscounts.Descuento) as 'Descuento'
FROM
	BQ_OrdersDiscounts
WHERE
	BQ_OrdersDiscounts.StatusAgrupado = 'Aceptada'
GROUP BY
	BQ_OrdersDiscounts.Anio, BQ_OrdersDiscounts.mes;