USE `DROP TABLE *`;

-- List patron full name and the number of loans they have
SELECT CONCAT( patrons.first_name, '  ', patrons.last_name ) AS 'Patron Name', COUNT( loans.loan_id ) AS 'Number of loans'
-- Patrons table has name
FROM patrons
-- Loans has all active loans
LEFT JOIN loans
-- Join patrons and loans using card_number
ON patrons.card_number = loans.card_number
-- Group entries by card_number to allow the script to count how many loans are associated with each card_number
GROUP BY patrons.card_number
-- Display the person with the most loans at the top of the list
ORDER BY COUNT( loans.loan_id ) DESC;