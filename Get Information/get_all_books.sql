USE `DROP TABLE *`;

SELECT
	`isbn` AS 'ISBN',
    `title` AS 'Title',
    `author` AS 'Author',
    COUNT( `isbn` ) AS 'Number Of Copies',
    COALESCE( `description`, 'No  description found.' )  AS 'Description'
FROM
	`books`
GROUP BY
	`isbn`;