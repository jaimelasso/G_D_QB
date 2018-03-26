SELECT
	CAST(ventaspop2_davivienda.users.created as DATE) as 'Fecha_creacion',
	ventaspop2_davivienda.users.id AS 'IdUsuario',
	ventaspop2_davivienda.users.email AS 'Mail',
	ventaspop2_davivienda.users.invitationCode AS 'Código_invitacion'

FROM
	ventaspop2_davivienda.users

#WHERE
#	(ventaspop2_davivienda.users.created >= '2012-01-01 00:00:00')    

ORDER BY ventaspop2_davivienda.users.created;