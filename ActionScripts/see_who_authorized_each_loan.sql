USE `DROP TABLE *`;

SELECT														-- Select the needed attributes from each table and provide a readable title
	CONCAT( l.first_name, " ", l.last_name ) AS 'This Librarian',
    CONCAT( "[ ", b.isbn, " ] - ", '"', b.title, '"', " by ", b.author ) AS 'Loaned This Book',
	CONCAT( p.first_name, " ", p.last_name ) AS 'To This Patron',
    loans.due_date AS 'And It Is Due By'
FROM loans													-- Use loans as the base table
JOIN      books AS b ON      loans.book_id = b.book_id		-- Use book_id to relate loans and books
JOIN librarians AS l ON loans.librarian_id = l.librarian_id	-- Use librarian_id to relate loans and librarians
JOIN    patrons AS p ON  loans.card_number = p.card_number	-- Use card_number to relate loans and patrons
ORDER BY l.last_name;										-- Sort final table by the name of the librarian who serviced the loan