--insert SampleData to Courses Table

insert into YMF.Courses
values
('C#','High Level Language',20,10),('Java','High Level Language',20,10),('C++','High Level Language',20,10)

--insert SampleData to Department Table
insert into YMF.Department
values
('SD'),('Testing'),('HR'),('IT')

--insert SampleData to Track Table
insert into YMF.Track
values
('FullStack Using .Net'),('FullStack Using .Python'),('FullStack Using .Mern'),('system admin')

--insert SampleData to Exam Table

insert into YMF.Exam(Exam_Name,Eaxm_Type,Start_Time,End_Time) 
values('OS','exam','12:00','14:00')

select * from YMF.Exam
 DBCC CHECKIDENT ('YMF.Exam',reseed,0)

delete from YMF.Exam where Exam_Id=6;

Insert into Ymf.Question
values
('int x=1'+'  '+'x++'+'  '+'x=2','T_F',2,'true'),
('int x=1'+'  '+'x--'+'  '+'x=2','T_F',2,'false'),
('ipv4 is 4 byte','T_F',2,'true')

select * from YMF.Question


DBCC CHECKIDENT ('YMF.Question',reseed,0)

insert into Ymf.Chooses(Q_ID,Q_ans_A,Q_ans_B)
values(1,'true','false'),
(2,'true','false'),
(3,'true','false')

select * from YMF.chooses

select * from YMF.Exam_Question

select *from Ymf.Exam

insert into Ymf.Student 
values('yehia','yehia@gmail.com ')
,('Mahmoude','Mahmoud@gmail.com ')
,('Foly','Foly@gmail.com ')

select * from Ymf.Student

insert into Ymf.Student_Address
values(1,'Assuit','KhaledEbnElwaleed')
,(2,'Sohag','11 central')
,(3,'Minia','5 Funny ')



insert into YMF.Student_Exam(Exam_Id,Std_Id,Specific_time)
values(4,1,'08-26-2023'),
(4,2,'08-26-2023')
,(5,3,'08-26-2023')
select * from Ymf.Student_Exam


insert into YMF.Student_EXam_Answer(Std_Id,Q_ID,Exam_Id,Std_Answer)
values(1,1,4,'true'),(1,2,4,'true'),(1,3,4,'true')

select * from Ymf.Student_EXam_Answer


insert into YMF.Instructor(Inst_Name,Inst_Email,Bch_Name)
values('Ali','Ali@gmail.com','minia'),
('marihan','marihan@gmail.com','minia'),
('Ahmed Mammdoh','marihan@gmail.com','assuit')
delete from YMF.Instructor
select * from YMF.Instructor
 
insert into Ymf.Instructor_Address
values(5,'Minia','KhaledEbnElwaleed')
,(6,'Minia','taha hussien')
,(7,'asuuit','ferial ')
delete from YMF.Instructor_Address

select * from Ymf.Instructor_Address

insert into Ymf.Branch(bch_Name,Location)
values('minia','Minia_university'),
('Assuit','Assuit_university')
delete from YMF.Branch
select * from YMF.Branch
update Ymf.Branch 
set Inst_Id=6
where
bch_Name='minia'


update Ymf.Branch 
set Inst_Id=7
where
bch_Name='Assuit'


insert into YMf.Intake_Exam(Inst_Id,Exam_Id,Crs_Id)
values(6,4,1),(7,5,1)

 DBCC CHECKIDENT ('YMF.Intake_Exam',reseed,0)


insert into YMf.Intake(Intake_number,bch_Name,Track_Name,Dept_Name)
values(43,'minia','FullStack Using .Net','SD')

select * from YMF.Student as s ,Ymf.Intake as i
where i.Std_Id=s.Std_Id

select * from YMF.Department

insert into [YMF].[STudent_Courses]
values(1,1),(2,1),(3,2),(2,3),(1,3)






