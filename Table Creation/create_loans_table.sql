USE `DROP TABLE *`;

CREATE TABLE `loans` (
  `loan_id` INT AUTO_INCREMENT NOT NULL,
  `book_id` INT NOT NULL,
  `librarian_id` INT NOT NULL,
  `card_number` INT NOT NULL,
  `checkout_date` DATE NOT NULL,
  `due_date` DATE NOT NULL,
  PRIMARY KEY (`loan_id`)
);
