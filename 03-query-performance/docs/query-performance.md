# Query Performance Analysis

## Objective

This document describes the practical experiments performed to analyze PostgreSQL query performance.

The main objective is to understand how PostgreSQL chooses an execution plan and how indexes and table statistics can influence query execution.

The analysis uses the `public.tb_product` table from the `company` database.

---

## Environment

The experiments were performed using:

- PostgreSQL 18
- Database: `company`
- Schema: `public`
- Table: `tb_product`
- PostgreSQL command-line tools
- Git Bash on Windows

---

## Table Used in the Experiments

The main table contains:

| Column | Type | Description |
|---|---|---|
| `product_id` | INTEGER | Product identifier |
| `name` | VARCHAR(100) | Product name |
| `price` | NUMERIC(10,2) | Product price |

The table contains thousands of rows, making it suitable for observing execution-plan behavior.

---

## 1. Updating Table Statistics

Before analyzing query performance, the table statistics were updated using:

```sql
ANALYZE public.tb_product;

ANALYZE collects statistics about the contents of the table.

PostgreSQL uses these statistics to estimate the cost of different execution strategies.

2. EXPLAIN

The first analysis uses EXPLAIN:

EXPLAIN
SELECT *
FROM public.tb_product
WHERE product_id = 2500;

EXPLAIN shows the execution plan that PostgreSQL intends to use without actually executing the query.

The plan can contain information such as:

Scan type
Estimated number of rows
Estimated cost
Index usage
3. EXPLAIN ANALYZE

The next step uses:

EXPLAIN ANALYZE
SELECT *
FROM public.tb_product
WHERE product_id = 2500;

Unlike EXPLAIN, EXPLAIN ANALYZE executes the query.

It reports both estimated and actual execution information.

Important values include:

cost
rows
actual time
actual rows
loops

This makes EXPLAIN ANALYZE useful for validating whether the planner's estimates match the real execution.

4. Primary Key and Index

The product_id column is defined as the table's primary key.

CONSTRAINT products_pkey PRIMARY KEY (product_id)

A primary key automatically creates a unique index.

Therefore, the project does not create another index on product_id.

The existing indexes can be inspected with:

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
  AND tablename = 'tb_product';
5. Query Without an Index on name

The next experiment analyzes a query using the name column:

EXPLAIN ANALYZE
SELECT *
FROM public.tb_product
WHERE name = 'Product 2500';

Before creating an index on name, PostgreSQL may choose a sequential scan.

A sequential scan means that PostgreSQL reads the table sequentially to find matching rows.

Example:

Seq Scan on tb_product

This behavior is not necessarily incorrect.

For a small table, scanning the entire table can be cheaper than accessing an index.

6. Creating an Index

An additional index is created on the name column:

CREATE INDEX IF NOT EXISTS idx_tb_product_name
ON public.tb_product (name);

After creating the index, the table statistics are updated:

ANALYZE public.tb_product;

Updating statistics helps the planner make decisions using current information about the table.

7. Query After Index Creation

The same query is executed again:

EXPLAIN ANALYZE
SELECT *
FROM public.tb_product
WHERE name = 'Product 2500';

The execution plan can now consider the new index.

Depending on the table size, data distribution, selectivity, and estimated costs, PostgreSQL may choose an index-based plan.

Possible examples include:

Index Scan

or:

Bitmap Index Scan
Bitmap Heap Scan

The important point is that creating an index does not force PostgreSQL to use it.

The planner still chooses the execution strategy based on estimated cost.

8. Sequential Scan vs Index Scan
Sequential Scan

A sequential scan reads table pages sequentially.

Advantages:

Simple execution strategy
Efficient for small tables
Can be efficient when a large percentage of rows match

Disadvantages:

Can become expensive for large tables
May read many unnecessary rows when the query is highly selective
Index Scan

An index scan uses an index to locate matching rows.

Advantages:

Useful for selective queries
Can avoid scanning the entire table
Often beneficial on large tables

Disadvantages:

Indexes require additional storage
Indexes increase the cost of INSERT, UPDATE, and DELETE
An index may not be beneficial when many rows match
9. Query Selectivity

Selectivity describes how many rows satisfy a condition compared with the total number of rows.

For example:

5000 rows in table
        |
        v
1 matching row
        |
        v
Highly selective query

A highly selective query is often a good candidate for index usage.

On the other hand:

5000 rows in table
        |
        v
4500 matching rows
        |
        v
Low selectivity

In this situation, PostgreSQL may prefer a sequential scan.

10. Execution Plan Decision

The PostgreSQL planner evaluates different strategies before executing a query.

A simplified representation is:

                    SQL Query
                        |
                        v
                 Query Planner
                        |
          +-------------+-------------+
          |             |             |
          v             v             v
      Seq Scan      Index Scan    Bitmap Scan
          |             |             |
          +-------------+-------------+
                        |
                        v
                 Lowest estimated
                       cost
                        |
                        v
                Selected Plan

The planner considers factors including:

Table statistics
Estimated number of matching rows
Selectivity
Index availability
I/O cost
CPU cost
Table size
11. Table Statistics

PostgreSQL exposes table statistics through pg_stat_user_tables.

Example:

SELECT
    relname,
    n_live_tup,
    n_dead_tup,
    last_analyze,
    last_autoanalyze
FROM pg_stat_user_tables
WHERE relname = 'tb_product';

These statistics help administrators understand the current state of a table.

Relevant fields include:

Field	Meaning
n_live_tup	Estimated number of live rows
n_dead_tup	Estimated number of dead rows
last_analyze	Last manual ANALYZE
last_autoanalyze	Last automatic ANALYZE
12. Practical Findings

The experiments demonstrate several important PostgreSQL administration concepts.

Finding 1 — Primary keys already have indexes

The primary key on product_id provides an index automatically.

Creating another index on the same column would normally be unnecessary.

Finding 2 — Sequential scans are not automatically bad

A sequential scan can be the optimal plan for small tables or queries that return a large percentage of the table.

Finding 3 — Indexes can improve selective queries

An index can reduce the amount of table data PostgreSQL needs to inspect when only a small number of rows match.

Finding 4 — Statistics influence query planning

ANALYZE provides the planner with information about the table and helps PostgreSQL estimate query costs.

Finding 5 — Index creation should be evidence-based

Indexes should not be created simply because they exist as a possible optimization.

The execution plan should be analyzed before and after the change.

13. Administration Principle

Query optimization should be based on measurement rather than assumptions.

A practical workflow is:

Identify slow query
       |
       v
Run EXPLAIN
       |
       v
Run EXPLAIN ANALYZE
       |
       v
Identify execution strategy
       |
       v
Evaluate statistics and indexes
       |
       v
Apply optimization
       |
       v
Run EXPLAIN ANALYZE again
       |
       v
Compare results

This approach allows the administrator to make optimization decisions based on actual execution behavior.

Conclusion

The experiments demonstrate the relationship between PostgreSQL's query planner, table statistics, sequential scans, and indexes.

EXPLAIN and EXPLAIN ANALYZE are essential tools for understanding query execution.

The main lesson is that PostgreSQL should be allowed to choose the execution strategy based on current statistics and estimated costs, while the administrator uses execution-plan analysis to identify opportunities for optimization.