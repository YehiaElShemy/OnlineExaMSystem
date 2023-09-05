
--store procedure to add department

create or alter proc YMf.Add_DepartMent_PRo(@Dept_Name nvarchar(50))
as
begin
	IF not EXISTS(select 1 from  YMF.Department where Dept_Name=@Dept_Name)
		begin
			insert into YMF.Department(Dept_Name)
			values(@Dept_Name)
		end
	else
	begin
		select 'Department is exist';
	end
end

drop proc Add_DepartMent_PRo
exec YMF.Add_DepartMent_PRo @Dept_Name='HR'


--view to select all department

select * from YMF.Department
Go
--------------------------------------------------
--store procedure to update department
create or alter proc YMF.Update_Department(@Old_Dept_Name nvarchar(50),@New_Dept_Name nvarchar(50))
as 
begin 
	IF EXISTS(select 1 from  YMF.Department where Dept_Name=@Old_Dept_Name)
		begin
			update YMF.Department
				set Dept_Name=@New_Dept_Name
				where Dept_Name=@Old_Dept_Name
		end
	else
	begin
		select 'Department Does not is exist';
	end
end

exec YMF.Update_Department @Old_Dept_Name='SD2', @New_Dept_Name='SD'

drop proc Update_Department

select * from YMF.Department
select * from YMF.Intake

Go
------------------------------------------------



--store procedure to delete department

create or alter proc YMf.Delete_Department(@Delete_Dept_Name nvarchar(50))
as 
begin 
	IF EXISTS(select 1 from  YMF.Department where Dept_Name=@Delete_Dept_Name)
		begin
			delete from YMF.Department
				where Dept_Name=@Delete_Dept_Name
		end
	else
	begin
		select 'Department Does not is exist';
	end
end


drop proc Delete_Department
exec YMF.Delete_Department @Delete_Dept_Name='hr'
Go


---------------------------------------------------------View Department---------------------------------


GO
create View YMF.Show_All_Department
with encryption
as
select * from YMF.Department

select * from YMF.Show_All_Department 

EXEC sp_helptext 'YMF.branch_manager';

drop view YMF.Show_All_Department

