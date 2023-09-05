--store procedure to insert Exam

--is found in Exam File
/*
alter Proc pro_Create_Exam (@inst_id int,@crs_id int,@Type_Exam nvarchar(10),
@Exam_Name nvarchar(50)	, @Start_time time,@End_time time,@Exam_Date date)
 as
begin
	declare @Exam_Id int;
	insert into [YMF].[Exam] (Eaxm_Type,Exam_Name,Start_Time,End_Time,Exam_Date)
	values(@Type_Exam,@Exam_Name,@Start_time ,@End_time,@Exam_Date);
	select @Exam_Id= max(Exam_Id) from YMF.Exam
	--select @Exam_Id
	insert into [YMF].[Intake_Exam] (Inst_Id,Crs_Id,Exam_Id)
	values(@inst_id ,@crs_id ,@Exam_Id)	

 end

 exec pro_Create_Exam @inst_id =6,@crs_id=1,@Type_Exam ='exam',
@Exam_Name ='network', @Start_time='09:00',@End_time	='11:00',@Exam_Date='08-27-2023'
select * from Ymf.Exam
select * from Ymf.Intake_Exam

*/





--creation of proc that create question manual to specific exam and insert it in question table
--check on type of Question
/*
create proc create_question(@exam_id int,@Q_Content nvarchar(max),@Q_Type nvarchar(10) 
,@Q_Degree int , @Q_answer	nvarchar(255),@Q_ans_A nvarchar(255) = null ,@Q_ans_B nvarchar(255)=null,	
@Q_ans_C nvarchar(255)=null,@Q_ans_D nvarchar(255)=null)
as
begin
	declare @Q_id int;
	--declare @Qestion_type nvarchar(10);
	if(@Q_Type='T_F')
		begin
		insert into ymf.Question(Q_Content,Q_type,Q_degree,Q_answer,Q_ans_A,Q_ans_B,Q_ans_C,Q_ans_D)
		values(@Q_Content,@Q_Type,@Q_Degree,@Q_answer,'true','false',@Q_ans_C,@Q_ans_D)
		end
	else if(@Q_Type='MCQ')
		begin
			if(@Q_answer=@Q_ans_A or @Q_answer=@Q_ans_B or @Q_answer=@Q_ans_C or @Q_answer=@Q_ans_D)
				begin
					insert into ymf.Question(Q_Content,Q_type,Q_degree,Q_answer,Q_ans_A,Q_ans_B,Q_ans_C,Q_ans_D)
					values(@Q_Content,@Q_Type,@Q_Degree,@Q_answer,@Q_ans_A,@Q_ans_B,@Q_ans_C,@Q_ans_D)
				end
			else
				begin
					select 'Chooses do not contain the Right Answer';
				end
		end
	else
		begin
			insert into ymf.Question(Q_Content,Q_type,Q_degree,Q_answer,Q_ans_A,Q_ans_B,Q_ans_C,Q_ans_D)
			values(@Q_Content,@Q_Type,@Q_Degree,@Q_answer,@Q_ans_A,@Q_ans_B,@Q_ans_C,@Q_ans_D)				
		end
		select @Q_id= max(Q_ID) from YMF.Question
		
		insert into ymf.Exam_Question(Q_ID,Exam_Id)
		values(@Q_id,@exam_id)
		
end


exec create_question @exam_id=5,@Q_Content='ipv6 is 128 bit',@Q_Type='T_F' 
,@Q_Degree=2 , @Q_answer='true'
---------------------------------------------------------

*/


-- store Procedure to Access Student to Exam
/*
Create Proc Add_Exam_TO_Student(@std_id int,@Exam_id int )
as
begin 

	declare @E_Date date; 
	select @E_Date= Exam_date  from YMF.Exam where Exam_Id=@Exam_id
	--select @E_Date

	insert into Ymf.Student_Exam(Std_Id,Exam_Id,Specific_time)
	values(@std_id,@Exam_id,@E_Date)


	--view to return Students and his courses
	--select s.Std_Name,c.Crs_Name from YMF.Student as s,[YMF].[STudent_Courses] as SC ,YMF.Courses as C
	--where SC.[Std_Id]=s.Std_Id and SC.Crs_Id=C.Crs_Id

end
GO
drop proc Add_Exam_TO_Student

exec Add_Exam_TO_Student @std_id=3 ,@Exam_id=8; 

select * from  Ymf.Student_Exam
*/

---view ---NAme of student and his exam and Specific time-
select s.Std_Name,e.Exam_Name,se.Specific_time 
from Ymf.Student as s ,Ymf.Student_Exam as se ,Ymf.Exam as e
where s.Std_Id=se.Std_Id and se.Exam_Id=e.Exam_Id
-----------------------------------------------


--view select Exam Name and Course Name
select e.Exam_Name,c.Crs_Name from Ymf.Exam as e,Ymf.Intake_Exam as YE,YMF.Courses as C
where YE.Exam_Id=e.Exam_Id and YE.Crs_Id=c.Crs_Id

select * from Ymf.Student_Exam
GO





--store procedure to specific Couser to Student
/*
-- is found in student file
create proc Specific_Cousrse_to_Student(@Std_id int ,@Crs_id int )
as 
begin 
	insert into YMF.STudent_Courses(Std_Id,Crs_Id)
	values(@Std_id,@Crs_id)
end

select * from Ymf.STudent_Courses

exec Specific_Cousrse_to_Student @Std_id=1 ,@Crs_id=2 

*/
select * from YMF.Student
select * from YMF.Intake
select * from [YMF].[Intake_Exam]
select * from YMF.Courses

 



--view Display student and His Courses
select c.Crs_Name,s.Std_Name from Ymf.Courses as c,YMF.STudent_Courses as SC,Ymf.Student as s
where  sc.Crs_Id=c.Crs_Id and sc.Std_Id=s.Std_Id and c.Crs_Name='C#';




--view Display 
select count(c.Crs_Name) as number_of_Courses,s.Std_Name from Ymf.Courses as c,YMF.STudent_Courses as SC,Ymf.Student as s
where  sc.Crs_Id=c.Crs_Id and sc.Std_Id=s.Std_Id and s.Std_Name='yehia'
group by s.Std_Name





--specific department and branch ans track to specific intake
Go
create proc Add_Intake(@intake_number int,@Dept_Name nvarchar(50),@Track_Name nvarchar(50),
@Branch_Name nvarchar(50)) as
begin
declare @asd nvarchar(50);
	--must be in Dept,branch,track is exist
	-- begin tran add_intake
	IF EXISTS (select 1 from  YMF.Department where Dept_Name=@Dept_Name)
	and EXISTS(select 1 from  YMF.Track where Track_Name=@Track_Name) 
	and EXISTS(select 1 from  YMF.Branch where bch_Name=@Branch_Name)
	begin 
		insert into YMF.Intake([Intake_number],[Dept_Name],[Track_Name],[bch_Name])
		values(@intake_number,@Dept_Name,@Track_Name,@Branch_Name)
	end
	--save tran add_intake
	else
	begin
		print 'incorrect inserted'
	end

	declare @Last_Intake_inserted int ;
	select * from YMF.Intake where Intake_number=@intake_number

end

drop proc Add_Intake

exec  Add_Intake @intake_number=43 ,@Dept_Name='SD' ,@Track_Name ='FullStack Using .Net2',
@Branch_Name='smart';
select * from YMF.Department
select * from YMF.Branch
select * from YMF.Track
select * from YMF.Track




------------------------------------------------------------------------------------------------
