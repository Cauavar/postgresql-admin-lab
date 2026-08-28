# PostgreSQL Foundations

## Objective

This section contains the fundamental concepts and practical exercises used to understand PostgreSQL administration.

The objective is to establish the basic knowledge required for database creation, connection, schemas, tables, users, roles, and PostgreSQL system architecture.

## Topics

The foundations section covers:

- PostgreSQL architecture
- Server and instance concepts
- Databases
- Schemas
- Tables
- PostgreSQL roles and users
- Connections
- Basic SQL administration
- PostgreSQL command-line tools

## Environment

The practical environment used in this project includes:

- PostgreSQL 18
- Windows
- Git Bash
- psql
- pgAdmin
- Git
- GitHub

## Database Environment

The main database used throughout the project is:

```text
company

The default schema used by the project is:

public
PostgreSQL Architecture

The basic hierarchy used in the project can be represented as:

PostgreSQL Server
        |
        +---- Database
                  |
                  +---- Schema
                           |
                           +---- Table
Administration Tools
psql

psql is PostgreSQL's command-line client.

It allows administrators and developers to:

Connect to databases
Execute SQL commands
Inspect database objects
Manage roles and permissions
Execute administrative commands
pgAdmin

pgAdmin provides a graphical interface for managing PostgreSQL databases.

It can be used to:

Browse databases
Inspect schemas and tables
Execute SQL commands
Manage users and roles
Monitor database objects
Project Context

The concepts introduced in this section serve as the foundation for the following areas of the project:

Query performance
Security and access control
Backup and recovery
Database maintenance
Automation
Final administration project