-- Q5: Rank listings by price within each property (WINDOW FUNCTION).
SELECT
  p.PropertyID,
  sl.ListingID,
  sl.listing_price,
  RANK() OVER (PARTITION BY p.PropertyID ORDER BY sl.listing_price DESC) AS price_rank_within_property
FROM SubleaseListing sl
JOIN Lease l
  ON l.LeaseID = sl.LeaseID
JOIN Unit un
  ON un.UnitID = l.UnitID
JOIN Property p
  ON p.PropertyID = un.PropertyID
ORDER BY p.PropertyID, price_rank_within_property;