
alter database Online_Exam_system
on 
(
	Name ='Online_Exam_system',
	FileName = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Online_Exam_system.mdf',
	Size = 8MB,
	Maxsize = unlimited,
	filegrowth = 8MB
),
(
	Name ='Online_Exam_systemfile2',
	FileName = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Online_Exam_systemfile2.ndf',
	Size = 8MB,
	Maxsize = unlimited,
	filegrowth = 8MB
)
LOG on
(
	Name ='Online_Exam_system_log',
	FileName = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Online_Exam_system_loge.ldf',
	Size = 8MB,
	Maxsize = 50MB,
	filegrowth = 8MB
)

alter database Online_Exam_system
add filegroup Secondary

alter database Online_Exam_system
add file
(
	Name ='Online_Exam_systemfile3',
	FileName = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\EOnline_Exam_systemfile3.ndf',
	Size = 8MB,
	Maxsize = unlimited,
	filegrowth = 8MB
) to filegroup Secondary