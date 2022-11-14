 -- Get running queries AND lock statuses
SELECT  S.pid
       ,age(clock_timestamp(),query_start)
       ,usename
       ,query
       ,L.mode
       ,L.locktype
       ,L.granted
       ,s.datname
FROM pg_stat_activity S
INNER JOIN pg_locks L
ON S.pid = L.pid
ORDER BY L.granted, L.pid DESC;