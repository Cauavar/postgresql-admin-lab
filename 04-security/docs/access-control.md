# PostgreSQL Access Control

## Objective

This module documents PostgreSQL access control mechanisms, including users, roles, privileges, and the principle of least privilege.

The goal is to demonstrate how database access can be separated according to responsibilities.

## Users and Roles

PostgreSQL uses roles to manage database access.

A role can represent:

- A login user
- A group of users
- An administrative role
- A read-only role
- A role responsible for data modification

A role created with `NOLOGIN` can be used as a group role.

Example:

```sql
CREATE ROLE company_readonly NOLOGIN;
CREATE ROLE company_writer NOLOGIN;
CREATE ROLE company_admin NOLOGIN;

Users can then be granted membership in these roles.

Principle of Least Privilege

The project follows the principle of least privilege.

Each role should receive only the permissions required to perform its responsibilities.

The roles used in the project are:

Role	Purpose
company_readonly	Read data
company_writer	Read and modify data
company_admin	Administrative operations
Database Permissions

Database-level privileges control whether a role can connect to a database and perform certain database operations.

Example:

GRANT CONNECT ON DATABASE company
TO company_readonly;

The main database permissions considered in the project are:

CONNECT
CREATE
TEMPORARY
Schema Permissions

Access to the public schema is controlled separately from database access.

Read-only users require USAGE on the schema:

GRANT USAGE ON SCHEMA public
TO company_readonly;

Administrative roles may also require CREATE:

GRANT USAGE, CREATE ON SCHEMA public
TO company_admin;
Table Permissions

Table privileges define what operations a role can perform on table data.

Read-only
GRANT SELECT
ON TABLE public.tb_product
TO company_readonly;

The role can query data but cannot insert, update, or delete records.

Writer
GRANT SELECT, INSERT, UPDATE, DELETE
ON TABLE public.tb_product
TO company_writer;

The role can read and modify table data.

Administrator
GRANT ALL PRIVILEGES
ON TABLE public.tb_product
TO company_admin;

The administrative role receives broader privileges.

Sequence Permissions

The tb_product table uses a sequence to generate product identifiers.

A role that inserts records using the sequence requires appropriate sequence privileges.

Example:

GRANT USAGE, SELECT
ON SEQUENCE public.product_product_id_seq
TO company_writer;

Administrative roles can receive broader sequence privileges:

GRANT ALL PRIVILEGES
ON SEQUENCE public.product_product_id_seq
TO company_admin;
Permission Hierarchy

The access model can be summarized as:

PostgreSQL
    |
    +---- Database: company
             |
             +---- Schema: public
                     |
                     +---- Table: tb_product
                     |
                     +---- Sequence: product_product_id_seq

Permissions are applied at different levels of this hierarchy.

Default Privileges

PostgreSQL also supports default privileges.

Default privileges can define permissions automatically for objects created in the future.

Example:

ALTER DEFAULT PRIVILEGES
FOR ROLE postgres
IN SCHEMA public
GRANT SELECT ON TABLES
TO company_readonly;

This is useful in environments where new tables are created regularly.

Security Model

The project's security model is:

company_readonly
    |
    +---- CONNECT
    +---- USAGE on public
    +---- SELECT on tb_product

company_writer
    |
    +---- CONNECT
    +---- USAGE on public
    +---- SELECT
    +---- INSERT
    +---- UPDATE
    +---- DELETE
    +---- USAGE/SELECT on sequence

company_admin
    |
    +---- CONNECT
    +---- USAGE/CREATE on public
    +---- Administrative privileges
Important Concepts
Authentication

Authentication determines who is connecting to PostgreSQL.

Authorization

Authorization determines what the authenticated role is allowed to do.

GRANT

GRANT gives privileges to a role.

REVOKE

REVOKE removes privileges from a role.

Example:

REVOKE DELETE
ON TABLE public.tb_product
FROM company_writer;
Security Recommendations

The project follows these administration practices:

Avoid using the postgres superuser for applications.
Use dedicated roles for different responsibilities.
Grant only required privileges.
Avoid granting unnecessary SUPERUSER privileges.
Review permissions regularly.
Separate administrative and application access.
Use group roles to simplify permission management.
Summary

PostgreSQL access control provides multiple levels of permission management.

The project demonstrates:

Roles
Users
Database privileges
Schema privileges
Table privileges
Sequence privileges
Default privileges
GRANT
REVOKE
Principle of least privilege

These mechanisms provide a foundation for securing PostgreSQL environments.