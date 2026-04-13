-- Create Books Table
USE `DROP TABLE *`;
CREATE TABLE books (
  book_id INT AUTO_INCREMENT NOT NULL,
  isbn VARCHAR( 17 ) NOT NULL,
  author VARCHAR( 50 ) NOT NULL,
  title VARCHAR( 50 ) NOT NULL,
  description TEXT NULL,
  PRIMARY KEY (book_id)
);

-- Create Holds Table
USE `DROP TABLE *`;
CREATE TABLE holds (
  hold_id INT AUTO_INCREMENT NOT NULL,
  book_id INT NOT NULL,
  card_number INT NOT NULL,
  date_held DATE NOT NULL,
  PRIMARY KEY (hold_id),
  FOREIGN KEY (book_id) REFERENCES books(book_id),
  FOREIGN KEY (card_number) REFERENCES patrons(card_number)
);

-- Create Loans Table
USE `DROP TABLE *`;
CREATE TABLE loans (
  loan_id INT AUTO_INCREMENT NOT NULL,
  book_id INT NOT NULL,
  librarian_id INT NOT NULL,
  card_number INT NOT NULL,
  checkout_date DATE NOT NULL,
  due_date DATE NOT NULL,
  PRIMARY KEY (loan_id),
  FOREIGN KEY (book_id) REFERENCES books(book_id),
  FOREIGN KEY (card_number) REFERENCES patrons(card_number),
  FOREIGN KEY (librarian_id) REFERENCES librarians(librarian_id)
);

-- Create Librarians Table
USE `DROP TABLE *`;
CREATE TABLE librarians (
  librarian_id INT AUTO_INCREMENT NOT NULL,
  first_name VARCHAR( 45 ) NOT NULL,
  last_name VARCHAR( 45 ) NOT NULL,
  wage DECIMAL( 4, 2 ) NOT NULL,
  address VARCHAR( 50 ) NOT NULL,
  start_date DATE NOT NULL,
  PRIMARY KEY (librarian_id)
);

-- Create Patrons Table
USE `DROP TABLE *`;
CREATE TABLE patrons (
  card_number INT AUTO_INCREMENT NOT NULL,
  first_name VARCHAR( 45 ) NOT NULL,
  last_name VARCHAR( 45 ) NOT NULL,
  fines DECIMAL( 5, 2 ) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (card_number)
);
