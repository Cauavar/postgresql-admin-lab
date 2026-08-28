# PostgreSQL Security

## Objective

This module covers PostgreSQL access control and security concepts.

The main goal is to understand how users, roles, and privileges can be
organized to control access to databases and database objects.

## Topics

- PostgreSQL roles
- PostgreSQL users
- LOGIN and NOLOGIN
- Database privileges
- Schema privileges
- Table privileges
- Sequence privileges
- GRANT
- REVOKE
- ALTER DEFAULT PRIVILEGES
- Principle of least privilege

## Security Model

The project uses separate roles according to responsibilities:

```text
company_readonly
        |
        +----> SELECT

company_writer
        |
        +----> SELECT
        +----> INSERT
        +----> UPDATE
        +----> DELETE

company_admin
        |
        +----> Administrative privileges
Database Objects

The security experiments are performed on:

Database:
    company

Schema:
    public

Table:
    public.tb_product

Sequence:
    public.product_product_id_seq
Main Commands

The module demonstrates:

CREATE ROLE
CREATE USER
GRANT
REVOKE
ALTER ROLE
ALTER DEFAULT PRIVILEGES
Principle of Least Privilege

Users and roles should receive only the permissions required to perform
their responsibilities.

For example:

Read-only users should receive SELECT.
Application users that modify products should receive only the required
DML privileges.
Administrative privileges should be restricted to administrative roles.
Important Note

The security scripts should be executed using an administrative PostgreSQL
account.

The postgres account is used only for laboratory administration and
should not be used as the application account in a production environment.