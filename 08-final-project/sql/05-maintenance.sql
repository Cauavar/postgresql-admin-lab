-- ==========================================
-- PostgreSQL Admin Lab - Final Project
-- Database Maintenance
-- ==========================================

-- NOTE:
-- Execute this script while connected to the
-- "company" database.

-- ==========================================
-- 1. INITIAL TABLE STATISTICS
-- ==========================================

SELECT
    relname,
    n_live_tup,
    n_dead_tup,
    last_vacuum,
    last_autovacuum,
    last_analyze,
    last_autoanalyze
FROM pg_stat_user_tables
WHERE relname = 'tb_product';

-- ==========================================
-- 2. CREATE DEAD TUPLES
-- ==========================================

-- UPDATE creates new row versions in PostgreSQL.
-- The previous versions become dead tuples.

UPDATE public.tb_product
SET price = price + 1
WHERE product_id <= 3;

-- DELETE also creates dead tuples that can
-- later be removed by VACUUM.

DELETE FROM public.tb_product
WHERE product_id = 7;

-- ==========================================
-- 3. CHECK TABLE STATISTICS
-- ==========================================

SELECT
    relname,
    n_live_tup,
    n_dead_tup,
    last_vacuum,
    last_analyze
FROM pg_stat_user_tables
WHERE relname = 'tb_product';

-- ==========================================
-- 4. VACUUM ANALYZE
-- ==========================================

VACUUM ANALYZE public.tb_product;

-- ==========================================
-- 5. VERIFY MAINTENANCE
-- ==========================================

SELECT
    relname,
    n_live_tup,
    n_dead_tup,
    last_vacuum,
    last_analyze
FROM pg_stat_user_tables
WHERE relname = 'tb_product';

-- ==========================================
-- MAINTENANCE NOTES
-- ==========================================

-- VACUUM:
-- Removes obsolete row versions that are no
-- longer visible to any active transaction.
--
-- ANALYZE:
-- Updates table statistics used by the query
-- planner.
--
-- VACUUM ANALYZE:
-- Performs both maintenance operations.
--
-- AUTOVACUUM:
-- PostgreSQL can automatically perform VACUUM
-- and ANALYZE based on configured thresholds.