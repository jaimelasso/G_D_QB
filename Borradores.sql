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
	BQ_ProductsLines.FechaOrden >= '2018-01-01 00:00:00' AND
    BQ_ProductsLines.FechaOrden <= '2018-01-31 11:59:59';
    
SELECT * FROM orders_products WHERE orders_products.orderId = '2020116';
SELECT * FROM BQ_ProductsLines WHERE BQ_ProductsLines.IdOrden = '2020116';
    
SELECT * FROM orders_products;
    
SELECT * FROM users WHERE users.email = 'angelitogonzabuitrago@gmail.com';
    