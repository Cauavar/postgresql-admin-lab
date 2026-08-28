-- ==========================================
-- PostgreSQL Admin Lab - Final Project
-- Security and Access Control
-- ==========================================

-- NOTE:
-- The following roles are examples of how access
-- can be separated according to responsibilities.
--
-- Execute these commands with an administrative role.

-- ==========================================
-- CREATE ROLES
-- ==========================================

CREATE ROLE company_readonly NOLOGIN;

CREATE ROLE company_writer NOLOGIN;

CREATE ROLE company_admin NOLOGIN;

-- ==========================================
-- DATABASE PERMISSIONS
-- ==========================================

GRANT CONNECT ON DATABASE company
TO company_readonly;

GRANT CONNECT ON DATABASE company
TO company_writer;

GRANT CONNECT ON DATABASE company
TO company_admin;

-- ==========================================
-- SCHEMA PERMISSIONS
-- ==========================================

GRANT USAGE ON SCHEMA public
TO company_readonly;

GRANT USAGE ON SCHEMA public
TO company_writer;

GRANT USAGE, CREATE ON SCHEMA public
TO company_admin;

-- ==========================================
-- TABLE PERMISSIONS
-- ==========================================

-- Read-only role
GRANT SELECT
ON TABLE public.tb_product
TO company_readonly;

-- Writer role
GRANT SELECT, INSERT, UPDATE, DELETE
ON TABLE public.tb_product
TO company_writer;

-- Administrative role
GRANT ALL PRIVILEGES
ON TABLE public.tb_product
TO company_admin;

-- ==========================================
-- SEQUENCE PERMISSIONS
-- ==========================================

GRANT USAGE, SELECT
ON SEQUENCE public.product_product_id_seq
TO company_writer;

GRANT ALL PRIVILEGES
ON SEQUENCE public.product_product_id_seq
TO company_admin;

-- ==========================================
-- DEFAULT PRIVILEGE EXAMPLE
-- ==========================================

-- Future tables created by the administrative role
-- can have controlled default permissions.

ALTER DEFAULT PRIVILEGES
FOR ROLE postgres
IN SCHEMA public
GRANT SELECT ON TABLES TO company_readonly;

ALTER DEFAULT PRIVILEGES
FOR ROLE postgres
IN SCHEMA public
GRANT SELECT, INSERT, UPDATE, DELETE
ON TABLES TO company_writer;

-- ==========================================
-- SECURITY PRINCIPLE
-- ==========================================

-- The project follows the principle of least privilege:
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
-- Application users should receive only the
-- permissions required for their responsibilities.