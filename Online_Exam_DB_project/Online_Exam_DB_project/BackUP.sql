

  select name,recovery_model_desc  ---  kind of recovery Model for all database
  from master.sys.databases

  --full recovery model tell SQL Server to Keep all transaction
  --data in the transaction log  until either a transaction log 
  --back up occures or the transaction log is truncated.

  alter database Online_Exam_system
  set recovery full --simple;--convert from full recovery to simple recovery

BACKUP DATABASE Online_Exam_system
TO DISK = 'E:\ITI 3 Month .Net full stack\SQL\Project\ProjectDb\BackUP\Online_Exam_system.bak'
WITH NOINIT,--muti-backup , option to append to the existing backup file.
NAME = 'Online_Exam_system-Full Database Backup';
/*
WITH INIT,--1-The INIT option appends to the existing backup on a file
			--2-option to overwrite the backup 
NAME = 'HR-Full Database Backup';
*/

RESTORE HEADERONLY   
FROM DISK = 'E:\ITI 3 Month .Net full stack\SQL\Project\ProjectDb\BackUP\Online_Exam_system.bak';



--drop database Online_Exam_system 
--restore database
RESTORE DATABASE Online_Exam_system
FROM DISK = 'E:\ITI 3 Month .Net full stack\SQL\Project\ProjectDb\BackUP\Online_Exam_system.bak'
WITH FILE = 1, NORECOVERY;;




BACKUP DATABASE Online_Exam_system 
TO DISK = 'E:\ITI 3 Month .Net full stack\SQL\Project\ProjectDb\BackUP\Online_Exam_system.bak'
WITH DIFFERENTIAL,
NAME = 'Online_Exam_system-Differential Database Backup';



RESTORE HEADERONLY   
FROM DISK = '\E:\ITI 3 Month .Net full stack\SQL\Project\ProjectDb\BackUP\Online_Exam_system.bak';

drop database Online_Exam_system
--restore differntial

RESTORE DATABASE hr
FROM DISK = 'E:\ITI 3 Month .Net full stack\SQL\Project\ProjectDb\BackUP\Online_Exam_system.bak'
WITH FILE = 2-- NORECOVERY;




BACKUP LOG Online_Exam_system
TO DISK = 'E:\ITI 3 Month .Net full stack\SQL\Project\ProjectDb\BackUP\Online_Exam_system.bak'
WITH  NAME = 'Online_Exam_system-Transaction Log Backup';

RESTORE LOG Online_Exam_system
FROM DISK = 'E:\ITI 3 Month .Net full stack\SQL\Project\ProjectDb\BackUP\Online_Exam_system.bak'
WITH FILE = 5, RECOVERY;