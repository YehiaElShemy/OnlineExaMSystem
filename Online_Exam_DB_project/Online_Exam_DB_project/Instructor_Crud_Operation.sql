


--store procedure to add instructor

create or alter proc YMF.Add_New_Instructor_PRo(@Inst_Name nvarchar(50),@Inst_Email nvarchar(50))
as
begin
	IF NOT EXISTS(select 1 from  YMF.Instructor where Inst_Email=@Inst_Email )
		begin
			insert into YMF.Instructor(Inst_Name,Inst_Email)
			values (@Inst_Name,@Inst_Email) 
		end
	else
	begin
		select ' Email is exist or incorrect';
	end
end
drop proc YMF.Add_New_Instructor_PRo

exec YMF.Add_Instructor_PRo @Inst_Name='ali mohamed',@Inst_Email='Alimohamed@gmail.com'


select * from YMF.Instructor
Go

--------------------------------------------------
--store procedure to update instructor
create or alter proc YMF.Update_Instructor_PRO(@Inst_Id int,@Inst_Name nvarchar(50),@Inst_Email nvarchar(50))
as 
begin 
	IF EXISTS(select 1 from  YMF.Instructor where Inst_Id= @Inst_Id)and
		not EXISTS(select 1 from  YMF.Instructor where Inst_Email= @Inst_Email)
		begin
			
			update YMF.Instructor
				set Inst_Name=@Inst_Name,Inst_Email=@Inst_Email
				where Inst_Id=@Inst_Id;

		end
	else
	begin
		select 'instructor Does not is exist or Email is exist';
	end
end

drop proc YMF.Update_Instructor_PRO

exec YMf.Update_Instructor_PRO @Inst_Id=10,@Inst_Email='Sara@gmail.com',@Inst_Name ='sara'

select * from YMF.Instructor
Go

select * from YMF.Intake_Exam

------------------------------------------------



--store procedure to delete instructor

create or alter proc YMF.Delete_instructor_PRo(@Inst_ID_Delete int)
as 
begin 
	IF EXISTS(select 1 from  YMF.Instructor where Inst_Id=@Inst_ID_Delete)
		begin
			delete from YMF.Instructor
				where Inst_Id=@Inst_ID_Delete
		end
	else
	begin
		select 'Instuctor Does not is exist';
	end
end

drop proc Delete_instructor_PRo

exec  YMF.Delete_instructor_PRo @Inst_ID_Delete=10
Go

select * from YMF.Instructor
select * from YMF.Intake

GO

------------------------------------------------------------------------------------

-- assign Instructor to Branch as Empolyee

create or alter procedure YMF.Assign_instructor_To_Branch_as_Employee_PRO(@branch_Name nvarchar(50),@inst_Id int)
as 
begin
	IF EXISTS (select 1 from  YMF.Branch where bch_Name=@branch_Name)
	and EXISTS(select 1 from  YMF.Instructor where inst_Id=@inst_Id)
	begin
		update YMF.Instructor
		set Bch_Name=@branch_Name
		where Inst_Id=@inst_Id
	end
	else
	begin
		print 'branch or instrctor may be not exist'

	end
end


drop proc Assign_instructor_To_Branch_as_Employee_PRO

exec YMF.Assign_instructor_To_Branch_as_Employee_PRO @branch_Name='Assuit',@inst_Id=8
select * from YMF.Instructor
select * from YMF.Branch
GO
---------------------------------------------------------
--assigin instructor to course in Intake_Exam


Create or alter proc YMF.Assign_Instructor_To_Course(@inst_Id int,@Crs_Id int)
as 
begin
		IF EXISTS (select 1 from  YMF.Courses where Crs_Id=@Crs_Id)
	    and EXISTS(select 1 from  YMF.Instructor where inst_Id=@inst_Id)
		begin 
			insert into Ymf.Intake_Exam(Crs_Id,Inst_Id)
			values(@Crs_Id,@inst_Id)
		end

		else 
		begin
			print 'Course or Instructor not Exist';
		end
end
GO

drop proc Assign_Instructor_To_Course

exec YMF.Assign_Instructor_To_Course @inst_Id=8 ,@Crs_Id=4
select * from YMF.Instructor
select * from YMF.Courses
select * from YMF.Intake_Exam



-----------------------------------------------------------
GO
----------------- insert data into instructor Address table----------------------
create or alter proc YMF.add_instructor_address_Pro (@Ins_Id int ,@City nvarchar(50),@Street nvarchar(50))
as
begin
	If Exists(select 1 from ymf.Instructor where Inst_Id=@Ins_Id)
	and not Exists(select 1 from ymf.Instructor_Address where Inst_Id=@Ins_Id)
		begin
			insert into ymf.Instructor_Address
			values(@Ins_Id,@City,@Street)
		end
	else
		begin
			print'Instructor Not exists'
		end
end
drop proc YMF.add_instructor_address_Pro
exec YMF.add_instructor_address_Pro @Ins_Id=5,@city='assuit',@Street='mohamed ali'

GO









-------------------------------store procedure to add instructor--------------------

create  or alter proc YMF.Add_Instructor_PRo(@Inst_Name nvarchar(50),@Inst_Email nvarchar(50),@branch_Name nvarchar(50))
as
begin
	IF NOT EXISTS(select 1 from  YMF.Instructor where Inst_Email=@Inst_Email )
		begin
			insert into YMF.Instructor(Inst_Name,Inst_Email,Bch_Name)
			values (@Inst_Name,@Inst_Email,@branch_Name) 
		end
	else
		begin
			select ' Email is exist or incorrect';
		end
end
drop proc Add_Instructor_PRo
select * from YMF.Instructor



------------------------------------------VIEWS INSTRUCTOR---------------------------------------


-- view to select instructor Name,Questions,Exam
GO
create or alter view YMF.Dispay_instructor_Question_Exam
as

select IE.Exam_Id,Inst.Inst_Name,Q.Q_Content,e.Eaxm_Type,e.Exam_Name,e.total_time 
from YMF.Instructor as Inst ,YMF.Intake_Exam as IE , YMF.Exam  as e,
Ymf.Exam_Question as EQ,YMF.Question  as Q
where IE.Inst_Id=inst.Inst_Id and IE.Exam_Id=e.Exam_Id and 
EQ.Exam_Id=e.Exam_Id and EQ.Q_ID=Q.Q_ID


drop view Dispay_instructor_Question_Exam