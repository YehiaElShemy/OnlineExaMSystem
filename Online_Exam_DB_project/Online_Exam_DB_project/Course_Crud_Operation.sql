
--store procedure to add Course

create or alter proc YMF.Add_Course_PRo(@Crs_Name nvarchar(50),@Crs_Description nvarchar(50),
@Crs_Min_Degree	int,@Crs_Max_Degree int)
as
begin
	IF NOT EXISTS(select 1 from  YMF.Courses where Crs_Name=@Crs_Name )
		begin
			insert into YMF.Courses(Crs_Name,Crs_Description,Crs_Min_Degree,Crs_Max_Degree)
			values (@Crs_Name,@Crs_Description,@Crs_Min_Degree	,@Crs_Max_Degree) 
		end
	else
	begin
		select 'Courses is exist';
	end
end
drop proc YMF.Add_Course_PRo

exec YMF.Add_Course_PRo @Crs_Name='Python',@Crs_Description='langauge use to machine learning',
@Crs_Min_Degree=10	,@Crs_Max_Degree=20

select * from YMF.Courses
Go

--------------------------------------------------
--store procedure to update Course
create or alter proc YMF.Update_Course_PRO(@Crs_Id int,@Crs_Name nvarchar(50),@Crs_Description nvarchar(50),
@Crs_Min_Degree	int,@Crs_Max_Degree int )
as 
begin 
	IF EXISTS(select 1 from  YMF.Courses where Crs_Id= @Crs_Id)
		begin
			
			update YMF.Courses
				set Crs_Name=@Crs_Name,Crs_Description=@Crs_Description,
					Crs_Min_Degree=@Crs_Min_Degree,Crs_Max_Degree=Crs_Max_Degree
				where Crs_Id=@Crs_Id;

		end
	else
	begin
		select 'course Does not is exist';
	end
end

drop proc YMF.Update_Course_PRO

exec YMF.Update_Course_PRO @Crs_Id=1,@Crs_Name='C#' ,@Crs_Description ='not full programming',
@Crs_Min_Degree	=15,@Crs_Max_Degree =20 

select * from YMF.Courses
Go

select * from YMF.Intake_Exam

------------------------------------------------



--store procedure to delete course

create or alter proc YMF.Delete_Course_PRo(@Crs_ID_Delete int)
as 
begin 
	IF EXISTS(select 1 from  YMF.Courses where Crs_Id=@Crs_ID_Delete)
		begin
			delete from YMF.Courses
				where Crs_Id=@Crs_ID_Delete
		end
	else
	begin
		select 'Course Does not is exist';
	end
end

 drop proc YMf.Delete_Course_PRo

exec Delete_Course_PRo @Crs_ID_Delete=5
Go

select * from YMF.Courses
select * from YMF.Intake

GO

------------------------------------------------------------------------------------


-------------------------------------View Courses------------------------------------

create View YMF.Show_all_Courses
	with encryption 
	as 
		select * from YMF.Courses

		drop view Show_all_Courses
		select * from YMF.Show_all_Courses
Go
--- view to display courses at any track
create View YMF.Display_Courses_To_Track
	with encryption 
	as
		select I.bch_Name,I.Track_Name,I.Intake_number,I.Dept_Name,C.Crs_Name from YMF.Courses as C,YMF.Intake_Exam as IE,YMF.Intake as I
			where IE.Crs_Id=C.Crs_Id and IE.Intake_Id=I.Intake_Id

		drop view YMF.Display_Courses_To_Track

select * from YMF.Display_Courses_To_Track


--- view to display courses with instructor
GO
create View YMF.Display_Courses_To_Instructor
	with encryption 
	as
		select Inst.Inst_Name,Inst.Inst_Email,C.Crs_Name,C.Crs_Min_Degree,C.Crs_Max_Degree from
		YMF.Courses as C,YMF.Intake_Exam as IE,YMF.Instructor as Inst
			where IE.Crs_Id=C.Crs_Id and IE.Inst_Id =Inst.Inst_Id

Go
	select Inst_Name,Inst_Email from YMf.Display_Courses_To_Instructor

select * from YMf.Intake_Exam

GO
---view to Display Questions for Courses
create View YMF.Display_Questions_for_Courses
With encryption
as
	select C.Crs_Name,Q.Q_Content,Q.Q_ans_A,Q.Q_ans_B,Q.Q_ans_C,Q.Q_ans_D from YMF.Courses as C,YMF.Question as Q
	WHERE Q.Crs_Id=C.Crs_Id


	select * from YMF.Display_Questions_for_Courses
GO





