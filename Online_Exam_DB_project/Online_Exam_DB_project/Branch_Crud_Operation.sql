
--store procedure to add Branch

create proc YMF.Add_Branch_PRo(@branch_Name nvarchar(50),@Location nvarchar(50))
as
begin
	IF not EXISTS(select 1 from  YMF.Branch where bch_Name=@branch_Name and Location=@Location)
		begin
			insert into YMF.Branch(bch_Name,Location)
			values(@branch_Name,@Location)
		end
	else
	begin
		select 'branch is exist or incorrect Name';
	end
end

drop proc Add_Branch_PRo
exec YMF.Add_Branch_PRo @branch_Name='mansoura ',@Location='mansoura university';

select * from YMF.Branch
Go

--------------------------------------------------
--store procedure to update branch
create or alter proc YMF.Update_Branch_PRO(@Old_Branch_Name nvarchar(50),@New_branch_Name nvarchar(50),
@old_Location nvarchar(50),@new_Location nvarchar(50)
)
as 
begin 
	IF EXISTS(select 1 from  YMF.Branch where bch_Name= @Old_Branch_Name and Location=@old_Location)
		begin
			
			update YMF.Branch
				set bch_Name=@New_branch_Name,Location=@new_Location
				where bch_Name=@Old_Branch_Name and Location=@old_Location

		end
	else
	begin
		select 'Branch Does not is exist';
	end
end

drop proc YMf.Update_Branch_PRO

exec YMF.Update_Branch_PRO @Old_Branch_Name='minia', @New_branch_Name='miniaa',
@old_Location='Minia_university',@new_Location='Minia_university'

select * from YMF.Branch
Go

select * from YMF.Intake

------------------------------------------------


--store procedure to delete track

create or alter proc YMF.Delete_Branch_PRo(@Delete_Branch_Name nvarchar(50))
as 
begin 
	IF EXISTS(select 1 from  YMF.Branch where bch_Name=@Delete_Branch_Name)
		begin
			delete from YMF.Branch
				where bch_Name=@Delete_Branch_Name
		end
	else
	begin
		select 'Branch Does not is exist';
	end
end

drop proc Delete_Branch_PRo

exec YMF.Delete_Branch_PRo @Delete_Branch_Name='smart'
Go

select * from YMF.Branch
select * from YMF.Intake

GO

------------------------------------------------------------------------------------
-- assign Instructor to Branch as manager

create or alter procedure YMF.Assign_instructor_To_Branch_as_Manager_PRO(@branch_Name nvarchar(50),@inst_Id int)
as 
begin
	IF EXISTS (select 1 from  YMF.Branch where bch_Name=@branch_Name)
	and EXISTS(select 1 from  YMF.Instructor where inst_Id=@inst_Id)
	begin
		update YMF.Branch
		set Inst_Id=@inst_Id
		where bch_Name=@branch_Name
	end
	else
	begin
		print 'branch or instrctor may be not exist'

	end
end

exec YMF.Assign_instructor_To_Branch_as_Manager_PRO @branch_Name='mansoura  ',@inst_Id=5

drop proc Assign_instructor_To_Branch_as_Manager_PRO
Go

select * from YMF.Instructor

select * from YMF.Intake









----------------------------------------------VIEWS Branch---------------------------------------
GO
create View YMF.Show_All_Branch
as
(select * from YMF.Branch)

select bch_Name from YMF.Show_All_Branch 

EXEC sp_helptext 'YMF.branch_manager';


GO
create view YMF.branch_manager
with encryption
as
  select bch.bch_Name as 'Branch Name',inst.Inst_Name as Manager 
  from YMF.Branch as bch,YMF.Instructor as Inst where bch.Inst_Id=inst.Inst_Id



  select * from YMF.branch_manager where [Branch Name] ='Assuit '








