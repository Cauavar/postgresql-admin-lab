# Query Performance

## Objective

This module focuses on analyzing PostgreSQL query performance and understanding how the database chooses an execution plan.

The practical exercises demonstrate how to use `EXPLAIN` and `EXPLAIN ANALYZE`, identify sequential scans, create indexes, and evaluate the impact of table statistics on query execution.

## Topics

The module covers:

- EXPLAIN
- EXPLAIN ANALYZE
- Execution plans
- Sequential scans
- Index scans
- Indexes
- Query selectivity
- Table statistics
- ANALYZE
- Query optimization

## EXPLAIN

`EXPLAIN` displays the execution plan that PostgreSQL intends to use for a query.

Example:

```sql
EXPLAIN
SELECT *
FROM public.tb_product
WHERE product_id = 2500;

The command does not execute the query. It only shows the planned execution strategy.

EXPLAIN ANALYZE

EXPLAIN ANALYZE executes the query and includes actual execution statistics.

Example:

EXPLAIN ANALYZE
SELECT *
FROM public.tb_product
WHERE product_id = 2500;

It can be used to compare the estimated execution plan with the actual execution behavior.

Sequential Scan

A sequential scan occurs when PostgreSQL reads the table sequentially to find matching rows.

Example:

Seq Scan on tb_product

Sequential scans are not necessarily a problem.

For small tables, scanning the entire table may be cheaper than using an index.

However, sequential scans on large tables can become expensive when only a small number of rows match the query.

Indexes

Indexes provide an additional data structure that can help PostgreSQL locate rows more efficiently.

Example:

CREATE INDEX idx_tb_product_name
ON public.tb_product (name);

A query filtering by the indexed column may then use an index-based execution plan.

Example:

EXPLAIN ANALYZE
SELECT *
FROM public.tb_product
WHERE name = 'Product 2500';
Primary Key Index

A primary key automatically creates a unique index.

For example:

tb_product
    |
    +---- PRIMARY KEY (product_id)
              |
              +---- unique index

Therefore, creating another index on product_id would normally be redundant.

ANALYZE

ANALYZE updates statistics about the contents of a table.

These statistics are used by the PostgreSQL query planner to estimate:

Number of rows
Data distribution
Selectivity of conditions
Cost of possible execution plans

Example:

ANALYZE public.tb_product;
Query Planner

PostgreSQL evaluates different possible execution strategies and chooses the plan with the lowest estimated cost.

A simplified decision process is:

SQL Query
    |
    v
Query Planner
    |
    +---- Sequential Scan
    |
    +---- Index Scan
    |
    +---- Other execution strategies
    |
    v
Selected Execution Plan

The presence of an index does not guarantee that PostgreSQL will use it.

The planner considers factors such as:

Table size
Number of matching rows
Index selectivity
Table statistics
Estimated I/O cost
Estimated CPU cost
Practical Experiments

The project uses PostgreSQL tables with different amounts of data to observe how execution plans behave as table size increases.

The experiments include:

Small table
    |
    v
Sequential Scan
    |
    v
Larger table
    |
    v
EXPLAIN ANALYZE
    |
    v
Index creation
    |
    v
Execution plan comparison

The results are documented in:

docs/query-performance.md

The executable examples are stored in:

sql/01-explain-analyze.sql
Important Principle

Performance optimization should be based on evidence.

Instead of assuming that an index will improve a query, the execution plan should be analyzed before and after the change.

The main tools used in this module are:

EXPLAIN
EXPLAIN ANALYZE
ANALYZE
pg_stat_user_tables
pg_indexes
Learning Outcome

After completing this module, the administrator should be able to:

Read a basic PostgreSQL execution plan.
Identify a sequential scan.
Understand when an index may be useful.
Create and inspect indexes.
Use EXPLAIN ANALYZE to evaluate real execution behavior.
Understand the importance of table statistics.
Use evidence to guide query optimization.