------------------------------------------------------------------------
-- Full backup
------------------------------------------------------------------------
RUN
{  
ALLOCATE CHANNEL c1 DEVICE TYPE disk format '/backup/KMSDB/20180330/arch_%d_%T_%s_%p';  
ALLOCATE CHANNEL c2 DEVICE TYPE disk format '/backup/KMSDB/20180330/arch_%d_%T_%s_%p';  
BACKUP AS COMPRESSED BACKUPSET ARCHIVELOG ALL DELETE ALL INPUT;
}


RUN
{  
ALLOCATE CHANNEL c1 DEVICE TYPE disk format '/backup/KMSDB/20180330/full_incremental_level_0_%d_%T_%s_%p';  
ALLOCATE CHANNEL c2 DEVICE TYPE disk format '/backup/KMSDB/20180330/full_incremental_level_0_%d_%T_%s_%p';  
BACKUP AS COMPRESSED BACKUPSET INCREMENTAL LEVEL 0 DATABASE PLUS ARCHIVELOG DELETE ALL INPUT;
}


RUN
{  
ALLOCATE CHANNEL c1 DEVICE TYPE disk format '/backup/KMSDB/20180330/Control_and_Spfile_%d_%T_%s_%p';
BACKUP CURRENT CONTROLFILE;
BACKUP SPFILE;
}



------------------------------------------------------------------------
-- Inc backup
------------------------------------------------------------------------
RUN
{  
ALLOCATE CHANNEL c1 DEVICE TYPE disk format '/backup/KMSDB/20180330/arch_%d_%T_%s_%p';  
ALLOCATE CHANNEL c2 DEVICE TYPE disk format '/backup/KMSDB/20180330/arch_%d_%T_%s_%p';  
BACKUP AS COMPRESSED BACKUPSET ARCHIVELOG ALL DELETE ALL INPUT;
}


RUN
{  
ALLOCATE CHANNEL c1 DEVICE TYPE disk format '/backup/TSMDB/20180330/full_incremental_level_1_%d_%T_%s_%p';  
ALLOCATE CHANNEL c2 DEVICE TYPE disk format '/backup/TSMDB/20180330/full_incremental_level_1_%d_%T_%s_%p'; 
BACKUP AS COMPRESSED BACKUPSET INCREMENTAL LEVEL 1 DATABASE PLUS ARCHIVELOG DELETE ALL INPUT;
}


RUN
{  
ALLOCATE CHANNEL c1 DEVICE TYPE disk format '/backup/KMSDB/20180330/Control_and_Spfile_%d_%T_%s_%p';
BACKUP CURRENT CONTROLFILE;
BACKUP SPFILE;
}



------------------------------------------------------------------------
-- Purge backup
------------------------------------------------------------------------
crosscheck backup;
delete noprompt expired backup;