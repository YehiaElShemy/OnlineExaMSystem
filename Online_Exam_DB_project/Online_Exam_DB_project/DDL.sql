Create DataBase Online_Exam_system
use Online_Exam_system
Go
create Schema YMF

--table Deparment
create table YMF.Department(
Dept_Name nvarchar(50) primary Key)

--table Track
create table YMF.Track(
Track_Name nvarchar(50) primary Key)

--course
create table YMF.Courses(
Crs_Id int primary Key identity(1,1),
Crs_Name nvarchar(50) not null ,
Crs_Description nvarchar(max) null ,
Crs_Max_Degree int default 20 ,
Crs_Min_Degree int default 10 );

alter table YMF.Courses
add Constraint CRs_Name_Unique Unique(Crs_Name)

--table Student
create table YMF.Student(
Std_Id int primary Key identity(1,1),
Std_Name nvarchar(50) not null ,
Std_Email nvarchar(50) null ,

 );

alter table YMF.Student
--drop Constraint Std_Name_Unique-- Unique(Std_Name)

--add constraint Std_validation check(Std_Email LIKE '%_@__%.__%')
add constraint Std_validation_Unique Unique(Std_Email )

 alter table Ymf.Student
 add-- Intake_Id int
 constraint Intake_Id_student_FK foreign key (Intake_Id) references YMF.Intake(Intake_Id) on delete cascade on update cascade




SELECT 
    i.name AS ConstraintName,
    OBJECT_NAME(i.object_id) AS TableName,
    c.name AS ColumnName,
    i.type_desc AS ConstraintType
FROM 
    sys.indexes i
INNER JOIN 
    sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
INNER JOIN 
    sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
WHERE 
    i.is_primary_key = 1 OR i.is_unique_constraint = 1
ORDER BY 
    TableName, ConstraintName;


 
   EXEC sp_rename 'YMF.Student.round_number', 'Intake_number', 'COLUMN';

create table YMF.Student_Address(
Std_Id int,
City nvarchar(50) not null ,
street nvarchar(50) null ,
 constraint Std_ID_Adress_Fk foreign key(Std_Id) references YMF.Student(Std_Id)
 );
 ALTER TABLE YMF.Student_Address
 add constraint  Std_ID_Adress_Fk foreign key(Std_Id) references YMF.Student(Std_Id)
 on delete Cascade on update cascade

create table YMF.STudent_Courses(
Std_Id int,
Crs_Id int,
constraint std_ID_Crs_ID_PK primary key(Std_Id,Crs_Id) ,
 constraint Std_ID_Course_Fk foreign key(Std_Id) references YMF.Student(Std_Id),
 constraint Crs_ID_Std_Fk foreign key(Crs_Id) references YMF.Courses(Crs_Id)
)
 
  ALTER TABLE YMF.STudent_Courses 
 add constraint  Std_ID_Course_Fk foreign key(Std_Id) references YMF.Student(Std_Id)
 on delete Cascade on update cascade,
 constraint Crs_ID_Std_Fk foreign key(Crs_Id) references YMF.Courses(Crs_Id)
  on delete Cascade on update cascade



select * from YMf.Student_Exam



 --table Exam
create table YMF.Exam(
Exam_Id int primary Key identity(1,1),
Exam_Name nvarchar(50) not null ,
Eaxm_Type nvarchar(10) check(Eaxm_Type = UPPER('exam') OR Eaxm_Type =UPPER('CORRECTIVE')),
Start_Time time not null,
End_Time time not null ,
  total_time as DATEDIFF(MINUTE, Start_Time, End_Time),-- as float),
  -- CONVERT(time, DATEADD(MINUTE, DATEDIFF(MINUTE, Start_Time, End_Time), '00:00')),
Eaxm_Year int default Year(getDate())
 );
 alter table YMF.Exam
 add constraint Starttime_endTime  CHECK (start_time > end_time)


 alter table YMF.Exam
 add Exam_date date ;

 -- check (Exam_date is not null);
 --ADD CONSTRAINT constraint_name CHECK (YourColumn IS NOT NULL);

 create rule as_not_null
 as @value is not null

 sp_bindrule as_not_null,'[YMF].[Exam].[Exam_date]';

 --drop table YMF.Exam
--table Student_Exam between student and Exam
create table YMF.Student_Exam(
Std_Id int,
Exam_Id int ,
 Constraint Exam_ID_Std_Id_PK primary key(Exam_Id,Std_Id),
 constraint Exam_ID_std_Fk foreign key(Exam_Id) references YMF.Exam(Exam_Id),
 constraint Std_ID_Exam_Fk foreign key(Std_Id) references YMF.Student(Std_Id)
 );
 alter table YMF.Student_Exam
 add 
  constraint Exam_ID_std_Fk foreign key(Exam_Id) references YMF.Exam(Exam_Id)
  on delete cascade on update cascade,
  constraint Std_ID_Exam_Fk foreign key(Std_Id) references YMF.Student(Std_Id)
  on delete cascade on update cascade
  
