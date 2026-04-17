USE `DROP TABLE *`;

-- Set patron card number
SET @patron_card_number = 1;

-- Take given patron card number and build patron full name
SET @patron_name = ( 
	-- Look up the patron entry using their card number, and concatenate first and last names
	SELECT CONCAT( patrons.first_name, " ", patrons.last_name ) 
	FROM patrons 
	WHERE patrons.card_number = @patron_card_number 
);

-- Main Query: Get all active loans for given patron card number
SELECT
	@patron_name AS 'Patron Name',
    get_loaned_books_author AS 'Book Title',
    get_loaned_books_title AS 'Book Author',
    get_loaned_books_isbn AS 'Book ISBN',
    get_loaned_books_due AS 'Due By'
FROM
	-- Join patrons table to CTE resulting from subu-query
    -- Only includes patrons with active loans
	patrons
JOIN 
	-- This nested query returns a CTE containing some information about every active loan
	(
		SELECT
			-- Extract relevant information
			books.author AS get_loaned_books_author,
			books.title AS get_loaned_books_title,
            books.isbn  AS get_loaned_books_isbn,
            books.book_id  AS get_loaned_books_id,
            loans.card_number AS get_loaned_books_card,
            loans.due_date AS get_loaned_books_due
 		FROM books
		-- Join active loans and book master list
		-- Only include books that are currently loaned out
		JOIN loans
		-- Use book id to join books to loans
        ON books.book_id = loans.book_id
    ) get_loaned_books
-- Use card number to link patrons to active loans
ON patrons.card_number = get_loaned_books.get_loaned_books_card
-- Only output data for the given patron card number
WHERE patrons.card_number = @patron_card_number
-- Order results by due date, closest first
ORDER BY get_loaned_books_due ASC;