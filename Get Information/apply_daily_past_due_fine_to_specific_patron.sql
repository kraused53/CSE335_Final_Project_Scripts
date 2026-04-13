UPDATE 
	`DROP TABLE *`.patrons
SET
	patrons.fines = patrons.fines + 0.25
WHERE
	patrons.card_number = 1;