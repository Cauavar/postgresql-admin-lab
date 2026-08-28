-- ==========================================
-- PostgreSQL Admin Lab
-- Query Performance - EXPLAIN ANALYZE
-- ==========================================

-- NOTE:
-- Execute this script while connected to the
-- "company" database.
--
-- The examples use public.tb_product.

-- ==========================================
-- 1. TABLE STATISTICS
-- ==========================================

-- Update planner statistics before analyzing
-- query performance.

ANALYZE public.tb_product;

-- ==========================================
-- 2. BASIC EXPLAIN
-- ==========================================

-- EXPLAIN shows the execution plan without
-- executing the query.

EXPLAIN
SELECT *
FROM public.tb_product
WHERE product_id = 2500;

-- ==========================================
-- 3. EXPLAIN ANALYZE
-- ==========================================

-- EXPLAIN ANALYZE executes the query and shows
-- actual execution statistics.

EXPLAIN ANALYZE
SELECT *
FROM public.tb_product
WHERE product_id = 2500;

-- ==========================================
-- 4. PRIMARY KEY INDEX
-- ==========================================

-- The primary key on product_id automatically
-- creates a unique index.

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
  AND tablename = 'tb_product';

-- ==========================================
-- 5. QUERY USING PRODUCT NAME
-- ==========================================

-- This query filters by the name column.

EXPLAIN ANALYZE
SELECT *
FROM public.tb_product
WHERE name = 'Product 2500';

-- ==========================================
-- 6. CREATE ADDITIONAL INDEX
-- ==========================================

-- Create an index on the name column.

CREATE INDEX IF NOT EXISTS idx_tb_product_name
ON public.tb_product (name);

-- ==========================================
-- 7. ANALYZE AFTER INDEX CREATION
-- ==========================================

ANALYZE public.tb_product;

-- ==========================================
-- 8. QUERY AFTER INDEX CREATION
-- ==========================================

-- Analyze the execution plan again after
-- creating the index.

EXPLAIN ANALYZE
SELECT *
FROM public.tb_product
WHERE name = 'Product 2500';

-- ==========================================
-- 9. INDEX INFORMATION
-- ==========================================

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
  AND tablename = 'tb_product'
ORDER BY indexname;

-- ==========================================
-- 10. TABLE STATISTICS
-- ==========================================

SELECT
    relname,
    n_live_tup,
    n_dead_tup,
    last_analyze,
    last_autoanalyze
FROM pg_stat_user_tables
WHERE relname = 'tb_product';

-- ==========================================
-- PERFORMANCE NOTES
-- ==========================================

-- EXPLAIN:
-- Shows the estimated execution plan.
--
-- EXPLAIN ANALYZE:
-- Executes the query and reports actual
-- execution statistics.
--
-- SEQUENTIAL SCAN:
-- PostgreSQL reads table rows sequentially.
--
-- INDEX SCAN:
-- PostgreSQL can use an index to locate
-- matching rows.
--
-- ANALYZE:
-- Updates statistics used by the planner.
--
-- IMPORTANT:
-- An index does not guarantee better performance.
-- PostgreSQL chooses the execution plan based
-- on estimated costs, table statistics,
-- selectivity, and other factors.