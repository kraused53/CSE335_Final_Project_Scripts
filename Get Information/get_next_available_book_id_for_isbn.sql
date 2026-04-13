SET @patron_card_number = 1;
SET @book_isbn = '9780547928197';

SELECT
	COUNT( books.book_id ) AS outcome,
    books.book_id
FROM
	`DROP TABLE *`.books
WHERE
	books.book_id = (
		SELECT
			book_id
		FROM
			`DROP TABLE *`.books
		WHERE
			books.book_id
			NOT IN (
				SELECT
					loans.book_id
				FROM
					`DROP TABLE *`.loans
			)
			AND
			books.isbn = @book_isbn
		LIMIT
			1
);