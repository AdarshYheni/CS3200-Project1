PRAGMA foreign_keys = ON;

-- 1) CORE IDENTITY TABLES

CREATE TABLE IF NOT EXISTS User (
  UserID TEXT PRIMARY KEY CHECK (UserID LIKE 'U%'),
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE CHECK (email LIKE '%@%'),
  phone_number TEXT,
  account_created_at TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS UserRole (
  RoleID TEXT PRIMARY KEY,
  role_name TEXT NOT NULL UNIQUE,
  role_description TEXT
);

CREATE TABLE IF NOT EXISTS UserRoleAssignment (
  UserID TEXT NOT NULL,
  RoleID TEXT NOT NULL,
  assigned_at TEXT NOT NULL,
  PRIMARY KEY (UserID, RoleID),
  FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (RoleID) REFERENCES UserRole(RoleID) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS LandlordProfile (
  UserID TEXT PRIMARY KEY,
  contact_email TEXT,
  contact_phone TEXT,
  FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 2) PROPERTY / UNIT TABLES

CREATE TABLE IF NOT EXISTS Property (
  PropertyID TEXT PRIMARY KEY,
  owner_user_id TEXT NOT NULL,
  address TEXT NOT NULL,
  city TEXT NOT NULL,
  state TEXT NOT NULL,
  zip_code TEXT NOT NULL,
  FOREIGN KEY (owner_user_id) REFERENCES User(UserID) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS UnitType (
  UnitTypeID TEXT PRIMARY KEY,
  unit_type_name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Unit (
  UnitID TEXT PRIMARY KEY,
  PropertyID TEXT NOT NULL,
  unit_number TEXT NOT NULL,
  bedrooms INTEGER NOT NULL CHECK (bedrooms >= 0),
  bathrooms REAL NOT NULL CHECK (bathrooms >= 0),
  UnitTypeID TEXT NOT NULL,
  UNIQUE (PropertyID, unit_number),
  FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (UnitTypeID) REFERENCES UnitType(UnitTypeID) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 3) LEASE / TENANCY TABLES

CREATE TABLE IF NOT EXISTS Lease (
  LeaseID TEXT PRIMARY KEY,
  UnitID TEXT NOT NULL,
  lease_start_date TEXT NOT NULL,
  lease_end_date TEXT NOT NULL,
  sublease_allowed INTEGER NOT NULL CHECK (sublease_allowed IN (0, 1)),
  lease_status TEXT NOT NULL CHECK (lease_status IN ('active', 'ended')),
  FOREIGN KEY (UnitID) REFERENCES Unit(UnitID) ON DELETE RESTRICT ON UPDATE CASCADE,
  CHECK (lease_start_date <= lease_end_date)
);

CREATE TABLE IF NOT EXISTS TenantRole (
  TenantRoleID TEXT PRIMARY KEY,
  tenant_role_name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Tenant (
  UserID TEXT NOT NULL,
  LeaseID TEXT NOT NULL,
  TenantRoleID TEXT NOT NULL,
  move_in_date TEXT NOT NULL,
  move_out_date TEXT,
  PRIMARY KEY (UserID, LeaseID),
  FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (LeaseID) REFERENCES Lease(LeaseID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (TenantRoleID) REFERENCES TenantRole(TenantRoleID) ON DELETE RESTRICT ON UPDATE CASCADE,
  CHECK (move_out_date IS NULL OR move_in_date <= move_out_date)
);

-- 4) LISTINGS / APPLICATIONS

CREATE TABLE IF NOT EXISTS ListingStatus (
  ListingStatusID TEXT PRIMARY KEY,
  listing_status_name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS SubleaseListing (
  ListingID TEXT PRIMARY KEY,
  LeaseID TEXT NOT NULL,
  created_by_user_id TEXT NOT NULL,
  available_from TEXT NOT NULL,
  available_to TEXT NOT NULL,
  listing_price REAL NOT NULL CHECK (listing_price >= 0),
  ListingStatusID TEXT NOT NULL,
  listing_created_at TEXT NOT NULL,
  FOREIGN KEY (LeaseID) REFERENCES Lease(LeaseID) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (created_by_user_id) REFERENCES User(UserID) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (ListingStatusID) REFERENCES ListingStatus(ListingStatusID) ON DELETE RESTRICT ON UPDATE CASCADE,
  CHECK (available_from <= available_to)
);

CREATE TABLE IF NOT EXISTS ApplicationStatus (
  ApplicationStatusID TEXT PRIMARY KEY,
  application_status_name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Application (
  ApplicationID TEXT PRIMARY KEY,
  ListingID TEXT NOT NULL,
  applicant_user_id TEXT NOT NULL,
  applied_at TEXT NOT NULL,
  ApplicationStatusID TEXT NOT NULL,
  message TEXT,
  UNIQUE (ListingID, applicant_user_id),
  FOREIGN KEY (ListingID) REFERENCES SubleaseListing(ListingID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (applicant_user_id) REFERENCES User(UserID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (ApplicationStatusID) REFERENCES ApplicationStatus(ApplicationStatusID) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 5) REVIEW / CONTRACT TABLES

CREATE TABLE IF NOT EXISTS Review (
  ReviewID TEXT PRIMARY KEY,
  ApplicationID TEXT NOT NULL UNIQUE,
  reviewer_user_id TEXT NOT NULL,
  reviewed_at TEXT NOT NULL,
  decision TEXT NOT NULL CHECK (decision IN ('approved', 'rejected')),
  review_notes TEXT,
  FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (reviewer_user_id) REFERENCES User(UserID) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS ContractStatus (
  ContractStatusID TEXT PRIMARY KEY,
  contract_status_name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS SubleaseContract (
  ContractID TEXT PRIMARY KEY,
  ApplicationID TEXT NOT NULL UNIQUE,
  start_date TEXT NOT NULL,
  end_date TEXT NOT NULL,
  ContractStatusID TEXT NOT NULL,
  created_at TEXT NOT NULL,
  FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (ContractStatusID) REFERENCES ContractStatus(ContractStatusID) ON DELETE RESTRICT ON UPDATE CASCADE,
  CHECK (start_date <= end_date)
);
