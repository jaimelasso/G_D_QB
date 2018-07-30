DROP TABLE IF EXISTS BQ_ProductsLines;

CREATE TABLE BQ_ProductsLines
SELECT
	orders.created AS 'MesDiaHora',
    CAST(orders.created AS DATE) AS 'FechaOrden',
    YEAR(orders.created) * 100 + MONTH(orders.created) AS 'Anio_Mes',
    orders.id AS 'IdOrden',
    orders.userId AS 'IdUsuario',
    orders_products.productId AS 'IdProducto',
    products.name AS 'Producto',
    products.manufacturerSku AS 'SKU',
    orders_products.quantity AS 'Cantidad',
    orders_products.price AS 'PrecioVenta',
    products.tax AS 'IVA',
    orders_products.total AS 'Subtotal_IVA',
    
    CASE
		WHEN (products.tax IS NULL) THEN orders_products.total
        ELSE ROUND((orders_products.total / ((products.tax + 100) / 100)),1)
	END AS 'Subtotal_SinIVA',
    
    products.wholePrice AS 'CostoVenta',
    ((orders_products.quantity) * (products.wholePrice)) AS 'TotalCosto_IVA',
    ROUND(((orders_products.quantity) * (products.wholePrice)) / ((products.tax + 100) / 100), 1) AS 'TotalCosto_SinIVA',
    products.originalPrice AS 'PrecioMercado',
    
    CASE
		WHEN (orders_products.total = 0) THEN 0
        ELSE ((orders_products.price - products.wholePrice) * orders_products.quantity)
    END AS 'Contribucion_IVA',

    CASE
		WHEN (orders_products.total = 0) THEN 0
        ELSE ROUND((((orders_products.price - products.wholePrice) * orders_products.quantity) / ((products.tax + 100) / 100)),1)
    END AS 'Contribucion_SinIVA',

    categories.code AS 'categoriaId',
    BQ_Jerarquias.desclinea AS 'Categoria',
    BQ_Jerarquias.linea AS 'Linea', 
    orders_groups.campaignId AS 'IdCampana',
    orders_groups.name AS 'Campana',
    orders_groups.providerId AS 'IdProveedor',
    providers.cif AS 'NIT',
    providers.name AS 'NombreProveedor',
    orders.statusId AS 'StatusID',
    orders_status.name AS 'EstadoOrden',
    products_versions_attributes.value,
    manufacturers.id AS 'IdMarca',
    manufacturers.name AS 'Marca'
FROM
	orders_products
		LEFT JOIN
	orders ON (orders_products.orderId = orders.Id)
        LEFT JOIN
    products ON (orders_products.productId = products.id)
        LEFT JOIN
    products_categories ON (products.id = products_categories.productId)
        LEFT JOIN
    categories ON (products_categories.categoryId = categories.id)
        LEFT JOIN
    orders_groups ON (orders_products.groupId = orders_groups.id)
        LEFT JOIN
    providers ON (orders_groups.providerId = providers.id)    
        LEFT JOIN
    orders_status ON (orders.statusId = orders_status.id)
        LEFT JOIN
    products_versions_attributes ON (orders_products.versionId = products_versions_attributes.versionId)
        LEFT JOIN
    manufacturers ON (products.manufacturerId = manufacturers.id)
        LEFT JOIN
    BQ_Jerarquias ON (categories.code = BQ_Jerarquias.codsubclase)    
WHERE
	orders.created > '2015-11-24 00:00:00' AND
        (orders.statusId = '2'
        OR orders.statusId = '4'
        OR orders.statusId = '5'
        OR orders.statusId = '6'
        OR orders.statusId = '10'
        OR orders.statusId = '11'
        OR orders.statusId = '12')
GROUP BY orders_products.id, orders.created , orders_products.productId, products.name, orders_products.versionId
ORDER BY orders.created , orders.id;