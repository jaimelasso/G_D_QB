DROP TABLE BQ_ProductsLines;

CREATE TABLE BQ_ProductsLines
SELECT
    CAST(orders.created AS DATE) AS 'FechaOrden',
    orders.id AS 'IdOrden',
    orders_products.productId AS 'IdProducto',
    products.name AS 'Producto',
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

    MIN(categories.code) AS categoriaId,
    CASE
        WHEN categories.code LIKE '%G01%' THEN 'Hombre'
        WHEN categories.code LIKE '%G02%' THEN 'Mujer'
        WHEN categories.code LIKE '%G03%' THEN 'Niños'
        WHEN categories.code LIKE '%G04%' THEN 'Hogar'
        WHEN categories.code IS NULL THEN 'Otros'
    END AS 'Categoria',
    CASE
        WHEN categories.code LIKE '%G01010101%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010102%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010103%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010104%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010105%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010201%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010202%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010203%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010204%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010205%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010206%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010301%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010302%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010303%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010304%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010305%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010306%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010401%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010402%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010403%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010404%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01010405%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01020101%' THEN 'Calzado'
        WHEN categories.code LIKE '%G01020102%' THEN 'Calzado'
        WHEN categories.code LIKE '%G01020201%' THEN 'Calzado'
        WHEN categories.code LIKE '%G01020202%' THEN 'Calzado'
        WHEN categories.code LIKE '%G01020203%' THEN 'Calzado'
        WHEN categories.code LIKE '%G01020301%' THEN 'Calzado'
        WHEN categories.code LIKE '%G01020302%' THEN 'Calzado'
        WHEN categories.code LIKE '%G01020303%' THEN 'Calzado'
        WHEN categories.code LIKE '%G01020304%' THEN 'Calzado'
        WHEN categories.code LIKE '%G01030101%' THEN 'Duros'
        WHEN categories.code LIKE '%G01030102%' THEN 'Duros'
        WHEN categories.code LIKE '%G01030201%' THEN 'Duros'
        WHEN categories.code LIKE '%G01030202%' THEN 'Duros'
        WHEN categories.code LIKE '%G01030203%' THEN 'Duros'
        WHEN categories.code LIKE '%G01030301%' THEN 'Duros'
        WHEN categories.code LIKE '%G01030302%' THEN 'Duros'
        WHEN categories.code LIKE '%G01030401%' THEN 'Duros'
        WHEN categories.code LIKE '%G01030402%' THEN 'Duros'
        WHEN categories.code LIKE '%G01030501%' THEN 'Duros'
        WHEN categories.code LIKE '%G01030607%' THEN 'Duros'
        WHEN categories.code LIKE '%G01030608%' THEN 'Duros'
        WHEN categories.code LIKE '%G01030609%' THEN 'Duros'
        WHEN categories.code LIKE '%G01030610%' THEN 'Duros'
        WHEN categories.code LIKE '%G01030611%' THEN 'Duros'
        WHEN categories.code LIKE '%G01030601%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01030602%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01030603%' THEN 'Duros'
        WHEN categories.code LIKE '%G01030604%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01030605%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01030606%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01030701%' THEN 'Blandos'
        WHEN categories.code LIKE '%G01030702%' THEN 'Duros'
        WHEN categories.code LIKE '%G01030703%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010101%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010102%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010103%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010104%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010105%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010106%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010201%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010202%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010203%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010204%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010205%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010206%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010207%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010208%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010209%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010210%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010301%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010302%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010303%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010304%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010401%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010402%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010403%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010501%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010502%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010503%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010504%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010505%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02010506%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02020101%' THEN 'Calzado'
        WHEN categories.code LIKE '%G02020102%' THEN 'Calzado'
        WHEN categories.code LIKE '%G02020201%' THEN 'Calzado'
        WHEN categories.code LIKE '%G02020202%' THEN 'Calzado'
        WHEN categories.code LIKE '%G02020203%' THEN 'Calzado'
        WHEN categories.code LIKE '%G02020204%' THEN 'Calzado'
        WHEN categories.code LIKE '%G02020301%' THEN 'Calzado'
        WHEN categories.code LIKE '%G02020302%' THEN 'Calzado'
        WHEN categories.code LIKE '%G02020303%' THEN 'Calzado'
        WHEN categories.code LIKE '%G02030101%' THEN 'Duros'
        WHEN categories.code LIKE '%G02030102%' THEN 'Duros'
        WHEN categories.code LIKE '%G02030201%' THEN 'Duros'
        WHEN categories.code LIKE '%G02030202%' THEN 'Duros'
        WHEN categories.code LIKE '%G02030301%' THEN 'Duros'
        WHEN categories.code LIKE '%G02030401%' THEN 'Duros'
        WHEN categories.code LIKE '%G02030406%' THEN 'Duros'
        WHEN categories.code LIKE '%G02030407%' THEN 'Duros'
        WHEN categories.code LIKE '%G02030408%' THEN 'Duros'
        WHEN categories.code LIKE '%G02030409%' THEN 'Duros'
        WHEN categories.code LIKE '%G02030410%' THEN 'Duros'
        WHEN categories.code LIKE '%G02030411%' THEN 'Duros'
        WHEN categories.code LIKE '%G02030402%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02030403%' THEN 'Duros'
        WHEN categories.code LIKE '%G02030404%' THEN 'Blandos'
        WHEN categories.code LIKE '%G02030405%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010101%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010102%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010103%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010104%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010105%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010106%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010107%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010108%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010109%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010110%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010201%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010202%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010203%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010204%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010205%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010206%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010207%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010208%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010209%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010210%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010211%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03010301%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03020101%' THEN 'Calzado'
        WHEN categories.code LIKE '%G03020102%' THEN 'Calzado'
        WHEN categories.code LIKE '%G03020103%' THEN 'Calzado'
        WHEN categories.code LIKE '%G03020104%' THEN 'Calzado'
        WHEN categories.code LIKE '%G03030101%' THEN 'Duros'
        WHEN categories.code LIKE '%G03030201%' THEN 'Duros'
        WHEN categories.code LIKE '%G03030202%' THEN 'Duros'
        WHEN categories.code LIKE '%G03030303%' THEN 'Duros'
        WHEN categories.code LIKE '%G03030401%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G03030402%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G03030404%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G03030506%' THEN 'Duros'
        WHEN categories.code LIKE '%G03030507%' THEN 'Duros'
        WHEN categories.code LIKE '%G03030508%' THEN 'Duros'
        WHEN categories.code LIKE '%G03030501%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03030502%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03030503%' THEN 'Duros'
        WHEN categories.code LIKE '%G03030504%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03030505%' THEN 'Blandos'
        WHEN categories.code LIKE '%G03030601%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G03030602%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G03030603%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G03030604%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G03030605%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G03030606%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010101%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010102%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010103%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010104%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010201%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010202%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010203%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010204%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010205%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010301%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010302%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010303%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010304%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010305%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010306%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010307%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010401%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010402%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010403%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010404%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010501%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010502%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010503%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010504%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010505%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010601%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010602%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010701%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04010702%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020101%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020102%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020103%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020201%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020202%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020203%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020301%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020302%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020303%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020304%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020305%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020306%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020307%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020308%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020309%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020401%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020402%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020403%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020501%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020502%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020503%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020601%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020602%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020603%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020604%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020605%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04020606%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04030101%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04030201%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04030202%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04030203%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04030204%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04030205%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04030206%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04040101%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04040102%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04040103%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04040104%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04040105%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04040106%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04040107%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04040201%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04040202%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04040204%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04040205%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04040207%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04040301%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04040302%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04040303%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04050101%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04050102%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04050103%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04050104%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04060101%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04060102%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04060103%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04060104%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04060106%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04060107%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04060108%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04060201%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04060202%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04060203%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04060301%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04060401%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04060402%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04060403%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04070101%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04070102%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04070103%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04070104%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04080101%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04080102%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04080103%' THEN 'Textil hogar, muebles y deco'
        WHEN categories.code LIKE '%G04080201%' THEN 'Duros'
        WHEN categories.code LIKE '%G04080202%' THEN 'Duros'
        WHEN categories.code LIKE '%G04080301%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04080302%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04090101%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04090102%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04090103%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04090104%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04100101%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04100102%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04100103%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04100104%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04100105%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04100201%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04100202%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04110101%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04110102%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04110103%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04110104%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04110201%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04110202%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04110203%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04120101%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04120102%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04120103%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04130101%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04130102%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%G04130103%' THEN 'Comp. Hogar y Jugueteria'
        WHEN categories.code LIKE '%HS%' THEN 'Blandos'
        WHEN categories.code LIKE '%HM%' THEN 'Blandos'
        WHEN categories.code LIKE '%HL%' THEN 'Blandos'
        WHEN categories.code LIKE '%HXL%' THEN 'Blandos'
        WHEN categories.code LIKE '%MXS%' THEN 'Blandos'
        WHEN categories.code LIKE '%MS%' THEN 'Blandos'
        WHEN categories.code LIKE '%MM%' THEN 'Blandos'
        WHEN categories.code LIKE '%ML%' THEN 'Blandos'
        WHEN categories.code LIKE '%MXL%' THEN 'Blandos'
        WHEN categories.code LIKE '%MXS%' THEN 'Blandos'
        WHEN categories.code LIKE '%MS%' THEN 'Blandos'
        WHEN categories.code LIKE '%MM%' THEN 'Blandos'
        WHEN categories.code LIKE '%ML%' THEN 'Blandos'
        WHEN categories.code LIKE '%MXL%' THEN 'Blandos'
        WHEN categories.code LIKE '%H3%' THEN 'Calzado'
        WHEN categories.code LIKE '%H4%' THEN 'Calzado'
        WHEN categories.code LIKE '%M3%' THEN 'Calzado'
        WHEN categories.code LIKE '%M4%' THEN 'Calzado'
        WHEN categories.code IS NULL THEN 'Otros'
    END AS 'Linea',
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




SELECT * FROM V_ProductLines;

SELECT * FROM BQ_ProductsLines;






