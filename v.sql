SELECT 
    relname, 
    n_live_tup, 
    n_dead_tup, 
    last_vacuum, 
    last_autovacuum, 
    vacuum_count, 
    autovacuum_count
FROM pg_stat_user_tables
ORDER BY relname;
