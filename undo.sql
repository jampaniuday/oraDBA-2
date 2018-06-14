-- check undo tablespace size
select round(sum(bytes)/1024/1024/1024,2) GB from dba_undo_extents
where status in ('ACTIVE','UNEXPIRED');

select bytes/1024/1024 "Size(M)",name from v$datafile where name like '%undo%';


-- add datafile to undo tablespace

ALTER TABLESPACE UNDO1 ADD DATAFILE '/mnt2/TSMDB/undo/UNDO_01_2.dbf.DBF' SIZE 1073741824 AUTOEXTEND ON NEXT 8192 MAXSIZE 32767M;


--------------------------------
-- reduce undo tablespace
--------------------------------
-- Create a new UNDO tablespace.
CREATE UNDO TABLESPACE UNDO2
DATAFILE '/mnt2/TSMDB/undo/UNDO_02_1.dbf.DBF' SIZE 1073741824
AUTOEXTEND ON NEXT 8192 MAXSIZE 32767M;


-- Modify the database parameter to use the new UNDO tablespace.
ALTER SYSTEM SET undo_tablespace=UNDO2 SCOPE=BOTH;