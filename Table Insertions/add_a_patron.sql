USE `DROP TABLE *`;

INSERT INTO
	`patrons` (
		`first_name`,
        `last_name`,
        `fines`
    )
VALUES (
	-- First Name
	'John',
	-- Last Name
    'Doe',
    -- Fines ( Can Be 0.00 )
	2.25
);