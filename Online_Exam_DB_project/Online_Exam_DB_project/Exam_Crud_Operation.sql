--store procedure to insert Exam
Create or alter Proc YMF.pro_Create_Exam (@inst_id int,@crs_id int,@Type_Exam nvarchar(10),
	@Exam_Name nvarchar(50)	, @Start_time time,@End_time time,@Exam_Date date)
 as
begin
      declare @Current_Date date;
	SELECT @Current_Date=GETDATE();
   select @Current_Date
	--select @Exam_Date
	--if(@Current_Date <'08-31-2023')
	--begin
	--print 'sucess'
	--end

	IF EXISTS(select 1 from YMF.Intake_Exam where Inst_Id=@inst_id and Crs_Id=@crs_id )
	and (@Current_Date < @Exam_Date)
    	begin
			declare @Exam_Id int;
			insert into [YMF].[Exam] (Eaxm_Type,Exam_Name,Start_Time,End_Time,Exam_Date)
			values(@Type_Exam,@Exam_Name,@Start_time ,@End_time,@Exam_Date);
			select @Exam_Id= max(Exam_Id) from YMF.Exam
	--select @Exam_Id
				update YMF.Intake_Exam
	     		set Exam_Id=@Exam_Id
				where Inst_Id=@inst_id and Crs_Id=@crs_id
		end
		else
			begin
				print 'instructor may be do not  have this Course or Exam Date must be greater than the current Date ';
			end
end

 drop proc YMF.pro_Create_Exam

 exec YMF.pro_Create_Exam @inst_id =8,@crs_id=4,@Type_Exam ='corrective',
@Exam_Name ='network', @Start_time='09:00',@End_time	='11:00',@Exam_Date='08-27-2023'

select * from Ymf.Exam
select * from Ymf.Intake_Exam




------------------------------------------------------------------
GO
--update Exam for Specific Insturctor and must be teach this Course;
Create or alter Proc YMF.Update_Exam_PRO (@Exam_Id int,@inst_id int,@crs_id int,@Type_Exam nvarchar(10),
@Exam_Name nvarchar(50)	, @Start_time time,@End_time time,@Exam_Date date)
 as
begin
	
	IF EXISTS(select 1 from YMF.Intake_Exam
	where Inst_Id=@inst_id and Crs_Id=@crs_id and Exam_Id=@Exam_Id )
    	begin
			update YMF.Exam
	     		set Exam_Name=@Exam_Name,@Type_Exam=@Type_Exam, Start_time=@Start_time,
				End_Time=@End_time,Exam_date=@Exam_Date
				where  Exam_Id=@Exam_Id 
		end
		else
			begin
				print 'instructor may be do not  have this Course or Exam not Exist '
			end
end

drop proc YMF.Update_Exam_PRO

 exec YMF.Update_Exam_PRO @Exam_Id=12, @inst_id=8,@crs_id=4,@Type_Exam ='corrective',
@Exam_Name ='python', @Start_time='09:00',@End_time	='11:00',@Exam_Date='08-27-2023'

select * from YMF.Exam


-----------------------------------------------------

Go
--update Exam for Specific Insturctor and must be teach this Course;
Create or alter Proc YMF.Delete_Exam_PRO (@Exam_Id int)
 as
begin
	
	IF EXISTS(select 1 from YMF.Exam Where Exam_Id=@Exam_Id)
    	begin
			delete from YMF.Exam
				where  Exam_Id=@Exam_Id 
		end
		else
			begin
				print 'Exam not Exist '
			end
end

drop proc Delete_Exam_PRO
 exec Delete_Exam_PRO @Exam_Id=13


select * from YMF.Exam
select * from YMF.Intake_Exam
Go



------------------------------Delete Question From Exam------------------

create or alter proc YMF.Delete_Question_from_Exam(@exam_id int ,@crs_id int ,@inst_id int ,@Q_ID int)
as 
begin
	if exists(select 1 from Ymf.Intake_Exam where Inst_Id=@inst_id and Exam_Id=@exam_id and Crs_Id=@crs_id)
		and Exists(select 1 from YMF.Exam_Question where Q_ID=@Q_ID and Exam_Id=@exam_id)
		begin
			delete from YMF.Exam_Question 
			where Q_ID=@Q_ID and Exam_Id=@exam_id;

		end
		else 
		begin
			print 'exam or course or instructor or Question not exists';
		end
end

drop proc Delete_Question_from_Exam 
exec YMF.Delete_Question_from_Exam @exam_id=1,@inst_id=11,@crs_id=3,@Q_ID=11; 






-----------------------------VIEW EXAM----------------------


Go
--view to Diplay exam and his Question
create view YMF.Display_exam_and_his_Question 
As
select e.Exam_Id,E.Exam_Name,e.Start_Time,e.End_Time,e.Eaxm_Year,e.Exam_date,
Q.Q_Content ,Q.Q_ans_A,Q.Q_ans_B,Q.Q_ans_C,Q.Q_ans_D
from YMF.Exam  as e ,Ymf.Exam_Question as EQ,YMF.Question  as Q
where EQ.Exam_Id=e.Exam_Id and EQ.Q_ID=Q.Q_ID


drop view YMF.Display_exam_and_his_Question
select Exam_Name from select_exam_and_his_Question where Exam_Name='programming'
GO


