USE `DROP TABLE *`;

SELECT
	concat( patrons.first_name, '  ', patrons.last_name ) AS 'Patron Name',
    COUNT( loans.loan_id ) AS 'Number of loans'
FROM
	patrons
LEFT JOIN
	loans
ON
	patrons.card_number = loans.card_number
GROUP BY
	patrons.card_number;