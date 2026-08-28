-- ==========================================
-- PostgreSQL Admin Lab
-- Security - Roles and Permissions
-- ==========================================

-- NOTE:
-- Execute these commands with an administrative
-- PostgreSQL role, such as postgres.
--
-- The examples demonstrate role creation and
-- privilege management using the company database.

-- ==========================================
-- 1. CREATE ROLES
-- ==========================================

-- Read-only role
CREATE ROLE company_readonly NOLOGIN;

-- Read and write role
CREATE ROLE company_writer NOLOGIN;

-- Administrative role
CREATE ROLE company_admin NOLOGIN;

-- ==========================================
-- 2. DATABASE PERMISSIONS
-- ==========================================

GRANT CONNECT
ON DATABASE company
TO company_readonly;

GRANT CONNECT
ON DATABASE company
TO company_writer;

GRANT CONNECT
ON DATABASE company
TO company_admin;

-- ==========================================
-- 3. SCHEMA PERMISSIONS
-- ==========================================

GRANT USAGE
ON SCHEMA public
TO company_readonly;

GRANT USAGE
ON SCHEMA public
TO company_writer;

GRANT USAGE, CREATE
ON SCHEMA public
TO company_admin;

-- ==========================================
-- 4. TABLE PERMISSIONS
-- ==========================================

-- Read-only access
GRANT SELECT
ON TABLE public.tb_product
TO company_readonly;

-- Read and write access
GRANT SELECT, INSERT, UPDATE, DELETE
ON TABLE public.tb_product
TO company_writer;

-- Administrative access
GRANT ALL PRIVILEGES
ON TABLE public.tb_product
TO company_admin;

-- ==========================================
-- 5. SEQUENCE PERMISSIONS
-- ==========================================

-- Required by the writer role when inserting
-- records using the product ID sequence.

GRANT USAGE, SELECT
ON SEQUENCE public.product_product_id_seq
TO company_writer;

-- Administrative access to the sequence
GRANT ALL PRIVILEGES
ON SEQUENCE public.product_product_id_seq
TO company_admin;

-- ==========================================
-- 6. ROLE MEMBERSHIP EXAMPLE
-- ==========================================

-- Example of assigning a user to a role.
--
-- These commands are intentionally commented
-- to avoid creating application users automatically.
--
-- CREATE USER company_app;
-- GRANT company_writer TO company_app;

-- ==========================================
-- 7. VERIFY ROLES
-- ==========================================

SELECT
    rolname,
    rolinherit,
    rolcanlogin
FROM pg_roles
WHERE rolname IN (
    'company_readonly',
    'company_writer',
    'company_admin'
)
ORDER BY rolname;

-- ==========================================
-- 8. VERIFY TABLE PRIVILEGES
-- ==========================================

SELECT
    grantee,
    table_schema,
    table_name,
    privilege_type
FROM information_schema.role_table_grants
WHERE table_schema = 'public'
  AND table_name = 'tb_product'
ORDER BY grantee, privilege_type;

-- ==========================================
-- 9. SECURITY PRINCIPLE
-- ==========================================

-- Principle of least privilege:
--
-- company_readonly
--     -> SELECT
--
-- company_writer
--     -> SELECT, INSERT, UPDATE, DELETE
--
-- company_admin
--     -> Administrative privileges
--
-- Users should receive only the permissions
-- required for their responsibilities.