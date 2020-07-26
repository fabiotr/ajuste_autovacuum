SELECT
    --t.schemaname "Esquema", 
    t.relname "Tabela", 
    seq_scan,
    idx_scan,
    CASE WHEN idx_scan + seq_scan = 0 THEN NULL ELSE idx_scan*100 / (idx_scan + seq_scan) END "Idx %",
    --to_char(t.n_tup_ins + t.n_tup_upd + t.n_tup_del, '999G999G999G999') "Ins+Upd+Del", 
    to_char(t.n_live_tup, '999G999G999G999') "Live", 
    pg_size_pretty(pg_relation_size(t.relid)) "Size",
    to_char(t.n_mod_since_analyze, '999G999G999G999') "Mod",
    --CASE t.n_live_tup WHEN 0 THEN '0 bytes' ELSE pg_size_pretty(( pg_relation_size(t.relid)::NUMERIC * t.n_mod_since_analyze::NUMERIC)/(t.n_live_tup+t.n_mod_since_analyze)::NUMERIC) END "Mod Size",
    CASE t.n_live_tup WHEN 0 THEN 0 ELSE trunc(t.n_mod_since_analyze*100::NUMERIC/(t.n_live_tup)::NUMERIC,1) END "M%", 
    trunc(to_number(coalesce(c.scale,s.setting),'99.999') * 100,1) "S%",
    
    --CASE WHEN t.last_autoanalyze IS NULL THEN 'never AUTO' ELSE to_char(t.last_autoanalyze, 'YY-MM-DD HH24:MI:SS') END last_a, 
    --CASE WHEN t.last_analyze IS NULL THEN 'never MANUAL' ELSE to_char(t.last_analyze, 'YY-MM-DD HH24:MI:SS') END last_m,
    to_char(now() - greatest(t.last_autoanalyze, t.last_analyze), 'DD HH24:MI:SS') 
        || CASE WHEN coalesce(t.last_autoanalyze, '-infinity') > coalesce(t.last_analyze, '-infinity') THEN ' A' ELSE ' M' END "Last",
    t.autoanalyze_count "Qt A",
    CASE t.autoanalyze_count when 0 THEN NULL ELSE to_char((now() - d.stats_reset) / t.autoanalyze_count,'DD HH24:MI:SS') END "Avg time"
FROM 
    pg_stat_user_tables t
    LEFT JOIN (SELECT trim('autovacuum_analyze_scale_factor=' FROM reloptions) scale, oid
        FROM (SELECT unnest(reloptions) reloptions, oid FROM pg_class WHERE reloptions IS NOT NULL) i
        WHERE reloptions LIKE 'autovacuum_analyze_scale_factor=%') c ON t.relid = c.oid
    JOIN pg_stat_database d ON d.datname = current_database()
    JOIN pg_settings s ON s.name = 'autovacuum_analyze_scale_factor'
ORDER BY t.relname
;
