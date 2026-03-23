USE `DROP TABLE *`;

CREATE TABLE `patrons` (
  `card_number` INT AUTO_INCREMENT NOT NULL,
  `first_name` VARCHAR( 45 ) NOT NULL,
  `last_name` VARCHAR( 45 ) NOT NULL,
  `fines` DECIMAL( 5, 2 ) NULL,
  PRIMARY KEY (`card_number`)
);
