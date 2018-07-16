-- show lock info
select (select username
            from v$session
           where sid = v$lock.sid) username,
         sid,
         id1,
         id2,
         lmode,
         request, block, v$lock.type
    from v$lock
where sid = sys_context('userenv','sid');


-- show TX lock hold by which session
select username,
         v$lock.sid,
         trunc(id1/power(2,16)) rbs,
         bitand(id1,to_number('ffff','xxxx'))+0 slot,
         id2 seq,
         lmode,
         request
  from v$lock, v$session
  where v$lock.type = 'TX'
    and v$lock.sid = v$session.sid
    and v$session.username = USER;


-- show transaction's lock info
select XIDUSN, XIDSLOT, XIDSQN from v$transaction;


-- show lock blocking between sessions
select
        (select username from v$session where sid=a.sid) blocker,
         a.sid,
        ' is blocking ',
         (select username from v$session where sid=b.sid) blockee,
             b.sid
    from v$lock a, v$lock b
   where a.block = 1
     and b.request > 0
     and a.id1 = b.id1
     and a.id2 = b.id2;

