
-- check invalid objects
select owner, object_type, object_name
from dba_objects where status ='INVALID';

-- check procedure source
select text from dba_source where name='PROC_TSM_PURGE_TABLE_TEST';