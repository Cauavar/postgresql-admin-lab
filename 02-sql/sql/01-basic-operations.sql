-- ==========================================
-- PostgreSQL Admin Lab
-- SQL Fundamentals - Basic Operations
-- ==========================================

-- NOTE:
-- Execute this script while connected to the
-- "company" database.
--
-- The statements below demonstrate basic SQL
-- operations without modifying existing data.

-- ==========================================
-- 1. DATABASE INFORMATION
-- ==========================================

SELECT current_database();

SELECT current_user;

-- ==========================================
-- 2. SELECT
-- ==========================================

-- Retrieve all products.
SELECT *
FROM public.tb_product;

-- Retrieve specific columns.
SELECT
    product_id,
    name,
    price
FROM public.tb_product;

-- ==========================================
-- 3. FILTERING
-- ==========================================

-- Products with price greater than or equal to 100.
SELECT
    product_id,
    name,
    price
FROM public.tb_product
WHERE price >= 100;

-- ==========================================
-- 4. ORDERING
-- ==========================================

-- Products ordered by price.
SELECT
    product_id,
    name,
    price
FROM public.tb_product
ORDER BY price DESC;

-- ==========================================
-- 5. INSERT
-- ==========================================

-- Example only.
--
-- This statement is intentionally commented out
-- to prevent unintended changes to the laboratory
-- database.
--
-- INSERT INTO public.tb_product (name, price)
-- VALUES ('Example Product', 100.00);

-- ==========================================
-- 6. UPDATE
-- ==========================================

-- Example only.
--
-- The WHERE clause limits which record is changed.
--
-- UPDATE public.tb_product
-- SET price = 120.00
-- WHERE product_id = 1;

-- ==========================================
-- 7. DELETE
-- ==========================================

-- Example only.
--
-- DELETE FROM public.tb_product
-- WHERE product_id = 1;

-- ==========================================
-- 8. CONSTRAINT VALIDATION
-- ==========================================

-- The table contains the following constraints:
--
-- PRIMARY KEY:
--     product_id
--
-- NOT NULL:
--     name
--     price
--
-- CHECK:
--     name <> ''
--     price >= 0

SELECT
    conname,
    contype
FROM pg_constraint
WHERE conrelid = 'public.tb_product'::regclass;

-- ==========================================
-- 9. SEQUENCE
-- ==========================================

-- Inspect the sequence used by product_id.

SELECT
    schemaname,
    sequencename
FROM pg_sequences
WHERE schemaname = 'public'
  AND sequencename = 'product_product_id_seq';

-- ==========================================
-- 10. TABLE INFORMATION
-- ==========================================

SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'tb_product'
ORDER BY ordinal_position;

-- ==========================================
-- SQL FUNDAMENTALS SUMMARY
-- ==========================================

-- SELECT:
--     Retrieves data.
--
-- INSERT:
--     Adds data.
--
-- UPDATE:
--     Modifies data.
--
-- DELETE:
--     Removes data.
--
-- WHERE:
--     Filters records.
--
-- ORDER BY:
--     Orders query results.
--
-- CONSTRAINTS:
--     Protect data integrity.
--
-- SEQUENCE:
--     Generates numeric identifiers.