---------------------------------
-- files location
---------------------------------
select name from v$datafile;

select member from v$logfile;

select name from v$controlfile;


---------------------------------
-- pfile/spfile
---------------------------------
show parameter spfile;


---------------------------------
-- trace file
---------------------------------
alter session set events '10046 trace name context forever, level 12';

show parameter dump_dest;

select name, value 
from v$parameter 
where name like '%dump_dest%';

select * from v$diag_info;


-- enable/disable session trace
exec dbms_monitor.session_trace_enable;

exec dbms_monitor.session_trace_disable;


---------------------------------
-- process
---------------------------------
select * from v$process;


---------------------------------
-- session
---------------------------------
select * from v$session;


---------------------------------
-- user/privlege
---------------------------------
select * from ALL_USERS;

select * from dba_users;


--------------------------------
-- autotrace
--------------------------------
set autotrace traceonly statistics;
select * from t order by 1,2,3,4;
set autotrace off;