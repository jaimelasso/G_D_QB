#--Ticket 23: Parte 1
SELECT 
    users.id AS 'ID Usuario',
    users.email AS 'Email',
    users.name AS 'Nombre',
    users.surname AS 'Apellido',
    states.name AS 'Departamento',
	 cities.name AS 'Ciudad',
    users.sex AS 'Genero',
    TIMESTAMPDIFF(YEAR, users.birthdate, CURDATE()) AS 'Edad',
    COUNT(DISTINCT (orders.id)) AS 'Ordenes'
FROM
    users
        LEFT JOIN
    orders ON (users.id = orders.userId)
        LEFT JOIN
    states ON (users.stateId = states.id)    
        LEFT JOIN
    cities ON (users.cityId = cities.id)
        LEFT JOIN
    orders_products ON (orders.id = orders_products.orderId)
        LEFT JOIN
    products_categories ON (orders_products.productId = products_categories.productId)
        LEFT JOIN
    categories ON (products_categories.categoryId = categories.id)
GROUP BY users.id;

#--Ticket 23: Parte 2

SELECT
	BQ_ProductsLines.FechaOrden AS 'Fecha Orden',
	BQ_ProductsLines.IdOrden AS 'ID Orden',
	BQ_ProductsLines.Producto AS 'Producto',
	BQ_ProductsLines.Cantidad AS 'Cantidad',
	BQ_ProductsLines.Campana AS 'Campania',
	BQ_ProductsLines.Marca AS 'Marca'
	BQ_Orders.Email AS 'Email'
FROM
	BQ_ProductsLines
LEFT JOIN
	BQ_Orders ON (BQ_Orders.IdOrden = BQ_ProductsLines.IdOrden);

    
    
    
	users.email AS 'Email',
   users.name AS 'Nombre',
   users.surname AS 'Apellido',
   states.name AS 'Departamento',
	cities.name AS 'Ciudad',
   users.sex AS 'Genero'
   
LEFT JOIN
	BQ_Orders ON (BQ_ProductsLines.IdOrden = BQ_Orders.IdOrden)
LEFT JOIN
	users ON (BQ_Orders.Email = users.email)
LEFT JOIN
    states ON (users.stateId = states.id)    
LEFT JOIN
    cities ON (users.cityId = cities.id);   














    SELECT * FROM BQ_OrdersDiscounts WHERE BQ_OrdersDiscounts.FechaOrden >= '2018-01-01 00:00:00';

SELECT * FROM BQ_ProductsLines WHERE BQ_ProductsLines.FechaOrden >= '2018-01-01 00:00:00';

SELECT * FROM BQ_Orders WHERE BQ_Orders.FechaOrden >= '2018-01-01 00:00:00';

SELECT * FROM BQ_OrdersDiscounts;

SELECT * FROM orders_discounts;

SELECT * FROM products;


SELECT
    YEAR(BQ_ProductsLines.FechaOrden) * 100 + MONTH(BQ_ProductsLines.FechaOrden) AS 'Anio_mes',
    SUM(BQ_ProductsLines.Subtotal_IVA),
    SUM(BQ_ProductsLines.Subtotal_SinIVA)
FROM
    BQ_ProductsLines
GROUP BY
    Anio_mes;


SELECT
    orders.created AS 'FechaOrden',
    YEAR(orders.created) * 100 + MONTH(orders.created) AS 'Anio_mes',
    orders_groups.orderId AS 'IdOrden',
    orders_groups.code AS 'Parte',
    users.email AS 'Email',
    orders_status.name AS 'StatusOrden',
    CASE
        WHEN (orders_status.id = 2 OR
              orders_status.id = 4 OR
              orders_status.id = 5 OR
              orders_status.id = 6 OR
              orders_status.id = 10 OR
              orders_status.id = 11 OR
              orders_status.id = 12) THEN 'Aceptada'
        ELSE 'Rechazada'
    END AS 'StatusAgrupado',        
    
    orders_groups.name AS 'Campania',

    ROUND(AVG(orders_groups.subtotal), 0) AS 'Subtotal'
FROM
    orders_groups
    
LEFT JOIN orders
    ON (orders_groups.orderId = orders.id)
    
LEFT JOIN orders_status
    ON (orders_groups.statusId = orders_status.id)    

LEFT JOIN users 
ON (users.id = orders.userid) 

LEFT JOIN
    (SELECT
        orders_discounts.orderId,
        orders_discounts.discountId
    FROM
        orders_discounts) AS ordersDiscounts
    ON (ordersDiscounts.orderId = orders_groups.orderId)

LEFT JOIN discounts
    ON (ordersDiscounts.discountId = discounts.id)

WHERE
    orders.created >= '2018-01-01 00:00:00'

GROUP BY orders_groups.orderId, orders_groups.code, orders_groups.name;
