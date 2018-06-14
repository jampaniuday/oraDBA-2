-- check index of table is VALID
select owner,index_name,index_type,table_owner,tablespace_name,status from dba_indexes where table_name = 'TSM_WFE_STEP';

-- check table related objects are valid
select obj.owner, obj.object_name, obj.object_type, obj.status, dep.referenced_owner, dep.referenced_name
from dba_objects obj, dba_dependencies dep
where obj.owner = dep.owner
and obj.object_name = dep.name
and dep.referenced_name = 'TSM_WFE_COMMAND'