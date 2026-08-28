# PostgreSQL Administration Final Project

## Overview

This project is a practical PostgreSQL administration environment designed to demonstrate database administration concepts through real hands-on experiments.

The project covers database structure, access control, query performance, maintenance, backup and recovery, and administrative automation.

The objective is to demonstrate not only SQL knowledge, but also practical database administration skills and the ability to document and reproduce administrative procedures.

## Environment

- PostgreSQL 18
- Windows
- Git Bash
- SQL
- Windows Batch
- Git
- GitHub

## Database

The project uses a PostgreSQL database named:

```text
company

Main schema:

public

Main table:

public.tb_product

The database contains more than 5,000 product records, allowing performance and maintenance experiments to be performed on a non-trivial dataset.

Administration Areas
Security

The project implements role-based access control using PostgreSQL roles.

Examples include:

company_readonly
company_writer
company_admin

The permissions follow the principle of least privilege.

Query Performance

The project investigates PostgreSQL query execution using:

EXPLAIN
EXPLAIN ANALYZE
Sequential Scans
Indexes
Query planner statistics
pg_stat_user_tables
pg_indexes

An additional index was created on the name column to investigate indexed access.

Database Maintenance

Maintenance experiments include:

VACUUM
ANALYZE
VACUUM ANALYZE
Dead tuple monitoring
Table statistics
Autovacuum concepts

The project demonstrates how UPDATE and DELETE operations can generate dead tuples and how VACUUM ANALYZE can be used as part of routine maintenance.

Backup and Recovery

Backup and recovery procedures use:

pg_dump
PostgreSQL custom-format backups
pg_restore

The recovery process was tested by restoring a real backup into a separate database:

company_restore_test

This ensures that the backup process is not only creating files, but also producing recoverable database backups.

Automation

Administrative tasks are automated using Windows Batch scripts.

The automation workflow includes:

daily-maintenance.bat
        |
        +----> backup-company.bat
        |
        +----> vacuum-analyze-company.bat

The scripts also include logging and basic error handling.

Project Structure
08-final-project/
│
├── README.md
│
├── docs/
│   ├── administration-plan.md
│   ├── architecture.md
│   └── performance-analysis.md
│
├── scripts/
│
└── sql/
    ├── 01-database.sql
    ├── 02-schema.sql
    ├── 03-security.sql
    ├── 04-performance.sql
    ├── 05-maintenance.sql
    └── 06-backup-recovery.sql
Practical Workflow

The project follows a practical administration workflow:

Database Setup
      |
      v
Schema & Tables
      |
      v
Security & Permissions
      |
      v
Performance Analysis
      |
      v
Maintenance
      |
      v
Backup
      |
      v
Recovery Testing
      |
      v
Automation
Key Skills Demonstrated

This project demonstrates practical experience with:

PostgreSQL administration
SQL
Database and schema management
Role-based access control
Permissions and privileges
Principle of least privilege
Query execution plans
Index management
Database statistics
VACUUM and ANALYZE
Backup and recovery
PostgreSQL command-line tools
Windows automation
Batch scripting
Logging
Git and GitHub
Technical documentation
Lessons Learned

The project reinforced several important database administration principles:

Database security should follow the principle of least privilege.
Query optimization should be based on execution-plan analysis rather than assumptions.
Indexes should be created according to actual query requirements.
Database statistics are important for the PostgreSQL query planner.
Routine maintenance helps keep database statistics and storage usage healthy.
Backups should be tested through actual recovery procedures.
Administrative tasks can be automated to improve reliability and consistency.
Future Improvements

Possible future improvements include:

Linux shell-script equivalents
Windows Task Scheduler integration
Backup retention policies
Automated backup validation
Log rotation
Monitoring and alerting
Additional performance experiments
PostgreSQL configuration tuning
Containerized PostgreSQL environment
More complex database schemas
Status

🚧 This project is actively evolving as new PostgreSQL administration concepts and experiments are added.