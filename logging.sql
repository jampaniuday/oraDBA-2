
-- check a database/tablespace in FORCE LOGGING mode
select force_logging from v$database;
select tablespace_name, force_logging from dba_tablespaces;


-- put a database/tablespace in FORCE LOGGING mode
ALTER DATABASE FORCE LOGGING;
ALTER TABLESPACE <tablespace name> FORCE LOGGING;


-- cancel a database/tablespace in FORCE LOGGING mode
ALTER DATABASE NO FORCE LOGGING;
ALTER TABLESPACE <tablespace name> NO FORCE LOGGING;