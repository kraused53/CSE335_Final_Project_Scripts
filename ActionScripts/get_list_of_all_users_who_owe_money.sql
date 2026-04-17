SELECT
	-- Join first and last name for clarity
	CONCAT( first_name, " ", last_name ) AS 'Patron Name',
    -- Fetch fines information
    fines AS 'Fines',
    -- Fetch patron card number
    card_number AS 'Library Card Number'
-- Only need patrons table
FROM `DROP TABLE *`.patrons
-- Only display data for patrons who have a non-zero fine
WHERE fines <> 0.00
-- Order output so that the patron with the most fines is first
ORDER BY fines DESC;