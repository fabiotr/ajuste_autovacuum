SELECT
    t.relname "Tabela", 
    to_char(t.n_tup_upd + t.n_tup_del, '999G999G999G999') "Upd+Del", 
    to_char(t.n_live_tup, '999G999G999G999') "Live", 
    pg_size_pretty(pg_relation_size(t.relid)) "Size",
    to_char(t.n_dead_tup, '999G999G999G999') "Dead",
    CASE t.n_live_tup WHEN 0 THEN '0 bytes' ELSE pg_size_pretty((pg_relation_size(t.relid)::NUMERIC*t.n_dead_tup::NUMERIC)/(t.n_live_tup+t.n_dead_tup)::NUMERIC) END "Dead Size",
    CASE t.n_live_tup WHEN 0 THEN 0 ELSE trunc(t.n_dead_tup*100::NUMERIC/(t.n_live_tup+t.n_dead_tup)::NUMERIC,1) END "D%", 
    trunc(to_number(coalesce(c.scale,s.setting),'99.999') * 100,1) "S%"
FROM 
    pg_stat_user_tables t
    LEFT JOIN (SELECT trim('autovacuum_vacuum_scale_factor=' FROM reloptions) scale, oid
        FROM (SELECT unnest(reloptions) reloptions, oid FROM pg_class WHERE reloptions IS NOT NULL) i
        WHERE reloptions LIKE 'autovacuum_vacuum_scale_factor=%') c ON t.relid = c.oid
    LEFT JOIN (SELECT FALSE enabled, oid
        FROM (SELECT unnest(reloptions) reloptions, oid FROM pg_class WHERE reloptions IS NOT NULL) i
        WHERE reloptions LIKE 'autovacuum_enabled=false') e ON t.relid = e.oid
    JOIN pg_stat_database d ON d.datname = current_database()
    JOIN pg_settings s ON s.name = 'autovacuum_vacuum_scale_factor'
ORDER BY CASE n_live_tup WHEN 0 then 0 ELSE (pg_relation_size(t.relid)::NUMERIC*t.n_dead_tup::NUMERIC)/(t.n_live_tup+t.n_dead_tup)::NUMERIC END DESC, relname;