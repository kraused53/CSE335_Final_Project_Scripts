SELECT
	*
FROM
	(
		SELECT
			title,
            author,
            checkout_date,
            due_date
		FROM
			`DROP TABLE *`.loans
		JOIN
			`DROP TABLE *`.books
		ON
			loans.book_id = books.book_id
		WHERE
			loans.card_number = 1
    ) GetLoans