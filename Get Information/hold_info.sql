-- This script is part of the book return process.
-- In an automated system, this script would be run after a loan is removed
-- isbn_lookup comes from the deleted loan

-- Set the ISBN of the returned book
SET @isbn_lookup = '9780307281746';

SELECT 
	hold_id AS 'Hold to delete', 
    card_number AS 'Patron to loan to',
    isbn AS 'Book to loan'
FROM `DROP TABLE *`.holds
ORDER BY date_held ASC
LIMIT 1;