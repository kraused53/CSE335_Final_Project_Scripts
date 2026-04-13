USE `DROP TABLE *`;
CREATE TABLE holds (
  hold_id INT AUTO_INCREMENT NOT NULL,
  book_id INT NOT NULL,
  card_number INT NOT NULL,
  date_held DATE NOT NULL,
  PRIMARY KEY (`hold_id`)
);
