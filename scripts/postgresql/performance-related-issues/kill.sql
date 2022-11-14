 -- Kill a particular query that is causing the issue
SELECT  pg_cancel_backend(pids);