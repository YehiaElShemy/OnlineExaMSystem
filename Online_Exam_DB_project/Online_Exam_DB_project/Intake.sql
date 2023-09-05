Go
create or alter proc YMF.Add_Intake(@intake_number int,@Dept_Name nvarchar(50),@Track_Name nvarchar(50),
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


end

drop proc YMF.Add_Intake

exec  YMF.Add_Intake @intake_number=43 ,@Dept_Name='SD' ,@Track_Name ='FullStack Using .Net2',
@Branch_Name='smart';
select * from YMF.Department
select * from YMF.Branch
select * from YMF.Track
select * from YMF.Track
GO

----edit  intake--
--delete  intake--

--assign Course to intake

GO
create or alter proc YMF.Assign_Course_To_Intake(@intake_Id int,@Crs_Id int,@Inst_Id int)
as 
begin
	if exists (select 1 from YMF.Courses where Crs_Id=@Crs_Id)
	and exists(select 1 from YMF.Instructor where Inst_Id=@Inst_Id)
	begin
	
	update YMF.Intake_Exam
	set Intake_Id=@intake_Id
	where Crs_Id=@Crs_Id and Inst_Id=@Inst_Id;
	end
	else
	begin
		print 'Instructor Or Crouse Not Exist'
	end
end

drop proc Assign_Course_To_Intake

exec YMF.Assign_Course_To_Intake @intake_Id=1,@Crs_Id=1,@Inst_Id=11

select *from Ymf.Intake_Exam
select *from Ymf.Intake

t
