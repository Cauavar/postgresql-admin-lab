# VACUUM and ANALYZE

## Objective

Demonstrate the practical purpose of VACUUM ANALYZE in PostgreSQL and automate its execution using a Windows batch script.

## Environment

- PostgreSQL 18
- Database: company
- Table: public.tb_product
- Operating system: Windows
- Automation: Windows Batch (.bat)

## Initial State

Before making changes, the table statistics were:

- Live tuples: 5002
- Dead tuples: 0

The last VACUUM and ANALYZE executions were recorded in `pg_stat_user_tables`.

## Test

The following operations were performed:

```sql
UPDATE public.tb_product
SET price = price + 1
WHERE product_id <= 3;

DELETE FROM public.tb_product
WHERE product_id = 7;
```
After the modifications, the statistics showed:

Live tuples: 5001
Dead tuples: 3

This demonstrates that UPDATE and DELETE operations can generate dead tuples that PostgreSQL needs to manage.

VACUUM ANALYZE

The following command was executed:

VACUUM ANALYZE public.tb_product;

After execution, PostgreSQL updated the maintenance timestamps:

last_vacuum
last_analyze

These values can be monitored through:

SELECT
    relname,
    n_live_tup,
    n_dead_tup,
    last_vacuum,
    last_analyze
FROM pg_stat_user_tables
WHERE relname = 'tb_product';
Automation

The process was automated using:

scripts/vacuum-analyze-company.bat

The script executes:

VACUUM ANALYZE;

and records the execution result in:

C:\Backups\PostgreSQL\vacuum.log
Result

The automated execution completed successfully:

VACUUM ANALYZE completed successfully.

The log recorded:

VACUUM ANALYZE started
Database: company
VACUUM
VACUUM ANALYZE completed successfully.
VACUUM ANALYZE finished
Conclusion

This experiment demonstrated the relationship between data modifications, dead tuples, PostgreSQL maintenance, statistics collection, and automation.

It also provided practical experience with pg_stat_user_tables, VACUUM, ANALYZE, Windows batch scripting, and logging.