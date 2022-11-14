-- Solution 1 : Trouver les index inutiles
SELECT starelid::regclass,
         indexrelid::regclass,
         array_accum(staattnum),
         relpages,
         reltuples,
         array_accum(stadistinct)
FROM pg_index
JOIN pg_statistic
    ON (starelid=indrelid
        AND staattnum = ANY(indkey))
JOIN pg_class
    ON (indexrelid=oid) where
    CASE
    WHEN stadistinct < 0 THEN
    stadistinct > -.8
    ELSE reltuples/stadistinct > .2 end
        AND NOT (indisunique
        OR indisprimary)
        AND (relpages > 100
        OR reltuples > 1000)
GROUP BY  starelid, indexrelid, relpages, reltuples
ORDER BY  starelid ;

-- Solution 2 : Recherche d'index inutilisés
SELECT indexrelid::regclass AS index,
         relid::regclass AS table
FROM pg_stat_user_indexes
JOIN pg_index
USING (indexrelid)
WHERE idx_scan = 0
        AND indisunique is false;