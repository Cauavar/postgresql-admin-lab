# PostgreSQL Admin Lab

Hands-on PostgreSQL administration project focused on security, performance, backup and recovery, maintenance, and automation.

## About the Project

This repository documents my practical learning journey with PostgreSQL through hands-on database administration exercises and real-world administrative scenarios.

The project was built to develop practical skills in PostgreSQL administration, including access control, query performance analysis, database maintenance, backup and recovery, and administrative automation.

The main database used throughout the project is `company`, with practical experiments performed on the `public.tb_product` table.

## Topics Covered

* PostgreSQL fundamentals
* Database and schema management
* SQL and data manipulation
* Query analysis with `EXPLAIN` and `EXPLAIN ANALYZE`
* Indexes and query optimization
* Users, roles, and permissions
* Database, schema, table, and sequence privileges
* `GRANT` and `REVOKE`
* Principle of least privilege
* Backup and recovery with `pg_dump` and `pg_restore`
* Restore validation
* `VACUUM` and `ANALYZE`
* Table statistics and dead tuples
* Autovacuum concepts
* Windows batch automation
* Administrative logging
* Git and GitHub workflow

## Project Structure

```text
01-foundations/
├── README.md
├── docs/
│   └── postgresql-fundamentals.md
└── sql/

02-sql/
├── README.md
├── docs/
│   └── sql-fundamentals.md
└── sql/
    └── 01-basic-operations.sql

03-query-performance/
├── README.md
├── docs/
│   └── query-performance.md
└── sql/
    └── 01-explain-analyze.sql

04-security/
├── README.md
├── docs/
│   └── access-control.md
└── sql/
    └── 01-roles-permissions.sql

05-backup-recovery/
├── README.md
├── docs/
│   └── backup-and-restore.md
└── scripts/
    ├── backup-company.bat
    └── restore-company.bat

06-maintenance/
├── docs/
│   └── vacuum-analyze.md
└── scripts/
    └── vacuum-analyze-company.bat

07-automation/
├── docs/
│   └── automation.md
└── scripts/
    └── daily-maintenance.bat

08-final-project/
├── README.md
├── docs/
│   ├── administration-plan.md
│   ├── architecture.md
│   └── performance-analysis.md
├── scripts/
└── sql/
    ├── 01-database.sql
    ├── 02-schema.sql
    ├── 03-security.sql
    ├── 04-performance.sql
    ├── 05-maintenance.sql
    └── 06-backup-recovery.sql
```

## Key Administrative Workflow

The project combines several PostgreSQL administration practices into a single workflow:

```text
PostgreSQL
    |
    +---- Security
    |       |
    |       +---- Roles
    |       +---- Permissions
    |       +---- Least Privilege
    |
    +---- Performance
    |       |
    |       +---- EXPLAIN
    |       +---- EXPLAIN ANALYZE
    |       +---- Indexes
    |
    +---- Maintenance
    |       |
    |       +---- VACUUM
    |       +---- ANALYZE
    |       +---- Table Statistics
    |
    +---- Backup & Recovery
    |       |
    |       +---- pg_dump
    |       +---- pg_restore
    |       +---- Restore Testing
    |
    +---- Automation
            |
            +---- Windows Batch Scripts
            +---- Logging
            +---- Daily Maintenance Workflow
```

## Environment

* PostgreSQL 18
* Windows
* Git Bash
* SQL
* Git
* GitHub

## Learning Approach

This project follows a hands-on approach.

Instead of focusing only on theoretical concepts, each topic is explored through practical PostgreSQL commands, scripts, documentation, execution plans, permission management, maintenance operations, backup procedures, and automation workflows.

The goal is to build practical database administration skills that can be applied to real PostgreSQL environments.
