show parameter db_flashback_retention;

select estimated_flashback_size, retention_target, flashback_size
from v$flashback_database_log;

select dbid, name, flashback_on from v$database;