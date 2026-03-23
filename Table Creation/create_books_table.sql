USE `DROP TABLE *`;

CREATE TABLE `books` (
  `book_id` INT AUTO_INCREMENT NOT NULL,
  `isbn` VARCHAR( 17 ) NOT NULL,
  `author` VARCHAR( 50 ) NOT NULL,
  `title` VARCHAR( 50 ) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`book_id`)
);
