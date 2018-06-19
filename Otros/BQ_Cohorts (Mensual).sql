SELECT
	COUNT(DISTINCT(email)) as 'user', 
    fechaMes as 'Fechacompra', 
    Edadcompra, 
    YEAR(FechaPrimerPedido) * 100 + MONTH(FechaPrimerPedido) as 'FechaPrimerPedido',
    sum(subtotal),
    sum(discount),
    sum(shipping),
    sum(total),
    count(distinct(id))
FROM (
	SELECT
		users.email, 
        year(geelbe.orders.created) * 100 + month(geelbe.orders.created) as fechaMes, 
        geelbe.orders.created, 
        FechaPrimerPedido, 
		12*(YEAR(geelbe.orders.created) - YEAR(FechaPrimerPedido)) + (MONTH(geelbe.orders.created) - MONTH(FechaPrimerPedido)) AS Edadcompra,
        orders.subtotal,
        orders.discount,
        orders.shipping,
        orders.total,
        orders.id
		FROM
			geelbe.orders
		LEFT JOIN geelbe.users 
			ON (geelbe.users.id = geelbe.orders.userid)
		LEFT JOIN (
			SELECT
				primero.email,
                FechaPrimerPedido,
                primero.subtotal,
                primero.discount,
                primero.shipping,
                primero.total,
                primero.id
				FROM (
					SELECT
						users.email, 
                        MIN(geelbe.orders.created) as FechaPrimerPedido,
                        geelbe.orders.subtotal,
                        orders.discount,
                        orders.shipping,
                        orders.total,
                        orders.id
						FROM
							geelbe.orders
						LEFT JOIN geelbe.users 
							ON (geelbe.users.id = geelbe.orders.userid) 
						WHERE
							(geelbe.orders.statusId ='2' or 
                            geelbe.orders.statusId='4' or 
                            geelbe.orders.statusId='6' or 
                            geelbe.orders.statusId='12')
							and (email not like '%prueba%')
							and (users.name not like '%prueba%')
							and (users.surname != '%prueba%')
							and (geelbe.users.id IS NOT NULL)
							group by users.email
						) AS primero
				LEFT JOIN (
					SELECT
						users.email, 
                        geelbe.orders.created as fechaorden,
                        geelbe.orders.subtotal,
                        orders.discount,
                        orders.shipping,
                        orders.total,
                        orders.id
                        FROM
							geelbe.orders
						LEFT JOIN geelbe.users 
							ON (geelbe.users.id = geelbe.orders.userid)
						WHERE (geelbe.orders.statusId ='2' or 
								geelbe.orders.statusId='4' or 
                                geelbe.orders.statusId='6' or 
                                geelbe.orders.statusId='12')
								and (email not like '%prueba%')
								and (users.name not like '%prueba%')
								and (users.surname != '%prueba%')
								and (geelbe.users.id IS NOT NULL)
						GROUP BY users.email
					) AS segundo
					ON (primero.email = segundo.email and primero.FechaPrimerPedido = segundo.fechaorden)
      ) AS lala
		ON (users.email = lala.email)
	WHERE
		(geelbe.orders.statusId ='2' or 
        geelbe.orders.statusId='4' or 
        geelbe.orders.statusId='6' or 
        geelbe.orders.statusId='12')
		and (users.email not like '%prueba%')
		and (users.name not like '%prueba%')
		and (users.surname != '%prueba%')
		and (geelbe.users.id IS NOT NULL)
		and 12*(YEAR(CURDATE()) - YEAR(geelbe.orders.created)) + (MONTH(CURDATE()) - MONTH(geelbe.orders.created)) <>0
		and  12*(YEAR(CURDATE()) - YEAR(FechaPrimerPedido)) + (MONTH(CURDATE()) - MONTH(FechaPrimerPedido)) <>0) final
	GROUP BY fechaMes, Edadcompra, year(FechaPrimerPedido) *100 + month(FechaPrimerPedido);