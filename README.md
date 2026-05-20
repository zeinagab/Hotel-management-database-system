# Hotel Management Database System

A relational database system designed using MySQL for managing hotel operations including guests, rooms, reservations, staff, suppliers, payments, and facilities.

---

## Project Overview

This project models a complete hotel management database system. It includes schema design, relationships between entities, and real data insertion to simulate a working hotel environment.

The system demonstrates:
- Relational database design
- Normalization principles
- One-to-many and many-to-many relationships
- SQL operations and data manipulation

---

## Database Schema

The database consists of the following main entities:

### Core Entities
- Hotel
- Guests
- Rooms (Room_Data, Room_Info)
- Reservations
- Payments
- Staff (Managers, Receptionists, Staff)
- Suppliers
- Facilities

### Relationship Tables (Many-to-Many)
- Used_Facilities (Guests ↔ Facilities)
- Assigned_Facilities (Staff ↔ Facilities)
- Restock_Supplier (Hotel ↔ Supplier)
- Supplied_Items (Supplier inventory)

---

## Key Features

### 1. Data Modeling
- Proper relational structure
- Foreign key constraints with CASCADE actions
- Separation of concerns between entities

### 2. Business Logic Implemented
- Room availability tracking based on reservation dates
- Payment tracking per reservation
- Supplier inventory management
- Staff and facility assignment system

### 3. SQL Operations Included

- `CREATE`, `INSERT`, `UPDATE`, `DELETE`
- `ALTER TABLE` (schema modification)
- `DROP COLUMN` operations
- Aggregation (`SUM`)
- Filtering (`WHERE`, `LIKE`, `BETWEEN`)
- Sorting (`ORDER BY`)
- Limiting results (`LIMIT`)

---

## Example Queries Included

- Calculate total payment per reservation:
```sql
SUM(Room_Charge + Extras)
```

- Find staff within a range:
```sql
WHERE Staff_Id BETWEEN 5 AND 10
```

- Search staff by name:
```sql
WHERE Staff_Name LIKE 'm%'
```

- Check expensive payments:
```sql
WHERE Room_Charge > 350
```

---

## How to Run the Project

### 1. Open MySQL
Ensure MySQL server is installed and running.

### 2. Create and load database
Run the SQL file:

```sql
source hotel_management_system.sql;
```

### 3. Verify database
Use:

```sql
SHOW TABLES;
SELECT * FROM Guests;
```

---

## Tools Used

- MySQL
- SQL (DDL & DML)
- Draw.io (ER Diagram and schema)

---

## Learning Outcomes

This project demonstrates:

- Advanced relational database design
- ERD/schema to SQL implementation
- Use of constraints and relationships
- Real-world hotel management modeling
- Data querying and manipulation techniques

---

## Contributors

- Zeina Hossam El Deen Mohamed
- sama sameh
- nada ahmed
- [Teammate Name]

---
