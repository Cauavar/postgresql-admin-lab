# Backup and Recovery

This section focuses on PostgreSQL backup and recovery operations using native PostgreSQL tools and Windows batch automation.

## Objectives

- Understand PostgreSQL backup strategies.
- Create logical backups using `pg_dump`.
- Restore SQL backups using `psql`.
- Restore custom-format backups using `pg_restore`.
- Automate backup operations with Windows batch scripts.
- Automate database restoration.
- Validate restored databases.
- Record backup and restore operations in log files.

## Tools Used

- `pg_dump`
- `pg_restore`
- `psql`
- Windows Batch (`.bat`)
- PostgreSQL 18

## Project Structure

```text
05-backup-recovery/
├── README.md
├── docs/
│   └── backup-and-restore.md
└── scripts/
    ├── backup-company.bat
    └── restore-company.bat
Backup Formats
```
Two backup approaches were practiced.

SQL Format

A plain-text SQL backup can be created with:

pg_dump -U postgres -d company -f company_backup.sql

This format can be restored using psql.

Custom Format

A PostgreSQL custom-format backup can be created with:

pg_dump -U postgres -d company -F c -f company_backup.backup

This format can be restored using pg_restore.

Automation

The project includes Windows batch scripts for:

Creating automated backups.
Selecting the latest backup file.
Creating a test database for restoration.
Restoring the database.
Recording execution results in log files.
Detecting errors during the process.
Restore Validation

The restore process was tested using a separate database:

company_restore_test

After the restoration, the database was validated using:

\dt

and:

SELECT * FROM public.tb_product;

The restored table and its data were successfully verified.

Lessons Learned

During the implementation, a restore initially failed because the target database already contained objects from a previous restore.

The problem was identified through the restore log and resolved by performing the restoration on a clean target database.

This demonstrated the importance of validating the target environment before performing a database restore.