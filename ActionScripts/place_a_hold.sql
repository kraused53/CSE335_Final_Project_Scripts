-- Book to hold
SET @isbn_for_hold = '9780307281746';

-- Date of hold YYYY-MM-DD
SET @date_held =  '2026-03-24';

-- Card number of patron
SET @card_number_for_hold = 51;

-- See if the user already has this book on loan
SET @hold_user_book_search_loan = ( 
	SELECT COUNT( * ) 
	FROM `DROP TABLE *`.loans 
    WHERE loans.book_id IN ( 
		SELECT books.book_id 
        FROM `DROP TABLE *`.books 
        WHERE books.isbn = @isbn_for_hold 
	) 
    AND loans.card_number = @card_number_for_hold 
);

-- See if the user already has this book on hold
SET @hold_user_book_search_hold = ( 
	SELECT COUNT( * ) 
    FROM `DROP TABLE *`.holds 
    WHERE 
		holds.isbn = @isbn_for_hold
		AND 
		holds.card_number = @card_number_for_hold 
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
--		1] The user currently has 0 books loaned with a matching ISBN
FROM DUAL
WHERE
    @hold_user_book_search_loan = 0
    AND
    @hold_user_book_search_hold = 0;