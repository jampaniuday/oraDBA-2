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