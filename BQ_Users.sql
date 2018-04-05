SELECT
	CAST(geelbe.users.created as DATE) as 'FechaRegistro',
	geelbe.users.id AS 'IdUsuario',
	geelbe.users.email AS 'Mail',
	geelbe.users.invitationCode AS 'Código_invitacion'

FROM
	geelbe.users

WHERE
	(geelbe.users.created >= '2018-01-01 00:00:00');

#ORDER BY ventaspop2_davivienda.users.created;