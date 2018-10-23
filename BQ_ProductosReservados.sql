DROP TABLE IF EXISTS BQ_ProductosReservados;

CREATE TABLE BQ_ProductosReservados
SELECT 
    products_stock_history.productId, 
    SUM(products_stock_history.newStock) AS 'Inventario Inicial'
FROM
    products_stock_history
WHERE
    products_stock_history.oldStock = '0'
GROUP BY productId;