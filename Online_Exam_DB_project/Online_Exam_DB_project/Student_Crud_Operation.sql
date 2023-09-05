
--store procedure to add Course

create or alter proc YMF.Add_New_Student_PRo(@Std_Name nvarchar(50),@Std_Email nvarchar(50))
as
begin
	IF NOT EXISTS(select 1 from  YMF.Student where Std_Email=@Std_Email )
		begin
			insert into YMF.Student(Std_Name,Std_Email)
			values (@Std_Name,@Std_Email)
		end
	else
	begin
		select 'Student or Email is exist';
	end
end
drop proc YMF.Add_New_Student_PRo

exec YMf.Add_New_Student_PRo @Std_Name='Ahmed',@Std_Email='Ahmed@gmail.com'


select * from YMF.Student
select * from YMF.Track
select * from YMF.Intake
Go

--------------------------------------------------
--store procedure to update instructor
create or alter proc YMF.Update_Student_PRO(@Std_Id int,@Std_Name nvarchar(50),@Std_Email nvarchar(50))
as 
begin 
	IF EXISTS(select 1 from  YMF.Student where Std_Id= @Std_Id)and
		not EXISTS(select 1 from  YMF.Student where Std_Email= @Std_Email)
		begin
			
			update YMF.Student
				set Std_Name=@Std_Name,Std_Email=@Std_Email
				where Std_Id=@Std_Id;

		end
	else
	begin
		select 'Student Does not is exist or Email is exist';
	end
end

drop proc YMF.Update_Student_PRO

exec YMF.Update_Student_PRO @Std_Id=3,@Std_Email='FolyFoly@gmail.com',@Std_Name ='Foly'

select * from YMF.Student
Go

select * from YMF.Intake_Exam

------------------------------------------------



--store procedure to delete student
GO
create or alter proc YMF.Delete_Student_PRo(@Std_ID_Delete int)
as 
begin 
	IF EXISTS(select 1 from  YMF.Student where Std_Id=@Std_ID_Delete)
		begin
			delete from YMF.Student
				where Std_Id=@Std_ID_Delete

				--print 'student Deleted'
		end
	else
	begin
		select 'Student Does not is exist';
	end
end
drop proc YMf.Delete_Student_PRo

exec  YMF.Delete_Student_PRo @Std_ID_Delete=4
Go

select * from YMF.Student
select * from YMF.Intake

GO

------------------------------------------------------------------------------------


--and Track_Name='FullStack Using .Net2'and Dept_Name='SD';

GO

-- assign student to Branch ,department,track
create or alter procedure YMf.Assign_Student_To_Branch_Track_PRO(@student_Id int,@intake_id int)
as 
begin
	IF EXISTS (select 1 from  YMF.Student where Std_Id=@student_Id)
	begin
		update YMF.Student
		set Intake_Id=@intake_id
		where Std_Id=@student_Id
	end
	else
	begin
		print 'student is not exist'

	end
end
go

drop proc YMF.Assign_Student_To_Branch_Track_PRO
exec YMF.Assign_Student_To_Branch_Track_track_PRO @student_Id=1 ,@intake_id=1
select * from YMF.Student
--view Know student info(Branch ,department,track)
 select * from YMF.Branch





 GO
--------------------------------------------------------------------------
--assign Exam to Student
Create or alter Proc YMF.Add_Exam_TO_Student(@std_id int,@Exam_id int,@intake_Id int )
as
begin 

	declare @E_Date date; 
	select @E_Date= Exam_date  from YMF.Exam where Exam_Id=@Exam_id
	if exists(select 1 from YMF.Student_Exam where Exam_id=@Exam_id and Std_Id=@std_id)
	begin
		print 'student Already take this Exam'
	end
	
	else
	begin
	     if exists (select 1 from YMF.Student where Std_Id=@std_id and Intake_Id=@intake_Id)
	    and exists (select 1 from YMF.Exam where Exam_Id=@Exam_id)
	
		begin
	--select @E_Date

		insert into Ymf.Student_Exam(Std_Id,Exam_Id,Specific_time)
		values(@std_id,@Exam_id,@E_Date)

		end
		else
		begin 
		print 'student or exam or intake not Exist  '
		end
	end
	
end

drop proc YMf.Add_Exam_TO_Student

exec YMF.Add_Exam_TO_Student @std_id=6,@Exam_id=1,@intake_Id=21
GO
 
 select * from YMF.Exam
 select * from YMF.student
 select * from YMF.Student_Exam
--
GO


select * from YMF.STudent_Courses