--add two coulmn to table student Exam

 alter table Ymf.Student_Exam
 add Specific_time date ,Result float

  alter table Ymf.Student_Exam
 add constraint Result_Defualt_value DEFAULT 0 for Result

  alter table YMF.Student_Exam
	add  Status_std varchar(50) null


 select * from YMF.Courses,YMF.Intake_Exam ,YMF.Exam where YMF.Courses.Crs_Id=YMF.Intake_Exam.Crs_Id
 and YMF.Intake_Exam.Exam_Id in(
 select YMF.Exam.Exam_Id from YMF.Student_Exam,YMF.Student,YMF.Exam)

--table Student_EXam_Answer between student and Exam with Answer
drop table YMF. Student_EXam_Answer

create table YMF. Student_EXam_Answer(
Std_Id int,
Q_ID int ,
Exam_Id int ,

Std_Answer nvarchar(255) ,
 Constraint Exam_ID_Std_Id_ans_PK primary key(Exam_Id,Std_Id,Q_ID),
 constraint Exam_ID_std_ans_Fk foreign key(Exam_Id) references YMF.Exam(Exam_Id),
 constraint Std_ID_Exam_ans_Fk foreign key(Std_Id) references YMF.Student(Std_Id),
 constraint Q_ID_Exam_ans_Fk foreign key(Q_ID) references YMF.Question(Q_ID)
 );
 
 alter table YMF.Student_EXam_Answer
 add Question_Degree int default 0

  alter table YMF.Student_EXam_Answer
   add--drop Q_ID_Exam_ans_Fk,Std_ID_Exam_ans_Fk,Exam_ID_std_ans_Fk
    constraint Exam_ID_std_ans_Fk foreign key(Exam_Id) references YMF.Exam(Exam_Id)
    on delete cascade on update cascade,
    constraint Std_ID_Exam_ans_Fk foreign key(Std_Id) references YMF.Student(Std_Id)
    on delete cascade on update cascade,
    constraint Q_ID_Exam_ans_Fk foreign key(Q_ID) references YMF.Question(Q_ID)
    on delete cascade on update cascade


 
 --table Question
 create table YMF.Question
 (
 Q_ID int primary key identity (1,1),
 Q_Content Nvarchar(max) not null,
 Q_type nvarchar(10) not null check(Q_type ='T_F'  OR Q_type ='MCQ' or Q_type='text'),
 Q_degree int not null,
 Q_answer Nvarchar(max) not null
 )
 alter table  YMF.Question
 add Q_ans_A Nvarchar(255)  null,Q_ans_B Nvarchar(255)  null,Q_ans_C Nvarchar(255)  null
 ,Q_ans_D Nvarchar(255)  null

 alter table YMF.Question
  --add Crs_Id int;
  add constraint Question_CRS_ID_FK foreign key (Crs_Id) references YMF.Courses(Crs_Id) 
  ON DELETE CASCADE ON UPDATE  NO ACTION

 alter table Ymf.Question
 drop column Q_degree


 create table YMF.Exam_Question(
 Q_ID int,
 Exam_Id int,
 Constraint Q_ID_Exam_Id__PK primary key(Q_ID,Exam_Id),
 constraint Q_ID_ExamQuestion_Id_Fk foreign key(Q_ID) references YMF.Question(Q_ID),
 constraint Exam_Id_ExamQuestion_Id_Fk foreign key(Exam_Id) references YMF.Exam(Exam_Id)

 )
 alter table YMF.Exam_Question
  drop column Q_Degree --int 

--- alter on Constraint for Exam_Question
alter table YMF.Exam_Question
	drop constraint Q_ID_ExamQuestion_Id_Fk,Exam_Id_ExamQuestion_Id_Fk
alter table YMF.Exam_Question
	add 
 constraint Q_ID_ExamQuestion_Id_Fk foreign key(Q_ID) references YMF.Question(Q_ID)
 on delete cascade on update no action,
 constraint Exam_Id_ExamQuestion_Id_Fk foreign key(Exam_Id) references YMF.Exam(Exam_Id)
 on delete cascade on update no action
 
	 

--alter on schema
alter schema Ymf
transfer Dbo.[Chooses]
alter schema Ymf
transfer Dbo.STudent_Courses


 -- table Instructor
 create table YMF.Instructor(
Inst_Id int primary Key identity(1,1),
Inst_Name nvarchar(50) not null ,
Inst_Email nvarchar(50) null ,
Bch_Name nvarchar(50),
--inst_SUper int ,
constraint Inst_Bch_Fk foreign key(Bch_Name) references YMF.Branch(Bch_Name)
);
 alter table YMF.Instructor
 --add constraint Email_validation check(Inst_Email LIKE '%_@__%.__%')
 add constraint Email_Unique Unique(Inst_Email)

  alter table YMF.Instructor
   add--drop  
constraint Inst_Bch_Fk foreign key(Bch_Name) references YMF.Branch(Bch_Name) on delete cascade on update cascade

