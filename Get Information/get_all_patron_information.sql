SELECT
	CONCAT( patrons.first_name, "  ", patrons.last_name ) AS 'Name',
    card_number AS 'Card NUmber',
    fines AS 'Fines'
FROM
	`DROP TABLE *`.patrons;