
-- Remove tablespace
DROP TABLESPACE INDX_COMMAND_TSM_WFE INCLUDING CONTENTS AND DATAFILES;

-- check tablespace datafile
select tablespace_name, file_name, bytes from dba_data_files where tablespace_name = 'INDX_COMMAND_TSM_WFE';

-- datafile location
select tablespace_name, file_name, bytes 
from dba_data_files
order by tablespace_name;

-- shrink table compact
alter table ADMGEMALTO.TSM_WFE_COMMAND enable row movement;
alter table ADMGEMALTO.TSM_WFE_COMMAND shrink space compact;
alter table ADMGEMALTO.TSM_WFE_COMMAND disable row movement;


-- check tablespace free space
select ts.tablespace_name,ts.Object_Size, 
tf.Tablespace_Total_Size,
round((1-(ts.Object_Size/tf.Tablespace_Total_Size))*100,2) Free_Space_Percentage 
from 
(select s.tablespace_name, round(sum(s.bytes)/1024/1024/1024,2) Object_Size
from dba_segments s
group by s.tablespace_name) TS,
(select f.tablespace_name, round(sum(f.maxbytes)/1024/1024/1024,2) Tablespace_Total_Size
from dba_data_files f
group by f.tablespace_name) TF
where ts.tablespace_name=tf.tablespace_name
order by ts.Object_Size desc;

-- add data file to tablespace
ALTER TABLESPACE  DATA_COMMAND_TSM_WFE
ADD DATAFILE '/mnt1/TSMDB/data/DATA_COMMAND_TSM_WFE_3.dbf'
SIZE 100M
AUTOEXTEND 
ON  NEXT 8192
MAXSIZE 32767M;


-- list of all tablespaces used in the current database instance
SELECT TABLESPACE_NAME, STATUS, CONTENTS FROM USER_TABLESPACES;
SELECT TABLESPACE_NAME, STATUS, CONTENTS FROM DBA_TABLESPACES;

