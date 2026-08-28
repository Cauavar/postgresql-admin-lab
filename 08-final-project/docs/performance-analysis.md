# Query Performance Analysis

## Objective

This document records the performance analysis experiments performed on the `company` database.

The objective is to understand how PostgreSQL executes queries, how table statistics influence the query planner, and how indexes can improve data access.

## Environment

- PostgreSQL 18
- Database: `company`
- Schema: `public`
- Main table: `public.tb_product`

## Table Dataset

The `tb_product` table contains approximately 5,000+ rows.

The relatively large dataset makes it possible to observe different query execution strategies.

## EXPLAIN ANALYZE

`EXPLAIN ANALYZE` was used to execute queries and inspect the actual execution plan.

Example:

```sql
EXPLAIN ANALYZE
SELECT *
FROM public.tb_product
WHERE product_id = 2500;

The primary key on product_id provides an index that PostgreSQL can use when accessing a specific product.

Additional Index

An additional index was created on the name column:

CREATE INDEX IF NOT EXISTS idx_tb_product_name
ON public.tb_product (name);

The purpose of this index is to demonstrate how an index can be used for searches based on a non-primary-key column.

Indexed Query

The following query was used to analyze access through the name column:

EXPLAIN ANALYZE
SELECT *
FROM public.tb_product
WHERE name = 'Product 2500';
Query Planner

PostgreSQL does not automatically use an index for every query.

The query planner evaluates the estimated cost of different execution strategies.

Factors that can influence the selected plan include:

Table size
Column statistics
Selectivity
Estimated number of rows
Index availability
Cost of accessing the index
Cost of reading the table sequentially
Sequential Scan

A Sequential Scan means PostgreSQL reads the table sequentially to find matching rows.

For large tables and highly selective queries, an index may provide a more efficient access path.

However, a Sequential Scan is not necessarily a problem.

For queries that return a large percentage of a table, scanning the table sequentially can be cheaper than accessing an index and then fetching many rows.

Index Scan

An Index Scan allows PostgreSQL to use an index to locate matching rows.

This can significantly reduce the amount of data PostgreSQL needs to inspect when the query is selective.

Statistics

Table statistics were inspected using:

SELECT
    relname,
    n_live_tup,
    n_dead_tup,
    last_analyze,
    last_autoanalyze
FROM pg_stat_user_tables
WHERE relname = 'tb_product';

These statistics help PostgreSQL estimate the cost of different execution plans.

Key Findings

The experiments demonstrated that:

EXPLAIN ANALYZE provides actual execution information.
Primary keys automatically have supporting indexes.
Additional indexes can be created for frequently queried columns.
PostgreSQL chooses execution plans based on cost estimates.
Sequential scans are not inherently bad.
Table statistics are important for query planning.
Indexes are most useful when they provide a meaningful reduction in the amount of data that must be accessed.
Administration Lesson

Performance optimization should be based on evidence rather than assumptions.

The recommended workflow is:

Identify slow query
       |
       v
EXPLAIN ANALYZE
       |
       v
Understand execution plan
       |
       v
Identify possible bottleneck
       |
       v
Apply optimization
       |
       v
EXPLAIN ANALYZE again
       |
       v
Compare results

The goal is not simply to create indexes, but to understand why PostgreSQL selected a particular execution plan.