alter table YMF.Instructor
add constraint 


 Go
create table YMF.Instructor_Address(
Inst_Id int,
City nvarchar(50) not null ,
street nvarchar(50) null ,
 constraint Inst_ID_Adress_Fk foreign key(Inst_Id) references YMF.Instructor(Inst_Id)
 );
 alter table YMF.Instructor_Address
 add constraint Inst_ID_Adress_Fk foreign key(Inst_Id) 
 references YMF.Instructor(Inst_Id) on delete cascade on update cascade



 GO
 --table branch

create table YMF.Branch(
 bch_Name  Nvarchar(50) primary Key,
 [Location] Nvarchar(50) not null,
 --Inst_Id int,
--constraint Bch_Inst_Fk foreign key(Inst_Id) references YMF.Instructor(Inst_Id) 
 );


 alter table YMF.Branch
 --add -- drop Inst_Id int 
add constraint Bch_Inst_Fk 
foreign key(Inst_Id) references YMF.Instructor(Inst_Id)
on delete cascade on update cascade

Go
 -- table Inake_Exam between Course,instructor, Exam
create table YMF.Inake_Exam
 (
 Inake_Exam_Id int primary key identity (1,1),
 Inst_Id int,
 Exam_Id int,
 Crs_Id int,
 constraint Inst_ID_Intake_Fk foreign key(Inst_Id) references YMF.Instructor(Inst_Id),
 constraint Exam_ID_Exam_Fk foreign key(Exam_Id) references YMF.Exam(Exam_Id),
 constraint Crs_ID_Courses_Fk foreign key(Crs_Id) references YMF.Courses(Crs_Id)
 )
 ------------------------------------
 -- alter on foregin key  Inst_Id , Exam_Id ,Crs_Id

 alter table [YMF].[Intake_Exam]
  add  constraint Inst_ID_Intake_Fk foreign key(Inst_Id) references YMF.Instructor(Inst_Id)
  on delete set null on update cascade,
 constraint Exam_ID_Exam_Fk foreign key(Exam_Id) references YMF.Exam(Exam_Id)
 on delete set null on update cascade,
 constraint Crs_ID_Courses_Fk foreign key(Crs_Id) references YMF.Courses(Crs_Id)
  on delete set null on update cascade

alter table  [YMF].[Intake_Exam]
add --Intake_Id int
constraint Intake_Id_intake_exam_Fk foreign key(Intake_Id) references YMF.Intake(Intake_Id)




  -- table Inake_Dept_Bch_Std_track_INtake_Exam between Branch,Student, Track,intake_Exam,
create table YMF.Intake
(
Intake_number int ,
bch_Name  Nvarchar(50),
Track_Name nvarchar(50),
Dept_Name nvarchar(50),

constraint INtk_Number_bch_Name_Track_Name_Dept_Name
	primary key(Intake_number,bch_Name,Track_Name,Dept_Name),
 constraint bch_Name_Intake_Fk foreign key(bch_Name) references YMF.Branch(bch_Name),
 constraint Track_Name_Intake_Fk foreign key(Track_Name) references YMF.Track(Track_Name),
 constraint Dept_Name_Intake_Fk foreign key(Dept_Name) references YMF.Department(Dept_Name),
-- constraint Inake_Exam_Id_Intake_Fk foreign key(Inake_Exam_Id) references YMF.Inake_Exam(Inake_Exam_Id)
 )
 --add coulmn
 alter table YMF.Intake
add --intake_Year int default Year(getdate());
constraint intake_Year default Year(getdate())



 ----alter on constraint
 alter table YMF.Intake
 --add  Intake_Id INT IDENTITY(1,1);
 add --Intake_Id int;
 constraint Intake_Id_unique_PK unique(Intake_Id) 

  alter table YMF.Intake
add constraint Intake_number_Fk foreign key(Intake_number) references YMF.Intake(Intake_number) on delete cascade on update cascade
  


 drop table YMF.Intake
 alter table YMF.Intake
add constraint bch_Name_Intake_Fk foreign key(bch_Name) references YMF.Branch(bch_Name) on delete cascade on update cascade
  

  alter table YMF.Intake
  add 
 constraint Track_Name_Intake_Fk foreign key(Track_Name) references YMF.Track(Track_Name) on delete cascade on update cascade

 alter table YMF.Intake
 --drop Dept_Name_Intake_Fk
add constraint Dept_Name_Intake_Fk foreign key(Dept_Name) references YMF.Department(Dept_Name) on delete cascade on update cascade


 
 
 --,Track_Name_Intake_Fk,Dept_Name_Intake_Fk

  alter table YMF.Intake
 drop column bch_Name--Track_Name --Dept_Name


  ---change Column Name
 EXEC sp_rename 'YMF.Intake.Rount_number', 'Intake_number', 'COLUMN';
 EXEC sp_rename ' YMF.Intake.Rount_number', 'Intake_number', 'COLUMN';



















