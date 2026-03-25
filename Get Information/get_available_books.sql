USE `DROP TABLE *`;

SELECT
    `title` AS 'Title',
    `author` AS 'Author',
    COALESCE( `description`, 'No  description found.' )  AS 'Description',
	`isbn` AS 'ISBN',
    COUNT( `isbn` ) AS 'Copies Available'
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
	`isbn`;