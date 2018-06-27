-- get session active
SELECT * FROM V$SESSION WHERE STATUS = 'ACTIVE';

-- get current session SID
select sid from v$mystat where rownum = 1;

-- get cursor opened by this session
SELECT * FROM V$OPEN_CURSOR WHERE SID=4007;  -- the id

-- determinate who is accessing the table
SELECT a.object, a.type, a.sid,
s.serial#, s.username,
s.program, s.logon_time
FROM v$access a, v$session s
WHERE a.sid = s.sid
AND a.owner = 'ADMGEMALTO'
AND a.object = 'TSM_WFE_COMMAND';

----------------------------------------
-- cursor sharing
----------------------------------------
-- cursor_sharing = EXACT (default)
alter system flush shared_pool;
show parameter cursor_sharing;
select name, value from v$parameter where name='cursor_sharing';

select * from T where object_id=33;
select * from T where object_id=40;
-- sql stats
select sql_text, sql_id, version_count, executions from v$sqlarea where sql_text like 'select * from T%';
select sql_text,sql_id, child_number, LAST_LOAD_TIME from v$sql where sql_id='6c17uf1k9kwkm';
-- sql execution plan
select * from table(dbms_xplan.display_cursor('9bchsdap9brha',0,'advanced'));


-- cursor_sharing = FORCE
alter system flush shared_pool;
alter session set cursor_sharing='FORCE';
show parameter cursor_sharing;

select * from T where object_id=33;
select * from T where object_id=40;
-- sql stats
select sql_text, sql_id, version_count, executions from v$sqlarea where sql_text like 'select * from T%';
select * from table(dbms_xplan.display_cursor('6c17uf1k9kwkm',0,'advanced'));
-- sql execution plan
select sql_text,sql_id, child_number, LAST_LOAD_TIME from v$sql where sql_id='6c17uf1k9kwkm';