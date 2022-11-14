 -- Which TABLE has the highest dead tuples
SELECT  schemaname
       ,relname
       ,n_live_tup
       ,n_dead_tup
       ,last_vacuum
       ,last_autovacuum
FROM pg_stat_user_tables
ORDER BY n_dead_tup DESC
LIMIT 10;