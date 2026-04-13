-- Define the user who is paying off their account
SET @card_number_to_pay = 2;

-- The ammount of money to be paid off
SET @ammount_to_pay = 1.50;

-- Apply the payment
UPDATE `DROP TABLE *`.patrons
SET fines = GREATEST( ( fines - @ammount_to_pay ), 0.00 )
WHERE card_number = @card_number_to_pay;