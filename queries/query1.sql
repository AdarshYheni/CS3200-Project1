-- Q1: Show each application with listing, lease, unit, property, applicant, and landlord.
SELECT
  a.ApplicationID,
  a.applied_at,
  ast.application_status_name AS application_status,
  u_app.name AS applicant_name,
  sl.ListingID,
  sl.available_from,
  sl.available_to,
  sl.listing_price,
  un.unit_number,
  p.address,
  u_land.name AS landlord_name
FROM Application a
JOIN ApplicationStatus ast
  ON ast.ApplicationStatusID = a.ApplicationStatusID
JOIN SubleaseListing sl
  ON sl.ListingID = a.ListingID
JOIN Lease l
  ON l.LeaseID = sl.LeaseID
JOIN Unit un
  ON un.UnitID = l.UnitID
JOIN Property p
  ON p.PropertyID = un.PropertyID
JOIN User u_app
  ON u_app.UserID = a.applicant_user_id
JOIN User u_land
  ON u_land.UserID = p.owner_user_id
ORDER BY a.applied_at;