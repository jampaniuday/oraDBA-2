----------------------------------------
-- connection
----------------------------------------
-- client process
select a.spid    dedicated_server, b.process clientpid
from v$process a, v$session b
where a.addr = b.paddr
and   b.sid = sys_context('userenv','sid'); 


----------------------------------------
-- session
----------------------------------------
select username, sid, serial#, server, paddr, status
from v$session
where username = 'EODA';

select a.username, a.sid, a.serial#, a.server, a.paddr, a.status, b.program
from v$session a left join v$process b
on (a.paddr = b.addr)
where a.username = 'EODA';

-- get session active
SELECT * FROM V$SESSION WHERE STATUS = 'ACTIVE';

-- get current session SID
select sid from v$mystat where rownum = 1;

-- determinate who is accessing the table
SELECT a.object, a.type, a.sid,
s.serial#, s.username,
s.program, s.logon_time
FROM v$access a, v$session s
WHERE a.sid = s.sid
AND a.owner = 'ADMGEMALTO'
AND a.object = 'TSM_WFE_COMMAND';

-- get inactive session more than 2h
SELECT SID, SERIAL#,MODULE, STATUS
FROM V$SESSION S
WHERE S.USERNAME IS NOT NULL
AND S.LAST_CALL_ET >= 60*60*2
AND S.STATUS = 'INACTIVE'
ORDER BY SID DESC;


-- kill inactive sessions
CREATE OR REPLACE PROCEDURE SYS.DB_KILL_IDLE_SESSIONS AUTHID DEFINER AS
   job_no number;
   num_of_kills number := 0;
BEGIN
    FOR REC IN
       (SELECT SID, SERIAL#,MODULE, STATUS
		FROM V$SESSION S
		WHERE S.USERNAME IS NOT NULL
		AND S.LAST_CALL_ET >= 60*60*2
		AND S.STATUS = 'INACTIVE'
		ORDER BY SID DESC;
        ) LOOP
         -- kill inactive sessions immediately
        DBMS_OUTPUT.PUT('LOCAL SID ' || rec.sid || '(' || rec.module || ')');
		execute immediate 'alter system kill session ''' || rec.sid || ', ' || rec.serial# || '''immediate' ;
        
		-- disconnect inactive sessions immediately
        -- DBMS_OUTPUT.PUT('LOCAL SID ' || rec.sid || '(' || rec.module || ')');
		-- execute immediate 'alter system disconnect session ''' || rec.sid || ', ' || rec.serial# || '''immediate' ;
        
		DBMS_OUTPUT.PUT_LINE('. killed locally ' || job_no);
        num_of_kills := num_of_kills + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE ('Number of killed xxxx system sessions: ' || num_of_kills);
END DB_KILL_IDLE_SESSIONS;
/


----------------------------------------
-- cursor
----------------------------------------
-- get cursor opened by this session
SELECT * FROM V$OPEN_CURSOR WHERE SID=4007;  -- the id

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