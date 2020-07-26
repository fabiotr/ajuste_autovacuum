SELECT
    'ALTER TABLE ' || n.nspname || '.' || t.relname || ' SET(autovacuum_vacuum_scale_factor = ' || round((100*1024*1024) / pg_relation_size(t.oid)::NUMERIC,5) || ');' 
        || '-- ' || pg_size_pretty(pg_relation_size(t.oid))  AS "ALTER TABLE"
FROM pg_class AS t JOIN pg_namespace n ON t.relnamespace = n.oid
WHERE
    t.relpages > 1000
ORDER BY relpages DESC;