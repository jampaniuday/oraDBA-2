select * from dba_hist_snapshot
order by BEGIN_INTERVAL_TIME desc;

-- parameter STATISTICS_LEVEL to TYPICAL then snapshots will be taken automatically
show parameter statistics_level;


-- awr_settings
select
   extract( day from snap_interval) *24*60+
   extract( hour from snap_interval) *60+
   extract( minute from snap_interval ) "Snapshot Interval",
   extract( day from retention) *24*60+
   extract( hour from retention) *60+
   extract( minute from retention ) "Retention Interval"
from 
   dba_hist_wr_control;

-- update awr_settings
exec dbms_workload_repository.modify_snapshot_settings (interval=>30, retention=>11520);