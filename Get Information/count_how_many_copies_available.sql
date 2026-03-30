USE `DROP TABLE *`;

SELECT
	count( books.book_id )
FROM
	books
WHERE
	books.book_id
    NOT IN (
		SELECT
			loans.book_id
		FROM
			loans
    )
    AND
    books.isbn = '9780547928227';