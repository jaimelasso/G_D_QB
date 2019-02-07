SELECT
	users_credits.userId,
	users.email,
	SUM(users_credits.amount) AS 'GCash'
FROM
	users_credits
LEFT JOIN
	users ON (users_credits.userId = users.id)
GROUP BY
	users.email;