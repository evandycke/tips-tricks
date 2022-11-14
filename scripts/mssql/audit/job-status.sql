Create View LastFailedJobs as
with qry as
(select job_id,last_executed_step_id
 from msdb.dbo.sysjobactivity
 where last_executed_step_id is not null)
select 
   job_name, 
   CASE run_status
        WHEN 0 THEN 'Failed'
        WHEN 1 THEN 'Succeeded'
        WHEN 2 THEN 'Retry'
        WHEN 3 THEN 'Cancelled'
    END
    AS
    run_status,
   convert(date,convert(varchar,run_date)) run_date, 
    Isnull(Substring(CONVERT(VARCHAR, run_time + 1000000), 2, 2) + ':' +
                Substring(CONVERT(VARCHAR, run_time + 1000000), 4, 2)
        + ':' +
        Substring(CONVERT(VARCHAR, run_time + 1000000), 6, 2), '') as run_time,
   run_duration, step_name, message
 from qry
cross apply
(select top (qry.last_executed_step_id + 1)
        sysjobs.name as job_name,
        sysjobhistory.run_status,
        run_date, run_time,
        run_duration, step_name,
        message, step_id
             FROM   msdb.dbo.sysjobhistory
             INNER JOIN msdb.dbo.sysjobs
               ON msdb.dbo.sysjobhistory.job_id = msdb.dbo.sysjobs.job_id
    where msdb.dbo.sysjobs.job_id=qry.job_id
order by run_date desc,run_time desc) t
where run_status<>1
order by job_name,step_id