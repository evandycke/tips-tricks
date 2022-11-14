-- Solution 1 : Trouver les index dupliqués
select 
    a.indrelid::regclass, a.indexrelid::regclass, b.indexrelid::regclass 
from 
    (select \*,array_to_string(indkey,' ') as cols from pg_index) a 
    join (select \*,array_to_string(indkey,' ') as cols from pg_index) b on 
        ( a.indrelid=b.indrelid and a.indexrelid > b.indexrelid 
        and 
            ( 
                (a.cols LIKE b.cols||'%' and coalesce(substr(a.cols,length(b.cols)+1,1),' ')=' ') 
                or 
                (b.cols LIKE a.cols||'%' and coalesce(substr(b.cols,length(a.cols)+1,1),' ')=' ') 
            ) 
        ) 
order by 
    indrelid;

-- Solution 2 : Trouver les index dupliqués
SELECT indrelid::regclass,
         array_accum(indexrelid::regclass)
FROM pg_index
GROUP BY  indrelid, indkey
HAVING count(*) > 1;    