---add student to exam Student _Exam Table
Create Proc Add_Exam_TO_Student(@std_id int,@Exam_id int )
as
begin 

	declare @E_Date date; 
	select @E_Date= Exam_date  from YMF.Exam where Exam_Id=@Exam_id
	--select @E_Date
	if Exists(select 1 from YMF.Exam where Exam_Id=@Exam_id)
	and Exists(select 1 from YMF.Student where Std_Id=@std_id)
	begin
	insert into Ymf.Student_Exam(Std_Id,Exam_Id,Specific_time)
	values(@std_id,@Exam_id,@E_Date)
	end
	else 
	begin
		print 'student Or Exam not exist'
	end


	--view to return Students and his courses
	--select s.Std_Name,c.Crs_Name from YMF.Student as s,[YMF].[STudent_Courses] as SC ,YMF.Courses as C
	--where SC.[Std_Id]=s.Std_Id and SC.Crs_Id=C.Crs_Id

end
GO
drop proc Add_Exam_TO_Student

exec Add_Exam_TO_Student @std_id=1 ,@Exam_id=8; 

drop proc Add_Exam_TO_Student

select * from  Ymf.exam





--store procedure to specific Couser to Student
---and i see this is not important

create or alter proc YMF.Specific_Course_to_Student(@Std_id int ,@Crs_id int )
as 
begin 
	if exists (select 1 from YMF.Student where Std_Id=@Std_id )
	insert into YMF.STudent_Courses(Std_Id,Crs_Id)
	values(@Std_id,@Crs_id)
end

drop proc YMF.Specific_Course_to_Student

select * from Ymf.STudent_Courses

exec YMF.Specific_Courses_to_Student @Std_id=1 ,@Crs_id=2 

drop proc Specific_Courses_to_Student


------ procdure to insert data into student Address table---------------
go
create or alter proc YMF.add_student_address_Pro (@Std_Id int ,@City nvarchar(50),@street nvarchar(50))
as
begin
	If Exists(select 1 from ymf.Student where Std_Id=@Std_Id)
	and not Exists(select 1 from ymf.Student_Address where Std_Id=@Std_Id)
		begin
			insert into ymf.Student_Address
			values(@Std_Id,@City,@street)
		end
	else
		begin
			print'Student Not exists'
		end
end

drop proc add_student_address_Pro
exec YMF.add_student_address_Pro @Std_Id=1,@City='Assuit',@street='khaled enb el waleed'

select * from YMF.Student_Address




------------------------------------------------------
------------store procedure to add student  with intake---------------------------
Go
create proc YMF.Add_Student_PRo(@Std_Name nvarchar(50),@Std_Email nvarchar(50),@Intake_Id int)
as
begin
	IF NOT EXISTS(select 1 from  YMF.Student where Std_Email=@Std_Email )
	   and Exists(select 1 from ymf.Intake where Intake_Id=@Intake_Id)
		begin
			insert into YMF.Student(Std_Name,Std_Email,Intake_Id)
			values (@Std_Name,@Std_Email,@Intake_Id)
		end
	else
		begin
			select 'Student or Email is exist or intake not exists';
		end
end
GO
drop proc Add_Student_PRo










-----------------------------------------VIEW FOR STUdent------------------------------------------

GO
--view to display all student

create view YMF.Display_All_Student
as 
	select * from Ymf.Student 

	--view to show all student and his exams -- student have premistion
Go
create  view YMF.All_Student_exams
with encryption
as
select s.Std_Id, s.Std_Name,e.Exam_Name,e.Eaxm_Type,e.Exam_date,e.total_time,se.Specific_time,e.Exam_Id 
from Ymf.Student as s,Ymf.Student_Exam as se,YMF.Exam as e
where se.Std_Id=s.Std_Id and se.Exam_Id=e.Exam_Id;

select * from YMF.All_Student_exams
drop view YMF.All_Student_exams
Go
--view to select exam for student








--- view to Display Student Course!


GO
--view Diplay student and his Courses and name of track and branch

create View YMF.Display_student_and_his_Courses_and_name_of_track_and_branch
as
select s.Std_Id, s.Std_Name,c.Crs_Name,I.bch_Name,I.Track_Name,I.Dept_Name,I.Intake_number
from Ymf.Student as s ,YMF.Intake as I ,Ymf.Intake_Exam as IE,YMF.Courses as C
where s.Intake_Id=I.Intake_Id and IE.Intake_Id=I.Intake_Id and IE.Crs_Id=c.Crs_Id

drop view YMF.Display_student_and_his_Courses_and_name_of_track_and_branch
select * from  YMF.Display_student_and_his_Courses_and_name_of_track_and_branch where std_id=12;

GO