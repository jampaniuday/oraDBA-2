-- get session active
SELECT * FROM V$SESSION WHERE STATUS = 'ACTIVE';

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