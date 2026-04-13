SELECT
	-- Display book title
    b.title AS 'Title',
    -- Display book author
    b.author AS 'Author',
    -- Display ISBN
    b.isbn AS 'ISBN',
    -- Display the book description, or 'No description found.'
    COALESCE(b.description, 'No description found.') AS 'Description',
    -- Subtract the loaned book count from the total book count of each book owned by the library
    COUNT(b.book_id) - COUNT(l.book_id) AS 'Copies Available'
-- Join the books and loans table to gather all the needed data
FROM `DROP TABLE *`.books b
LEFT JOIN `DROP TABLE *`.loans l
    ON b.book_id = l.book_id
-- Use group by ISBN to condence each book to a single entry. Also allows the use of COUNT( ... )
GROUP BY b.isbn;