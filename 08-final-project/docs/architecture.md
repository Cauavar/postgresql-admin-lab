# Database Architecture

## Overview

This project uses PostgreSQL as the database management system for a small company management environment.

The database administration project focuses on security, performance, backup and recovery, maintenance, and automation.

## Database

The main database used in the project is:

```text
company
Schema

The project uses the default PostgreSQL schema:

public
Main Table

The main table used for the administration experiments is:

public.tb_product

The table contains product information such as:

Product ID
Product name
Product price
Administration Areas

The project is organized around the following administration areas:

Security
PostgreSQL users
Roles
Database permissions
Schema permissions
Table permissions
Sequence permissions
Principle of least privilege
Performance
EXPLAIN
EXPLAIN ANALYZE
Sequential scans
Indexes
Query optimization
Backup and Recovery
pg_dump
Custom-format backups
pg_restore
Restore testing
Backup validation
Maintenance
VACUUM
ANALYZE
VACUUM ANALYZE
Table statistics
Dead tuples
Autovacuum concepts
Automation

Administrative operations are automated using Windows batch scripts.

The automation workflow includes:

daily-maintenance.bat
        |
        +----> backup-company.bat
        |
        +----> vacuum-analyze-company.bat
Architecture Diagram
                    PostgreSQL Server
                           |
                           v
                       company
                           |
                           v
                         public
                           |
                           v
                      tb_product
                           |
          +----------------+----------------+
          |                |                |
          v                v                v
       Security        Performance     Maintenance
          |                |                |
       Roles          EXPLAIN/INDEX      VACUUM
     Permissions       Optimization      ANALYZE
          |                |                |
          +----------------+----------------+
                           |
                           v
                    Backup & Recovery
                           |
                    +------+------+
                    |             |
                 pg_dump       pg_restore
                    |
                    v
                 Automation
                    |
              daily-maintenance
Environment

The practical environment used during development includes:

PostgreSQL 18
Windows
Git Bash
SQL
Git
GitHub