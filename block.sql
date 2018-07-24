-- returns the database block number for the input ROWID
select DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid) from t;

-- show extent/block of a table
select extent_id, bytes, blocks
from user_extents
where segment_name = 'T'
order by extent_id;