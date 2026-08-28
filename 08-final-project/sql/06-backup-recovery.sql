-- ==========================================
-- PostgreSQL Admin Lab - Final Project
-- Backup and Recovery
-- ==========================================

-- NOTE:
-- Backup and restore are performed using the
-- PostgreSQL command-line utilities pg_dump
-- and pg_restore.
--
-- These commands are documented here as part
-- of the database administration workflow.

-- ==========================================
-- BACKUP
-- ==========================================

-- Custom-format backup:
--
-- pg_dump -U postgres -d company -F c
--     -f "C:\Backups\PostgreSQL\company.backup"

-- The custom format is suitable for use with
-- pg_restore and allows selective restoration.

-- ==========================================
-- RESTORE
-- ==========================================

-- A separate database is used for restore testing.
--
-- Example:
--
-- CREATE DATABASE company_restore_test;

-- Restore command:
--
-- pg_restore -U postgres
--     -d company_restore_test
--     "C:\Backups\PostgreSQL\company.backup"

-- ==========================================
-- RESTORE VALIDATION
-- ==========================================

-- After restoration, connect to the target
-- database and verify the restored objects.

-- Example:
--
-- \c company_restore_test
--
-- \dt
--
-- SELECT *
-- FROM public.tb_product;

-- ==========================================
-- RECOVERY TEST
-- ==========================================

-- The project validates recovery by restoring
-- a real backup into a separate database.
--
-- Source:
--     company
--
-- Target:
--     company_restore_test
--
-- The original database remains unchanged.

-- ==========================================
-- ADMINISTRATION PRINCIPLE
-- ==========================================

-- A backup is only useful if it can be restored.
--
-- Therefore, the project treats restore testing
-- as part of the backup strategy rather than
-- relying only on the existence of backup files.