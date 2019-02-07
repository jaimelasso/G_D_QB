DROP TABLE IF EXISTS BQ_OrdersDiscounts;

CREATE TABLE BQ_OrdersDiscounts
SELECT
	orders.created AS 'MesDiaHora',
	orders.created AS 'FechaOrden',
    YEAR(orders.created) AS 'Anio',
    MONTHNAME(orders.created) AS 'Mes',    
    orders_groups.orderId AS 'IdOrden',
    users.id AS 'IdUsuario',
	users.email AS 'Email',
    orders_groups.code AS 'Parte',
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
    orders_groups.campaignId AS 'IdCampania',
    orders_groups.name AS 'Campania',
    discounts.description AS 'Descripcion',
    CASE
		WHEN (discounts.description IS NOT NULL AND
			 orders_groups.discount IS NOT NULL) THEN 'Con descuento'
		ELSE 'Sin descuento'
	END AS 'AplicaDescuento',
    
    CASE
		WHEN discounts.description LIKE 'gb_mkt_crm_acq%' THEN 'MKT CRM - ACQ'
        WHEN discounts.description LIKE 'gb_mkt_crm_ord%' THEN 'MKT CRM - ORD'
        WHEN discounts.description LIKE 'gb_mkt_oac_acq%' THEN 'MKT Offline Activation - ACQ'
        WHEN discounts.description LIKE 'gb_mkt_oso_acq%' THEN 'MKT Owned Social - ACQ'
        WHEN discounts.description LIKE 'gb_mkt_oso_ord%' THEN 'MKT Owned Social - ORD'
        WHEN discounts.description LIKE 'gb_mkt_pso_acq%' THEN 'MKT Paid Social - ACQ'
        WHEN discounts.description LIKE 'gb_ops_cca_ord%' THEN 'OPE Customer Care - ORD'
		WHEN discounts.description LIKE 'gb_sls_mee_ord%' THEN 'SAL Meetings - ORD'
		WHEN discounts.description LIKE 'gb_sls_par_ord%' THEN 'SAL Partnerships - ORD'
		WHEN discounts.description LIKE 'Primera Compra Concretada%' THEN 'Plan 11/11'	
		WHEN discounts.description LIKE '%Especial Clientes Geelbe%' THEN 'Clientes Geelbe'    
        WHEN discounts.description LIKE 'Descuento Geelbe Empleados' THEN 'Geelbers'
        WHEN discounts.description LIKE '%employees' THEN 'Geelbers'
        ELSE 'Descuento Sin Agrupar'
    END AS 'DescuentoAgrupado',
    
    discounts.code AS 'PROMOCODE',
    ROUND(AVG(orders_groups.discount), 0) AS 'Descuento',
    ROUND(AVG(orders_groups.subtotal), 0) AS 'Subtotal',
    ROUND(AVG(orders_groups.credits), 0) AS 'Créditos',
    ROUND(AVG(orders_groups.shipping), 0) AS 'CostoEnvio'
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