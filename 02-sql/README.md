# SQL Fundamentals

## Objective

This section contains the SQL concepts and practical operations used throughout the PostgreSQL administration laboratory.

The objective is to practice the commands required to create, manipulate, query, and manage data in PostgreSQL.

## Topics

The SQL section covers:

- DDL
- DML
- SELECT queries
- INSERT
- UPDATE
- DELETE
- Constraints
- Sequences
- Filtering
- Ordering
- Basic data manipulation
- PostgreSQL-specific SQL features

## SQL Categories

### DDL — Data Definition Language

DDL commands are used to define and modify database structures.

Examples:

```sql
CREATE DATABASE
CREATE SCHEMA
CREATE TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
DML — Data Manipulation Language

DML commands are used to manipulate data stored in tables.

Examples:

INSERT
UPDATE
DELETE
DQL — Data Query Language

Queries are used to retrieve data from the database.

The main command is:

SELECT
Main Table

The practical examples in this section use the project database:

company

and the main table:

public.tb_product

The table contains:

Product ID
Product name
Product price
Basic Operations

The following operations are practiced in this section:

Insert data
INSERT INTO public.tb_product (name, price)
VALUES ('Keyboard', 110.00);
Query data
SELECT *
FROM public.tb_product;
Filter data
SELECT *
FROM public.tb_product
WHERE price >= 100;
Update data
UPDATE public.tb_product
SET price = 120.00
WHERE product_id = 1;
Delete data
DELETE FROM public.tb_product
WHERE product_id = 1;
Constraints

Constraints are used to enforce data integrity.

The project uses examples such as:

PRIMARY KEY
NOT NULL
CHECK

For example:

CONSTRAINT products_pkey PRIMARY KEY (product_id)

and:

CONSTRAINT products_price_positive CHECK (price >= 0)
Sequences

PostgreSQL sequences can be used to generate numeric identifiers.

The project uses:

public.product_product_id_seq

The sequence is associated with the product_id column.

Example:

nextval('public.product_product_id_seq')

This allows new product identifiers to be generated automatically.

Relationship With Database Administration

SQL is the foundation for the administration operations performed in the following sections.

SQL
 |
 +---- Data Definition
 |
 +---- Data Manipulation
 |
 +---- Queries
 |
 +---- Constraints
 |
 +---- Sequences
 |
 v
Database Administration

The SQL knowledge developed here is later applied to:

Query performance analysis
Security and permissions
Maintenance
Backup and recovery
Automation
Final PostgreSQL administration project
Practical Environment

The SQL exercises are executed using:

Database: company
Schema: public
Main table: tb_product
DBMS: PostgreSQL 18.4
Client: psql