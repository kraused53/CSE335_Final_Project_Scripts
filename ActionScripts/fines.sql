SELECT 
    p.card_number,
    CONCAT(p.first_name, ' ', p.last_name) AS PatronName,
    p.fines AS FineAmount
FROM patrons p;