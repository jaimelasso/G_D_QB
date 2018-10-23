DROP TABLE IF EXISTS BQ_ProductosVendidos;

CREATE TABLE BQ_ProductosVendidos
SELECT
    orders_products.productId AS 'IdProducto',
    campaigns.START AS 'Fecha Inicio Campaña',
    campaigns.END AS 'Fecha Fin Campaña',
    products.name AS 'Producto',
    manufacturers.NAME AS 'Marca',
    orders_groups.providerId AS 'Id Proveedor',
    providers.NAME AS 'Proveedor',
    orders_groups.campaignId AS 'Id Campaña',
    orders_groups.NAME AS 'Campaña',
    SUM(orders_products.quantity) AS 'Unidades Vendidas',
    SUM(orders_products.total) AS 'Ventas (+IVA)',
    AVG(orders_products.price) AS 'Precio Producto',
    products.wholePrice AS 'Costo Venta Unidad',
    products.originalPrice AS 'Precio Mercado Unidad'
FROM
    orders_products
LEFT JOIN
	orders ON (orders_products.orderId = orders.id)
LEFT JOIN
	products ON (orders_products.productId = products.id)
LEFT JOIN
	manufacturers ON (products.manufacturerId = manufacturers.id)
LEFT JOIN
	orders_groups ON (orders_products.groupId = orders_groups.id)
LEFT JOIN
	providers ON (orders_groups.providerId = providers.id)
LEFT JOIN
	campaigns ON (orders_products.campaignId = campaigns.id)
WHERE
	orders.statusId = '2'
	OR orders.statusId = '4'
	OR orders.statusId = '5'
	OR orders.statusId = '6'
	OR orders.statusId = '10'
   OR orders.statusId = '11'
	OR orders.statusId = '12'
GROUP BY
	IdProducto;