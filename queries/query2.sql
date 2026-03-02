-- Q2: List applications where the applicant applied to a listing priced ABOVE the average listing price.
SELECT
  a.ApplicationID,
  u.name AS applicant_name,
  sl.ListingID,
  sl.listing_price
FROM Application a
JOIN User u
  ON u.UserID = a.applicant_user_id
JOIN SubleaseListing sl
  ON sl.ListingID = a.ListingID
WHERE sl.listing_price > (
  SELECT AVG(listing_price)
  FROM SubleaseListing
)
ORDER BY sl.listing_price DESC;