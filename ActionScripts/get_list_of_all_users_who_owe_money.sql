USE `DROP TABLE *`;

SELECT
	CONCAT( patrons.first_name, " ", patrons.last_name ) AS 'Patron Name',
    patrons.fines AS 'Fines',
    patrons.card_number AS 'Library Card Number'
FROM
	patrons
WHERE
	patrons.fines <> 0.00
ORDER BY
	patrons.fines
    DESC;