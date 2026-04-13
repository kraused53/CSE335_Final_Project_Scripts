-- ISBN of the book to hold
SET @isbn_for_hold = '9780307281746';

-- Date of hold YYYY-MM-DD ( Today's date )
SET @date_held = CURDATE();

-- Card number of patron requesting the hold
SET @card_number_for_hold = 1;

-- See if the user already has this book on loan ( 1 if patron already has book on loan, 0 otherwise )
SET @hold_user_book_search_loan = ( 
	-- Count the number of loaned books with a matching isbn. Should return 1 or 0 if all other scripts are behaving
	SELECT COUNT( * ) 
    -- Source this information from the list of current loans
	FROM `DROP TABLE *`.loans 
    -- The query in the () will fetch all of the books_ids for books with matching ISBNs
    WHERE loans.book_id IN ( 
		-- Get a list of book_ids
		SELECT books.book_id 
        -- From the books table
        FROM `DROP TABLE *`.books
        -- Only include books with the ISBN of the book being held
        WHERE books.isbn = @isbn_for_hold 
	)
    -- Restrict the list to entries with a card_number matching the card_number of the patron who is placing a hold
    AND loans.card_number = @card_number_for_hold 
);

-- See if the user already has this book on hold
SET @hold_user_book_search_hold = ( 
	-- Count the number of held books with a matching isbn. Should return 1 or 0 if all other scripts are behaving
	SELECT COUNT( * ) 
    -- Only need to query the holds table
    FROM `DROP TABLE *`.holds 
    -- Only count holds that meet the following:
    --   1] The ISBN of the existing hold matches the ISBN of the book to be held
    --   2] The card_number of the existing hold matches the card_number of the patron requesting the hold
    WHERE holds.isbn = @isbn_for_hold AND holds.card_number = @card_number_for_hold 
);

-- Use gathered data to add hold
INSERT INTO `DROP TABLE *`.holds (
	isbn,				-- The isbn of the book to hold
    card_number,		-- The card number of the patron holding the book
    date_held			-- The date the book was held
) SELECT
	@isbn_for_hold,
    @card_number_for_hold,
    @date_held
-- The below causes the the above to run IF AND ONLY IF the following conditions are met:
--   1] The user currently has 0 books loaned with a matching ISBN
--   1] The user currently has 0 books held with a matching ISBN
FROM DUAL
WHERE
    @hold_user_book_search_loan = 0 AND @hold_user_book_search_hold = 0;