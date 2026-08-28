# PostgreSQL Administration Plan

## Objective

This administration plan defines the main procedures used to maintain, secure, monitor, and recover the PostgreSQL environment used in this project.

The plan is based on practical administration experiments performed on the `company` database.

## Environment

- PostgreSQL 18
- Database: `company`
- Schema: `public`
- Operating System: Windows
- Administrative tools: PostgreSQL CLI, Git Bash and Windows Batch

## Security

Database access should follow the principle of least privilege.

The project separates responsibilities using PostgreSQL roles:

| Role | Responsibility |
|---|---|
| `company_readonly` | Read-only access |
| `company_writer` | Data manipulation |
| `company_admin` | Administrative operations |

Permissions are granted according to the responsibilities of each role.

## Backup Strategy

The database is backed up using PostgreSQL custom-format backups.

The backup process uses:

```text
pg_dump
   |
   v
Custom-format backup
   |
   v
C:\Backups\PostgreSQL

Backup files are generated with timestamps to make individual backup versions identifiable.

Recovery Strategy

Backups should not be considered reliable until they have been successfully restored.

The project validates recovery by restoring backups into a separate database:

company
   |
   | pg_dump
   v
backup file
   |
   | pg_restore
   v
company_restore_test

The original company database is not used as the restore target during testing.

Maintenance

Routine maintenance includes:

VACUUM
ANALYZE
VACUUM ANALYZE
Monitoring dead tuples
Monitoring table statistics
Understanding autovacuum behavior

Maintenance activities help PostgreSQL maintain efficient storage usage and accurate planner statistics.

Performance Monitoring

Query performance is investigated using:

EXPLAIN
EXPLAIN ANALYZE
PostgreSQL indexes
pg_stat_user_tables
pg_indexes

Performance investigations should begin with measurement rather than assumptions.

The general process is:

Identify query
      |
      v
EXPLAIN ANALYZE
      |
      v
Analyze execution plan
      |
      v
Identify bottleneck
      |
      v
Apply optimization
      |
      v
Measure again
Automation

Recurring administrative tasks are automated using Windows Batch scripts.

The current automation performs:

Database backup
VACUUM ANALYZE

The main automation script is:

daily-maintenance.bat

It coordinates the existing backup and maintenance scripts.

Logging

Administrative operations generate logs containing information such as:

Execution date and time
Operation performed
Database involved
Backup file
Success or failure status
PostgreSQL command output

Logs are stored outside the Git repository and excluded through .gitignore.

Failure Handling

Administrative automation should stop when a critical operation fails.

For example:

Backup
  |
  +---- FAILED ---> Stop
  |
  +---- SUCCESS
          |
          v
      Maintenance

This prevents subsequent operations from executing when an important prerequisite has failed.

Operational Principles

The administration workflow follows these principles:

Security

Use least privilege and separate administrative responsibilities.

Reliability

Automate repetitive operations and record their results.

Recoverability

Regularly test whether backups can actually be restored.

Performance

Use execution-plan analysis and measurements before applying optimizations.

Maintainability

Keep scripts, SQL files, documentation, and logs organized by responsibility.

Reproducibility

Administrative procedures should be documented so they can be reproduced in another environment.

Future Improvements

Future versions of the project may include:

Windows Task Scheduler
Linux shell automation
Backup retention policies
Automated restore validation
Log rotation
Monitoring and alerting
PostgreSQL configuration management
Additional performance monitoring
More complex database environments