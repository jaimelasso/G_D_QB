SELECT
	CAST(users.created as DATE) as 'FechaRegistro',
	users.id AS 'IdUsuario',
	users.email AS 'Mail',
    users.name AS 'Nombre',
    users.surname AS 'Apellido',
    users.billingTel AS 'Telefono',
    users.sex AS 'Género',
    TIMESTAMPDIFF(YEAR,users.birthdate, CURDATE()) AS 'Edad'
FROM
	users;

WHERE
	(geelbe.users.created >= '2018-01-01 00:00:00');

#ORDER BY ventaspop2_davivienda.users.created;	

SELECT * FROM users;

SELECT
	users.id,
	users.email,
    users.subscribed,
    users.unsubscribedDate,
    users.active,
    users.lastLogin,
    users.created
FROM
	users;
    











# -------------------

SELECT
	BQ_Acquisitions.FechaOrden,
    BQ_Acquisitions.Orden,
    BQ_Acquisitions.Email,
    BQ_Acquisitions.TipoOrden,
    BQ_Acquisitions.FuenteFinal
FROM
	BQ_Acquisitions;
    


SELECT
	BQ_AcquisitionsSimulated.FechaOrden,
    BQ_AcquisitionsSimulated.Orden,
    BQ_AcquisitionsSimulated.Orden AS 'OrderDimension',
    BQ_AcquisitionsSimulated.Email,
    BQ_AcquisitionsSimulated.TipoOrden,
    BQ_AcquisitionsSimulated.FuenteFinal
FROM
	BQ_AcquisitionsSimulated;