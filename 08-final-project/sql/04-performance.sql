-- ==========================================
-- PostgreSQL Admin Lab - Final Project
-- Query Performance and Indexes
-- ==========================================

-- NOTE:
-- Execute this script while connected to the
-- "company" database.

-- ==========================================
-- 1. ANALYZE TABLE
-- ==========================================

ANALYZE public.tb_product;

-- ==========================================
-- 2. BASELINE QUERY
-- ==========================================

-- Example query used to investigate the
-- execution plan.

EXPLAIN ANALYZE
SELECT *
FROM public.tb_product
WHERE product_id = 2500;

-- ==========================================
-- 3. INDEX
-- ==========================================

-- The primary key already creates an index
-- on product_id.
--
-- This project therefore uses another column
-- to demonstrate an additional index.

CREATE INDEX IF NOT EXISTS idx_tb_product_name
ON public.tb_product (name);

-- ==========================================
-- 4. QUERY USING THE INDEXED COLUMN
-- ==========================================

EXPLAIN ANALYZE
SELECT *
FROM public.tb_product
WHERE name = 'Product 2500';

-- ==========================================
-- 5. INDEX INFORMATION
-- ==========================================

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
  AND tablename = 'tb_product';

-- ==========================================
-- 6. TABLE STATISTICS
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
-- Shows the query execution plan.
--
-- EXPLAIN ANALYZE:
-- Executes the query and reports actual
-- execution statistics.
--
-- Sequential Scan:
-- PostgreSQL reads the table sequentially.
--
-- Index Scan:
-- PostgreSQL can use an index to locate
-- matching rows more efficiently.
--
-- IMPORTANT:
-- An index does not automatically guarantee
-- better performance. PostgreSQL chooses the
-- execution plan based on cost estimates,
-- table statistics, selectivity, and other
-- factors.