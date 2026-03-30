USE `DROP TABLE *`;

SELECT
    `title` AS 'Title',
    `author` AS 'Author',
    COALESCE( `description`, 'No  description found.' )  AS 'Description',
	`isbn` AS 'ISBN',
    book_id AS 'Book ID'
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
;