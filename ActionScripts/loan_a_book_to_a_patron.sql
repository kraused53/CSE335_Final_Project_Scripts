-- Define the isbn for the book you want to loan
SET @isbn_for_loan = '9780307281746';

-- Define the user who is loaning the book
SET @card_number_for_loan = 50;

-- GET a random librarian ID
SET @get_rand_librarian_id = ( 
	SELECT librarian_id 
	FROM `DROP TABLE *`.librarians 
	ORDER BY RAND() 
	LIMIT  1
);

-- Get next available copy of given isbn. Set to -1 if no book is found
-- The inner most query fetches all current loans
-- The middle query makes a list of books who's isbns matach the one set 
--     above and who's book_id do NOT appear in the list of laons.
--     This leaves us with a list of all the currently available copies of the requested isbn
-- The outermost query takes this list and limits it to a single output.
-- The output of this nested query is the id of the next available book with a matching isbn
SET @next_available_copy = ( 
	SELECT books.book_id
	FROM `DROP TABLE *`.books
	WHERE books.book_id = (
		SELECT book_id 		
		FROM `DROP TABLE *`.books 
		WHERE books.book_id 
		NOT IN ( 
			SELECT loans.book_id 
			FROM `DROP TABLE *`.loans 
		) 
		AND 
		books.isbn = @isbn_for_loan 
		LIMIT 1 					-- Limit the outer query to 1 result
	) 
);

SET @next_available_copy = if ( @next_available_copy IS NULL, -1, @next_available_copy );

-- See if the given user already has a copy of the given isbn
SET @user_book_search = ( 
	SELECT COUNT( * ) 
    FROM `DROP TABLE *`.loans 
    -- Build a table that contains a list of loans, only if:
    --   1] The loan's book_id matches one of the ids associated with the given ISBN
    WHERE loans.book_id IN ( 
		-- Get a list of all of the book IDs associated with the given isbn
		SELECT books.book_id 
        FROM `DROP TABLE *`.books 
        WHERE books.isbn = @isbn_for_loan 
	) 
    AND 
    --   2] The laons belong to the given patron
    loans.card_number = @card_number_for_loan
);

-- Get current date
SET @date_today = ( CURRENT_DATE() );

-- Calulate Due Date
SET @date_due = ( DATE_ADD( CURRENT_DATE(), INTERVAL 14 DAY ) );

-- Use gathered data to add loan
INSERT INTO `DROP TABLE *`.loans (
	book_id,				-- The id of the book to loan
    librarian_id,			-- The id of the librarian who loaned the book
    card_number,			-- The card number of the patron loaning the book
    checkout_date,			-- The date the book was checked out
    due_date				-- The date the book will be due
) SELECT
	@next_available_copy,	-- The next available copy of the given ISBN
    @get_rand_librarian_id,	-- A randomized librarian ID
    @card_number_for_loan,	-- The card number of the patron loaning the book 
    @date_today,			-- The date the book was checked out
    @date_due				-- The date the book will be due
-- The below causes the the above to run IF AND ONLY IF the following conditions are met:
--   1] There is a valid ( non -1 ) value for next_available_copy
--   2] The user currently has 0 books loaned with a matching ISBN
FROM DUAL
WHERE
	@next_available_copy != -1
    AND
    @user_book_search = 0;
    