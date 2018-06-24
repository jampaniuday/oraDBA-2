-- auto PGA management
show parameters workarea_size_policy
show parameters pga_aggregate_target

-- auto SGA management
show parameters sga_target

-- memory_target = SGA + PGA
show parameters memory_target

-- current session PGA/UGA memory usage
select a.name, to_char(b.value, '999,999,999') bytes,
         to_char(round(b.value/1024/1024,1), '99,999.9' ) mbytes
    from v$statname a, v$mystat b
   where a.statistic# = b.statistic#
     and a.name like '%ga memory%';
     
-- check SGA
select pool, name, bytes
   from v$sgastat
   order by pool, name;
   
-- redo buffer(log_buffer)
select name, value, isdefault from v$parameter where name='log_buffer';
show parameters log_buffer


-- shared pool szie
show parameters shared_pool_size
