-- Q4: Find OPEN listings that match multiple conditions:
-- (price <= 1500 AND availability overlaps summer) AND lease allows subleasing.
SELECT
  sl.ListingID,
  sl.available_from,
  sl.available_to,
  sl.listing_price,
  ls.listing_status_name AS listing_status,
  l.sublease_allowed,
  p.city,
  p.state,
  un.unit_number
FROM SubleaseListing sl
JOIN ListingStatus ls
  ON ls.ListingStatusID = sl.ListingStatusID
JOIN Lease l
  ON l.LeaseID = sl.LeaseID
JOIN Unit un
  ON un.UnitID = l.UnitID
JOIN Property p
  ON p.PropertyID = un.PropertyID
WHERE
  ls.listing_status_name = 'open'
  AND l.sublease_allowed = 1
  AND sl.listing_price <= 1500
  AND (
    sl.available_from <= '2026-08-31'
    AND sl.available_to >= '2026-06-01'
  )
ORDER BY sl.listing_price ASC, sl.available_from;