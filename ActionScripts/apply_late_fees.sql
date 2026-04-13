-- This script will apply a late fee of $0.25 for each book that is outstanding.
-- In an automated system, this script would run once a day
UPDATE `DROP TABLE *`.patrons
-- The CTE inside the () generate a table of values containing a list of the card_number for each patron with a late book and the number of late books each patron has
JOIN (
	SELECT 
		-- Need card_number to apply fines
		patrons.card_number,
        -- Count how many late books each patron has
        COUNT( * ) AS number_late
	FROM `DROP TABLE *`.patrons	
	-- Join the patrons table with the results of the below query
    JOIN (
		-- Returns an entry for each loan that is currently past due.
		SELECT card_number
		-- Selecting information from the loans table
        FROM `DROP TABLE *`.loans
		-- Only include entries who have a due_date that is before today's date
        WHERE due_date < CURDATE()
	) LateBooks
    -- Join patrons an LateBooks using card_number
	ON LateBooks.card_number = patrons.card_number
	-- Using the GROUP BY statement lets the query count howmany late books each patron has
    GROUP BY card_number
) HowManyLateBooks
-- Link the patrons table and the HowManyLateBooks using the card_number attribute
ON patrons.card_number = HowManyLateBooks.card_number
-- Update the fines field of each patron indicated by the HowManyLateBooks CTE
SET patrons.fines = patrons.fines + ( 0.25 * HowManyLateBooks.number_late );