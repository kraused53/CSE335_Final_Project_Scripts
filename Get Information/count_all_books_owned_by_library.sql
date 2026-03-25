USE `DROP TABLE *`;

SELECT
	SUM( GetBookCounts.book_count ) AS 'Total Books'
FROM (
	SELECT
		COUNT( `isbn` ) AS book_count
	FROM
		(
			SELECT
				*
			FROM
				books
			WHERE
				books.book_id NOT IN (
					SELECT
						loans.book_id
					FROM
						loans
				)
		) GetBooks
	GROUP BY
		`isbn`
) GetBookCounts;