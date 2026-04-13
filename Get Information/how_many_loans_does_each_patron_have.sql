USE `DROP TABLE *`;

SELECT
	CONCAT( patrons.first_name, '  ', patrons.last_name ) AS 'Patron Name',
    COUNT( loans.loan_id ) AS 'Number of loans'
FROM
	patrons
LEFT JOIN
	loans
ON
	patrons.card_number = loans.card_number
GROUP BY
	patrons.card_number
ORDER BY
	COUNT( loans.loan_id )
    DESC;