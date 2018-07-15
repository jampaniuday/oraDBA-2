-- returns the database block number for the input ROWID
select DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid) from t;