PRAGMA foreign_keys = ON;

-- 1) USERS

INSERT INTO User VALUES ('U1', 'Alice Johnson', 'alice@example.com', '5551112222', '2026-01-01');
INSERT INTO User VALUES ('U2', 'Bob Smith', 'bob@example.com', '5551113333', '2026-01-02');
INSERT INTO User VALUES ('U3', 'Charlie Brown', 'charlie@example.com', '5551114444', '2026-01-03');
INSERT INTO User VALUES ('U4', 'Diana Prince', 'diana@example.com', '5551115555', '2026-01-04');

-- 2) USER ROLES

INSERT INTO UserRole VALUES ('R1', 'tenant', 'Tenant role');
INSERT INTO UserRole VALUES ('R2', 'landlord', 'Landlord role');
INSERT INTO UserRole VALUES ('R3', 'applicant', 'Applicant role');

INSERT INTO UserRoleAssignment VALUES ('U1', 'R1', '2026-01-01');
INSERT INTO UserRoleAssignment VALUES ('U1', 'R3', '2026-01-01');
INSERT INTO UserRoleAssignment VALUES ('U2', 'R1', '2026-01-02');
INSERT INTO UserRoleAssignment VALUES ('U3', 'R3', '2026-01-03');
INSERT INTO UserRoleAssignment VALUES ('U4', 'R2', '2026-01-04');

-- 3) LANDLORD PROFILE

INSERT INTO LandlordProfile VALUES ('U4', 'landlord@example.com', '5559998888');

-- 4) LOOKUP TABLES

INSERT INTO UnitType VALUES ('UT1', 'apartment');
INSERT INTO UnitType VALUES ('UT2', 'studio');

INSERT INTO TenantRole VALUES ('TR1', 'primary');
INSERT INTO TenantRole VALUES ('TR2', 'roommate');

INSERT INTO ListingStatus VALUES ('LS1', 'open');
INSERT INTO ListingStatus VALUES ('LS2', 'closed');

INSERT INTO ApplicationStatus VALUES ('AS1', 'pending');
INSERT INTO ApplicationStatus VALUES ('AS2', 'approved');
INSERT INTO ApplicationStatus VALUES ('AS3', 'rejected');

INSERT INTO ContractStatus VALUES ('CS1', 'active');
INSERT INTO ContractStatus VALUES ('CS2', 'ended');

-- 5) PROPERTY + UNIT

INSERT INTO Property VALUES ('P1', 'U4', '123 Main St', 'Seattle', 'WA', '98101');

INSERT INTO Unit VALUES ('UNIT1', 'P1', '101', 2, 1.5, 'UT1');
INSERT INTO Unit VALUES ('UNIT2', 'P1', '102', 1, 1.0, 'UT2');

-- 6) LEASES

INSERT INTO Lease VALUES ('LEASE1', 'UNIT1', '2026-01-01', '2026-12-31', 1, 'active');
INSERT INTO Lease VALUES ('LEASE2', 'UNIT2', '2026-02-01', '2026-12-31', 1, 'active');

-- =========================
-- 7) TENANTS
-- =========================

INSERT INTO Tenant VALUES ('U1', 'LEASE1', 'TR1', '2026-01-01', NULL);
INSERT INTO Tenant VALUES ('U2', 'LEASE2', 'TR1', '2026-02-01', NULL);

-- =========================
-- 8) SUBLEASE LISTINGS
-- =========================

INSERT INTO SubleaseListing VALUES 
('LIST1', 'LEASE1', 'U1', '2026-06-01', '2026-08-31', 1200.00, 'LS1', '2026-05-01');

-- 9) APPLICATIONS

INSERT INTO Application VALUES 
('APP1', 'LIST1', 'U3', '2026-05-10', 'AS2', 'Interested in summer sublease');

INSERT INTO Application VALUES 
('APP2', 'LIST1', 'U1', '2026-05-12', 'AS3', 'Test rejected application');

-- 10) REVIEW

INSERT INTO Review VALUES 
('REV1', 'APP1', 'U4', '2026-05-15', 'approved', 'Looks good');

INSERT INTO Review VALUES 
('REV2', 'APP2', 'U4', '2026-05-16', 'rejected', 'Conflict of interest');

-- 11) CONTRACT

INSERT INTO SubleaseContract VALUES 
('CON1', 'APP1', '2026-06-01', '2026-08-31', 'CS1', '2026-05-20');