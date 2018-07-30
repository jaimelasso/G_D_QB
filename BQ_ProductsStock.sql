DROP TABLE IF EXISTS BQ_ProductsStock;

CREATE TABLE BQ_ProductsStock
SELECT 
    CAST(campaigns.start AS DATE) AS 'FechaInicioCampana',
    campaigns_products.campaignId AS 'IdCampana',
    campaigns.name AS 'Campania',
    campaigns_products.productId AS 'IDProducto',
    products.name AS 'Producto',
    Inventrio.inicial AS 'InventarioInicial',
    CASE
        WHEN venta.Vendidos IS NULL THEN '0'
        ELSE venta.Vendidos
    END AS Vendidos,
    providers.name AS 'Proveedor',
    
    BQ_Jerarquias.codlinea AS 'IDCategoria',
    BQ_Jerarquias.desclinea AS 'Categoria',
    BQ_Jerarquias.codsublinea AS 'IDSubcategoria',
    BQ_Jerarquias.descsublinea AS 'Subcategoria',
    BQ_Jerarquias.codclase AS 'IDClase',
    BQ_Jerarquias.descclase AS 'Clase',
    BQ_Jerarquias.codsubclase AS 'IDSubclase',
    BQ_Jerarquias.descsubclase AS 'Subclase',
    BQ_Jerarquias.linea AS 'Linea'
    
FROM
    campaigns_products
        LEFT JOIN
    campaigns ON (campaigns_products.campaignId = campaigns.id)
        LEFT JOIN
    products ON (campaigns_products.productId = products.id)
        LEFT JOIN
    (SELECT 
        productId, SUM(newStock) AS inicial
    FROM
        products_stock_history
    WHERE
        oldStock = '0'
    GROUP BY productId) AS Inventrio ON (campaigns_products.productId = Inventrio.productid)
        LEFT JOIN
    (SELECT 
        IdProducto, SUM(cantidad) AS Vendidos
    FROM
        BQ_ProductsLines
    GROUP BY IdProducto) AS venta ON (campaigns_products.productId = venta.IdProducto)
        LEFT JOIN
    products_providers ON (campaigns_products.productId = products_providers.productId)
        LEFT JOIN
    providers ON (products_providers.providerId = providers.id)
        LEFT JOIN
    products_categories ON (campaigns_products.productId = products_categories.productId)
        LEFT JOIN
    categories ON (products_categories.categoryId = categories.id)
        LEFT JOIN
    BQ_Jerarquias ON (categories.code = BQ_Jerarquias.codsubclase);