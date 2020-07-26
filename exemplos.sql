SELECT 
    i, 
    nullif(round(random() * 100),100) n,
    i + random() * 100 nn,
    chr((round(random() * 94) + 32)::int) c, 
    repeat(chr((round(random() * 94) + 32)::int), round(random() * 20)::int) cc,
    (current_date + round(random()*365) * '1 day'::interval)::date d,
    current_timestamp + random()*365 * '1 day'::interval dd
FROM generate_series(1,100) i;

SELECT tablename, attname, null_frac, avg_width, n_distinct, most_common_vals, most_common_freqs, most_common_freqs 
FROM pg_stats 
WHERE tablename = 't';

SELECT tablename, attname, null_frac, avg_width, n_distinct, most_common_vals, most_common_freqs, most_common_freqs 
FROM pg_stats 
WHERE tablename = 't' AND attname = 'c';


ALTER SYSTEM set autovacuum = on;
ALTER SYSTEM set autovacuum = off;
SELECT pg_reload_conf();
SHOW autovacuum;


EXPLAIN SELECT * FROM t WHERE c = 'a';

CREATE INDEX on t(c);

EXPLAIN SELECT * FROM t WHERE c = 'a';