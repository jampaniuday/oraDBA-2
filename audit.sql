-- see database audit
SELECT * FROM dba_audit_trail;


show parameter audit_trail;


SELECT userid, action#, STATEMENT, OBJ$NAME, To_Char (timestamp#, 'mm/dd/yyyy hh24:mi:ss') 
FROM sys.aud$ 
ORDER BY timestamp# asc;


SELECT * from AUDIT_ACTIONS;


ALTER SYSTEM SET audit_trail=DB, EXTENDED SCOPE=SPFILE;
