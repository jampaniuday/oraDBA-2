-----------------------------------
-- session_trace_enable
-- http://www.dba-oracle.com/t_packages_dbms_session_trace_enable.htm
-----------------------------------

--Create a test table
create table 
   test_dbms_monitor 
as 
select 
   * 
from 
dba_objects;

--Make the table bigger (run this command some times to increase the table size)
insert into 
   test_dbms_monitor 
select 
   * 
from 
test_dbms_monitor;

commit;


--Enable trace in session using dbms_monitor
begin
dbms_monitor.session_trace_enable;
end;
/

begin
--Here, replace with your session_id and serial_num if disabling trace on another session
dbms_monitor.session_trace_disable(session_id => 33,serial_num => 85);
end;
/
--Notice how you can specify the session where tracing will be enabled or disabled, it's not necessarily limited to yours, thus, you don't need to make any changes to your applications to be able to trace what they are doing./

--Run a query on table created   
select 
   count(*) 
from 
   test_dbms_monitor t 
where 
   t.object_id = 3289;


-- parse trace file
-- tkprof /opt/oracle/diag/rdbms/orcl/ora12c/trace/ora12c_ora_27770.trc /opt/oracle/diag/rdbms/orcl/ora12c/trace/ora12c_ora_27770.txt explain=eoda/foo@ora12c sort=exeela
select * 
from v$diag_info
where name = 'Default Trace File';

-- the index on column object_id is created
create index 
   idx_obj_id 
on 
   test_dbms_monitor (object_id) 
pctfree 10 
initrans 2 
maxtrans 255  
logging 
  storage(
  buffer_pool default 
  flash_cache default 
  cell_flash_cache default);

 

--Gather statistics for the table and indexe
begin
dbms_stats.gather_table_stats(
   ownname => 'eoda',
   tabname => 'test_dbms_monitor',
   estimate_percent => 30,
   degree => 4,
   granularity => 'ALL',
   cascade => TRUE,
   method_opt =>'for all indexed columns'); 
end;
/

-- clean up the buffer cache to make sure data is not cached, Run the query again and look at the time and the plan at the trace file. 
alter system flush buffer_cache;
select 
   count(*) 
from 
   test_dbms_monitor t 
where 
   t.object_id = 3289;
   

begin
dbms_monitor.session_trace_disable;
end;
/