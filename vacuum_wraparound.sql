SELECT
    nspname AS "Esquema", 
    relname AS "Tabela",
    to_char(to_number(current_setting('vacuum_freeze_table_age'),'999999999999'),'999G999G999G999') AS "Min Age", 
    to_char(age(relfrozenxid),'999G999G999G999') AS "Age",
    to_char(to_number(current_setting('autovacuum_freeze_max_age'),'999999999999'),'999G999G999G999') AS "Max Age", 
    pg_size_pretty(pg_table_size(c.oid)) AS "Tamanho"
FROM pg_class c JOIN pg_namespace n ON c.relnamespace = n.oid
WHERE
    relkind = 'r' AND
    nspname NOT IN ('information_schema', 'pg_catalog') AND
    pg_table_size(c.oid) > 67108864 AND -- > 64MB
    age(relfrozenxid) >= to_number(current_setting('vacuum_freeze_table_age'),'999999999999')
ORDER BY age(relfrozenxid) DESC
LIMIT 40;