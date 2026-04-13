SELECT
	CONCAT( patrons.first_name, "  ", patrons.last_name ) AS "Name",
    patrons.card_number AS "Card Number",
    patrons.fines AS "Fines"
FROM
	`DROP TABLE *`.patrons
ORDER BY
	patrons.fines
    DESC;