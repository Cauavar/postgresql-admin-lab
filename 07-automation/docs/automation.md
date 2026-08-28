# PostgreSQL Automation

## Objective

This directory contains automation scripts created to simplify recurring PostgreSQL administration tasks.

The main goal is to execute database backup and maintenance operations through a single script.

## Automation Workflow

The `daily-maintenance.bat` script orchestrates two existing administrative tasks:

1. Database backup
2. VACUUM ANALYZE

The execution flow is:

```text
daily-maintenance.bat
        |
        +----> backup-company.bat
        |          |
        |          +----> pg_dump
        |
        +----> vacuum-analyze-company.bat
                   |
                   +----> VACUUM ANALYZE
```
Scripts
daily-maintenance.bat

Main automation script responsible for coordinating the backup and maintenance operations.

It calls the other administrative scripts using relative paths.

backup-company.bat

Creates a PostgreSQL custom-format backup using pg_dump.

The backup file is generated with a timestamp and stored in:

C:\Backups\PostgreSQL
vacuum-analyze-company.bat

Executes:

VACUUM ANALYZE;

The operation helps maintain table statistics and reclaim storage from obsolete row versions.

Relative Paths

The automation script uses %~dp0 to identify its own directory.

Example:

set "BACKUP_SCRIPT=%~dp0..\..\05-backup-recovery\scripts\backup-company.bat"

This avoids hardcoding the complete project path.

As a result, the project can be cloned to another directory without requiring the script paths to be manually changed.

CALL Command

The CALL command is used to execute another .bat file:

call "%BACKUP_SCRIPT%"

This allows the main automation script to continue executing after the called script finishes.

Error Handling

The automation checks the exit status of each operation using %ERRORLEVEL%.

Example:

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Backup failed.
    exit /b 1
)

If the backup fails, the automation stops instead of continuing to the maintenance operation.

This prevents the process from silently ignoring a failed backup.

Execution

The automation can be executed from the project root with:

cmd.exe /c "07-automation\scripts\daily-maintenance.bat"
Expected Result

A successful execution should perform the following operations:

1. Start database backup
2. Complete database backup
3. Start VACUUM ANALYZE
4. Complete VACUUM ANALYZE
5. Finish the automation successfully

The individual scripts also maintain their own logs.

Example

Example successful execution:

==========================================
PostgreSQL Daily Maintenance
Started: 28/08/2026 12:14:32
==========================================

[1/2] Starting database backup...
Backup completed successfully.

[2/2] Starting VACUUM ANALYZE...
VACUUM ANALYZE completed successfully.

==========================================
Daily maintenance completed successfully.
Finished: 28/08/2026 12:14:37
==========================================
Future Improvements

Possible improvements for this automation include:

Windows Task Scheduler integration
Automatic log rotation
Backup retention policies
Failure notifications
Additional maintenance operations
Centralized logging
Linux shell script equivalent