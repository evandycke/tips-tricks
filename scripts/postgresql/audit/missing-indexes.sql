-- Retrouver les index manquants
SELECT relname AS TableName ,
        seq_scan-idx_scan AS TotalSeqScan ,
        CASE
    WHEN seq_scan-idx_scan > 0 THEN
    'Missing Index Found'
    ELSE 'Missing Index Not Found'
    END AS MissingIndex ,pg_size_pretty(pg_relation_size(relname::regclass)) AS TableSize ,idx_scan AS TotalIndexScan
FROM pg_stat_all_tables
WHERE schemaname='monSchema'
        AND pg_relation_size(relname::regclass)>100000
ORDER BY  2 DESC;