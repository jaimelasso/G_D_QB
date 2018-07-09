DROP TABLE IF EXISTS BQ_ActiveUsers;

CREATE TABLE BQ_ActiveUsers
SELECT 
    users.id AS 'ID Usuario',
    users.email AS 'Email',
    users.name AS 'Nombre',
    users.surname AS 'Apellido',
    states.name AS 'Departamento',
    cities.name AS 'Ciudad',
    users.address AS 'Direccion',
    users.tel AS 'Telefono registro',
    users.billingTel  AS 'Telefono envio',
    users.sex AS 'Genero',
    users.birthdate AS 'Fecha Nacimiento',
    TIMESTAMPDIFF(YEAR, users.birthdate, CURDATE()) AS 'Edad',
    users.lastLogin AS 'Fecha ultimo ingreso',
    users.lastPurchase AS 'Fecha ultima compra',
    COUNT(DISTINCT (orders.id)) AS 'Ordenes',
    SUM(orders.total) as 'Ventas'
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
WHERE
	orders.statusId = 2 OR
    orders.statusId = 4 OR
    orders.statusId = 5 OR
    orders.statusId = 6 OR
    orders.statusId = 10 OR
    orders.statusId = 11 OR
    orders.statusId = 12
GROUP BY users.id;