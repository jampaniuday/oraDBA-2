-- ARCHIVELOG mode

archive log list;
select log_mode from v$database;

-- enable ARCHIVELOG mode
SQL> startup mount
ORACLE instance started.

Total System Global Area  184549376 bytes
Fixed Size                  1300928 bytes
Variable Size             157820480 bytes
Database Buffers           25165824 bytes
Redo Buffers                 262144 bytes
Database mounted.

SQL> alter database archivelog;
Database altered.

SQL> alter database open;
Database altered.



-- check current SCN
select current_scn from v$database;

-- check datafile checkpoint
select file#, CHECKPOINT_CHANGE#, NAME from v$datafile;

-- trigger a checkpoint
alter system checkpoint;

-- switch redo log file
alter system switch logfile;

-- redo log
select first_time,first_change#,sequence#,status from v$log;


-- log history information
select * from V$LOG_HISTORY;

select * from V$LOGHIST;


-- redo log file information
select * from V$LOG;

select * from V$LOGFILE;


-- information about archived logs that are needed to complete media recovery
select * from V$RECOVERY_LOG;



create or replace function get_stat_val( p_name in varchar2) return number
as
    l_val number;
begin
    select b.value
    into l_val
    from v$statname a, v$mystat b
    where a.statistic# = b.statistic#
    and a.name = p_name;
    
    return l_val;
end;
/



-- most recently archived sequence number for each thread
SELECT MAX(SEQUENCE#), THREAD# FROM V$ARCHIVED_LOG
WHERE RESETLOGS_CHANGE# = (SELECT MAX(RESETLOGS_CHANGE#) FROM V$ARCHIVED_LOG)
GROUP BY THREAD#;

-- most recently archived redo log file at each redo transport destination
SELECT DESTINATION, STATUS, ARCHIVED_THREAD#, ARCHIVED_SEQ#
FROM V$ARCHIVE_DEST_STATUS
WHERE STATUS <> 'DEFERRED' AND STATUS <> 'INACTIVE';


-- find out if any log files are missing at the redo transport destination
SELECT LOCAL.THREAD#, LOCAL.SEQUENCE# FROM
(SELECT THREAD#, SEQUENCE# FROM V$ARCHIVED_LOG WHERE DEST_ID=1)
LOCAL WHERE
LOCAL.SEQUENCE# NOT IN
(SELECT SEQUENCE# FROM V$ARCHIVED_LOG WHERE DEST_ID=2 AND
THREAD# = LOCAL.THREAD#);


-- archive log list
archive log list

-- Query the v$archive_dest view:
select dest_name, status, destination from v$archive_dest;  





