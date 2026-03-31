-- Define the isbn for the book you want to loan
SET @isbn_for_loan = '9781546171423';

-- Define the user who is loaning the book
SET @card_number_for_loan = 1;

-- GET a random librarian ID
SET @get_rand_librarian_id = ( SELECT librarian_id FROM `DROP TABLE *`.librarians ORDER BY  RAND() LIMIT  1 );

-- Get next available copy of given isbn. Set to -1 if no book is found
SET @next_available_copy = ( SELECT books.book_id FROM `DROP TABLE *`.books WHERE books.book_id = ( SELECT book_id FROM `DROP TABLE *`.books WHERE books.book_id NOT IN ( SELECT loans.book_id FROM `DROP TABLE *`.loans ) AND books.isbn = @isbn_for_loan LIMIT 1 ) );
SET @next_available_copy = if ( @next_available_copy IS NULL, -1, @next_available_copy );

-- See if the given user already has a copy of the given isbn
SET @user_book_search = ( SELECT COUNT( * ) FROM `DROP TABLE *`.loans WHERE loans.book_id IN ( SELECT books.book_id FROM `DROP TABLE *`.books WHERE books.isbn = @isbn_for_loan ) AND loans.card_number = @card_number_for_loan );

-- Get current date
SET @date_today = ( CURRENT_DATE() );

-- Calulate Due Date
SET @date_due = ( DATE_ADD( CURRENT_DATE(), INTERVAL 14 DAY ) );

-- Use gathered data to add loan
INSERT INTO `DROP TABLE *`.loans (
	book_id,
    librarian_id,
    card_number,
    checkout_date,
    due_date
) SELECT
	@next_available_copy,
    @get_rand_librarian_id,
    @card_number_for_loan,
    @date_today,
    @date_due
FROM DUAL
WHERE
	@next_available_copy != -1
    AND
    @user_book_search = 0;
    