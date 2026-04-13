USE `DROP TABLE *`;
CREATE TABLE librarians (
  librarian_id INT AUTO_INCREMENT NOT NULL,
  first_name VARCHAR( 45 ) NOT NULL,
  last_name VARCHAR( 45 ) NOT NULL,
  wage DECIMAL( 4, 2 ) NOT NULL,
  address VARCHAR( 50 ) NOT NULL,
  start_date DATE NOT NULL,
  PRIMARY KEY (`librarian_id`)
);
