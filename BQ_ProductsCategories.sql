# Ya que existen productos con más de una categoría, este Query elije la categoría más reciente para cada producto.
# Además, se une a la tabla de productos sin categoría para actualizar data de años anteriores.
DROP TABLE IF EXISTS BQ_ProductsCategories;

CREATE TABLE BQ_ProductsCategories
SELECT
	products_categories.productId,
	MAX(products_categories.categoryId) AS 'categotyId',
FROM
	products_categories
GROUP BY
	products_categories.productId
UNION
	(SELECT * FROM BQ_ProductsWithoutCategories);