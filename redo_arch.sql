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