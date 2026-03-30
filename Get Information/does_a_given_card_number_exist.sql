SELECT CASE
  WHEN EXISTS (
    SELECT 1
    FROM `DROP TABLE *`.patrons
    WHERE card_number = 0
  )
  THEN 1
  ELSE 0
END AS existing_patron;