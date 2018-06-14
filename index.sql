
-- Create new index tablespace with new index data file
CREATE TABLESPACE "INDX_COMMAND_TSM_WFE_SSD" DATAFILE 
'/mnt2/TSMDB/index/INDX_COMMAND_TSM_WFE_SSD_1.dbf' SIZE 104857600
AUTOEXTEND ON NEXT 8192 MAXSIZE 32767M;


-- Rebuild index to new tablespace 
select 'alter index '||owner||'.'||segment_name||' rebuild online tablespace INDX_COMMAND_TSM_WFE_SSD;' 
from dba_segments where tablespace_name = 'INDX_COMMAND_TSM_WFE' ORDER BY BYTES;


-- check index in tablespace
select owner, segment_name from dba_segments where tablespace_name = 'INDX_COMMAND_TSM_WFE_SSD' ORDER BY BYTES;


-- check index tablespace datafile
select tablespace_name, file_name, bytes from dba_data_files where tablespace_name = 'INDX_COMMAND_TSM_WFE';

-- check index size:
select * from (select owner, segment_name, bytes/1024/1024 M from dba_segments
				where segment_type = 'INDEX'
				and tablespace_name = 'INDX_COMMAND_TSM_WFE_SSD' order by bytes/1024/1024 desc);


-- add datafile to index
ALTER TABLESPACE  INDX_COMMAND_TSM_WFE
ADD DATAFILE '/mnt2/TSMDB/index/INDX_COMMAND_TSM_WFE_3.dbf'
SIZE 100M
AUTOEXTEND 
ON  NEXT 8192
MAXSIZE 32767M; 