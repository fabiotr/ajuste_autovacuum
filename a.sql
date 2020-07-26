SELECT 
    relname, 
    n_live_tup, 
    n_mod_since_analyze, 
    last_analyze, 
    last_autoanalyze, 
    analyze_count, 
    autoanalyze_count
FROM pg_stat_user_tables
ORDER BY relname;