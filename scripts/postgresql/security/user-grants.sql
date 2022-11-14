-- Retourne les autorisations des utilisateurs
SELECT use.usename AS subject,
         nsp.nspname AS namespace,
         c.relname AS item,
         c.relkind AS type,
         use2.usename AS owner,
         c.relacl,
         (use2.usename != use.usename
        AND c.relacl::text !~ ('({|,)' || use.usename || '=')) AS public
FROM pg_user use
CROSS JOIN pg_class c
LEFT JOIN pg_namespace nsp
    ON (c.relnamespace = nsp.oid)
LEFT JOIN pg_user use2
    ON (c.relowner = use2.usesysid)
WHERE c.relowner = use.usesysid
        OR c.relacl::text ~ ('({|,)(|' || use.usename || ')=')
ORDER BY  subject, namespace, item;