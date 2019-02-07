# Inventario inicial y unidades vendidas.

DROP TABLE IF EXISTS BQ_Reserva;

CREATE TABLE IF NOT EXISTS BQ_Reserva (
	IdProducto INT, 
	FechaInicioCampaña DATE, 
	FechaFinCampaña DATE, 
	Producto VARCHAR(80), 
	Marca VARCHAR(80), 	
	IdProveedor INT, 
	Proveedor VARCHAR(80), 
	IdCampaña INT, 
	Campaña VARCHAR(80),
	UnidadesVendidas INT, 
	InventarioInicial INT, 
	VentasIVA DECIMAL, 
	PrecioProducto DECIMAL, 
	CostoVentaUnidad DECIMAL, 
	PrecioMercadoUnidad DECIMAL,
	FOREIGN KEY (IdProducto) REFERENCES products(id)
);

INSERT INTO BQ_Reserva (IdProducto, FechaInicioCampaña, FechaFinCampaña, Producto, Marca, IdProveedor, Proveedor, IdCampaña, Campaña,
UnidadesVendidas, InventarioInicial, VentasIVA, PrecioProducto, CostoVentaUnidad, PrecioMercadoUnidad)
SELECT
    orders_products.productId AS 'IdProducto',
    campaigns.START AS 'FechaInicioCampaña',
    campaigns.END AS 'FechaFinCampaña',
    products.name AS 'Producto',
    manufacturers.NAME AS 'Marca',
    orders_groups.providerId AS 'IdProveedor',
    providers.NAME AS 'Proveedor',
    orders_groups.campaignId AS 'IdCampaña',
    orders_groups.NAME AS 'Campaña',
    SUM(orders_products.quantity) AS 'UnidadesVendidas',
    MAX(Inventario.Inicial) AS 'InventarioInicial',  
    SUM(orders_products.total) AS 'VentasIVA',
    AVG(orders_products.price) AS 'PrecioProducto',
    products.wholePrice AS 'CostoVentaUnidad',
    products.originalPrice AS 'PrecioMercadoUnidad'
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
LEFT JOIN
	(SELECT 
    products_stock_history.productId, 
    SUM(products_stock_history.newStock) AS 'Inicial'
		FROM
		    products_stock_history
		WHERE
		    products_stock_history.oldStock = '0'
		GROUP BY productId) AS Inventario ON (Inventario.productId = orders_products.productId)
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