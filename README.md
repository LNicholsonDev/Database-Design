# Relational Database Design

SQL Server database work across two components: a progression of design 
and querying exercises applied to multiple real-world scenarios, followed 
by a complete end-to-end database design project built from business 
requirements.

---

## Structure

### [SQL Code - DDL and DML](./1%20-%20SQL%20Code%20-%20DDL%20and%20DML)

Applied SQL across four distinct database scenarios:

| Scenario | Focus |
|---|---|
| Boat Tour & Fishing Company | Table design, relationships, Crow's Foot notation |
| Faculty Database | Relational schema, table joins, data retrieval |
| Local Business (Retail) | Normalization, business rules, table structure |
| Academic Course Catalog | Table design from real course data |

Progressive query work covering:
- **Assign 2** — Data retrieval and basic querying
- **Assign 3** — Subqueries and CTEs (Common Table Expressions)
- **Assign 4** — Action queries, updates, and views
- **Assign 5** — T-SQL scripts, variables, and batch processing
- **Stored Procedures** — Parameterized procedures and group exercises

---

### [Final Project - Design a Database](./2%20-%20Final%20Project%20-%20Design%20a%20Database)

Full database design lifecycle for an academic course outcomes tracking 
system (`zCourseOutcomes`). Models the relationships between academic 
divisions, programs, program chairs, courses, and learning outcomes 
within a college structure.

**Part 1 - UML Design**  
Conceptual and logical database design using UML/ER modeling prior to 
implementation.

**Part 2 - Implementation**  
Schema includes six normalized tables with surrogate primary keys and 
two junction tables handling many-to-many relationships:

- `Division` → `Program` (divisions contain programs)
- `Program` → `Course` (programs contain courses)
- `ProgramChairMap` (junction: programs ↔ program chairs)
- `CourseOutcome` (junction: courses ↔ learning outcomes)
- `Outcome` (reusable outcome descriptions linked to multiple courses)

Full implementation includes DDL schema creation, stored procedures, 
query development, and a finalized database diagram in SQL Server.

---

## Stack

![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=flat&logo=microsoft-sql-server&logoColor=white)
![T-SQL](https://img.shields.io/badge/T--SQL-CC2927?style=flat&logo=microsoft-sql-server&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=flat&logo=postgresql&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white)
