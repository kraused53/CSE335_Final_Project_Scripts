SELECT
	-- Join first and last name for clarity
	CONCAT( patrons.first_name, " ", patrons.last_name ) AS 'Patron Name',
    -- Fetch fines information
    patrons.fines AS 'Fines',
    -- Fetch patron card number
    patrons.card_number AS 'Library Card Number'
-- Only need patrons table
FROM `DROP TABLE *`patrons
-- Only display data for patrons who have a non-zero fine
WHERE patrons.fines <> 0.00
-- Order output so that the patron with the most fines is first
ORDER BY patrons.fines DESC;