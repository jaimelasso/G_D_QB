SELECT 
    campaigns_products.campaignId,
    campaigns_products.productId,
    products.manufacturerId,
    manufacturers.name,
    YEAR(products.created) * 100 + MONTH(products.created) AS Fecha_Campana,
    YEAR(fechamin.fecha) * 100 + MONTH(fechamin.fecha) AS Fecha_1_campana,
    12*(YEAR(products.created) - YEAR(fechamin.fecha)) + (MONTH(products.created) - MONTH(fechamin.fecha)) AS Edadcompra
FROM
    campaigns_products
        LEFT JOIN
    products ON (campaigns_products.productId = products.id)
        LEFT JOIN
    manufacturers ON (products.manufacturerId = manufacturers.id)
        LEFT JOIN
    (SELECT 
        products.manufacturerId, MIN(created) AS fecha
    FROM
        products
    GROUP BY manufacturerId) AS fechamin ON (products.manufacturerId = fechamin.manufacturerId)
group by manufacturerId,Fecha_Campana