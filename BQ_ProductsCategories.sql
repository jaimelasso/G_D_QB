# Ya que existen productos con más de una categoría, este Query elige la categoría más reciente para cada producto.
# Además, se une a la tabla de productos sin categoría para actualizar data de años anteriores.

DROP TABLE IF EXISTS BQ_ProductsCategories;

CREATE TABLE IF NOT EXISTS BQ_ProductsCategories (
	productId INT,
	categotyId INT
);

	FOREIGN KEY (productId) REFERENCES products(id)


INSERT INTO BQ_ProductsCategories (productId, categotyId)
SELECT
	products_categories.productId,
	MAX(products_categories.categoryId) AS 'categotyId'
FROM
	products_categories
GROUP BY
	products_categories.productId;
UNION
	(SELECT * FROM BQ_ProductsWithoutCategories);
	
SELECT * FROM BQ_ProductsWithoutCategories;