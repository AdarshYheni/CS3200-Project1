-- Q3: Show listings with at least 2 applications (GROUP BY + HAVING).
SELECT
  sl.ListingID,
  COUNT(*) AS application_count
FROM Application a
JOIN SubleaseListing sl
  ON sl.ListingID = a.ListingID
GROUP BY sl.ListingID
HAVING COUNT(*) >= 2
ORDER BY application_count DESC;