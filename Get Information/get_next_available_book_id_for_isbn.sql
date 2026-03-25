USE `DROP TABLE *`;

SELECT
	books.book_id
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
    books.isbn = '1'
LIMIT
	1;