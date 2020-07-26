ALTER SYSTEM set autovacuum = off;
SELECT pg_reload_conf();
SELECT pg_stat_reset();

DROP TABLE IF EXISTS t;
DROP TABLE IF EXISTS tt;
DROP TABLE IF EXISTS ttt;
DROP TABLE IF EXISTS tttt;
DROP TABLE IF EXISTS ttttt;
DROP TABLE IF EXISTS tttttt;
DROP TABLE IF EXISTS ttttttt;
CREATE TABLE t AS
SELECT 
    i, 
    nullif(round(random() * 100),100) n,
    i + random() * 100 nn,
    chr((round(random() * 94) + 32)::int) c, 
    repeat(chr((round(random() * 94) + 32)::int), round(random() * 20)::int) cc,
    (current_date + round(random()*365) * '1 day'::interval)::date d,
    current_timestamp + random()*365 * '1 day'::interval dd
FROM generate_series(1,10) i;

CREATE TABLE tt AS
SELECT 
    i, 
    nullif(round(random() * 100),100) n,
    i + random() * 100 nn,
    chr((round(random() * 94) + 32)::int) c, 
    repeat(chr((round(random() * 94) + 32)::int), round(random() * 20)::int) cc,
    (current_date + round(random()*365) * '1 day'::interval)::date d,
    current_timestamp + random()*365 * '1 day'::interval dd
FROM generate_series(1,100) i;

CREATE TABLE ttt AS
SELECT 
    i, 
    nullif(round(random() * 100),100) n,
    i + random() * 100 nn,
    chr((round(random() * 94) + 32)::int) c, 
    repeat(chr((round(random() * 94) + 32)::int), round(random() * 20)::int) cc,
    (current_date + round(random()*365) * '1 day'::interval)::date d,
    current_timestamp + random()*365 * '1 day'::interval dd
FROM generate_series(1,1000) i;

CREATE TABLE tttt AS
SELECT 
    i, 
    nullif(round(random() * 100),100) n,
    i + random() * 100 nn,
    chr((round(random() * 94) + 32)::int) c, 
    repeat(chr((round(random() * 94) + 32)::int), round(random() * 20)::int) cc,
    (current_date + round(random()*365) * '1 day'::interval)::date d,
    current_timestamp + random()*365 * '1 day'::interval dd
FROM generate_series(1,10000) i;

CREATE TABLE ttttt AS
SELECT 
    i, 
    nullif(round(random() * 100),100) n,
    i + random() * 100 nn,
    chr((round(random() * 94) + 32)::int) c, 
    repeat(chr((round(random() * 94) + 32)::int), round(random() * 20)::int) cc,
    (current_date + round(random()*365) * '1 day'::interval)::date d,
    current_timestamp + random()*365 * '1 day'::interval dd
FROM generate_series(1,100000) i;

CREATE TABLE tttttt AS
SELECT 
    i, 
    nullif(round(random() * 100),100) n,
    i + random() * 100 nn,
    chr((round(random() * 94) + 32)::int) c, 
    repeat(chr((round(random() * 94) + 32)::int), round(random() * 20)::int) cc,
    (current_date + round(random()*365) * '1 day'::interval)::date d,
    current_timestamp + random()*365 * '1 day'::interval dd
FROM generate_series(1,1000000) i;


CREATE TABLE ttttttt AS
SELECT 
    i, 
    nullif(round(random() * 100),100) n,
    i + random() * 100 nn,
    chr((round(random() * 94) + 32)::int) c, 
    repeat(chr((round(random() * 94) + 32)::int), round(random() * 20)::int) cc,
    (current_date + round(random()*365) * '1 day'::interval)::date d,
    current_timestamp + random()*365 * '1 day'::interval dd
FROM generate_series(1,10000000) i;