SELECT scen_name,
         max(sess_beg)
FROM snp_session
GROUP BY  scen_name