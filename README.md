# Apartment Subleasing Marketplace Database

## Project Overview
SubletSync is a relational database system designed to manage apartment subleasing activities in a structured and consistent manner. The system models users (tenants, landlords, applicants), properties, units, leases, sublease listings, applications, reviews, and contracts. It enforces business rules such as lease validity, sublease eligibility, one application per user per listing, and one contract per approved application. The database is implemented in SQLite3 and normalized to BCNF.

---

## Project Structure

```
CS3200-Project1/
│
├── requirements.pdf
├── uml_diagram.png
├── erd.png
├── bcnf_schema.pdf
├── schema.sql
├── seed.sql
├── subletsync.db
├── queries/
│   ├── q1_three_table_join.sql
│   ├── q2_subquery.sql
│   ├── q3_group_by_having.sql
│   ├── q4_complex_criteria.sql
│   └── q5_advanced_window.sql
└── screenshots/
```

---

## Database Setup (SQLite3)

### 1) Create the Database

Run the schema file to create all tables:

```
C:\sqlite\sqlite3.exe subletsync.db < schema.sql
```

### 2) Populate with Test Data

```
C:\sqlite\sqlite3.exe subletsync.db < seed.sql
```

### 3) Verify Tables and Foreign Keys

```
C:\sqlite\sqlite3.exe subletsync.db
.tables
PRAGMA foreign_keys;
```

Foreign keys should return `1`.

---

## Running Required Queries

Each required query is stored as an individual SQL file inside the `queries/` folder.

Example execution:

```
C:\sqlite\sqlite3.exe -header -column subletsync.db < queries\q1_three_table_join.sql
```

### Query Summary

| Query | Purpose |
|-------|---------|
| Q1 | Multi-table join across applications, listings, leases, units, properties, and users |
| Q2 | Subquery comparing listing price to average listing price |
| Q3 | GROUP BY with HAVING to count applications per listing |
| Q4 | Complex search using multiple logical conditions |
| Q5 | Window function (RANK) to rank listings within properties |

---

## 🧠 Design Highlights

- Conceptual UML Class Diagram
- Logical ERD using Crow’s Foot notation
- Schema normalized to BCNF
- All foreign key constraints enforced
- Dates stored as TEXT (ISO format)
- One application per user per listing
- One contract per approved application

---

## 🛠️ Technology Stack

- SQLite 3
- SQL
- LucidChart
- GitHub
- VS Code

---

## ERD LucidChart Link

[Click Here](https://lucid.app/lucidchart/397fff67-0b5c-4162-ac23-cac4a673e91a/edit?viewport_loc=-7319%2C-791%2C5353%2C2706%2C0_0&invitationId=inv_203035a8-c467-43ed-a90d-f4fbbc5cdb2d)

---

## Assignment Components Included

- Requirements document (PDF)
- UML conceptual model (PNG)
- ERD logical model (PNG + URL)
- Relational schema with BCNF proof (PDF)
- schema.sql (DDL)
- seed.sql (test data)
- Five required queries (separate SQL files)
- Execution screenshots