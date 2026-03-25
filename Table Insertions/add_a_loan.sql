USE `DROP TABLE *`;

INSERT INTO
	`loans` (
		`book_id`,
        `librarian_id`,
        `card_number`,
        `checkout_date`,
        `due_date`
    )
VALUES (
	-- Book ID
	38,
	-- Librarian ID
    1,
    -- Card Number
	1,
    -- Checkout Date
    '2026-03-23',
    -- Start Date
    '2026-04-06'
);