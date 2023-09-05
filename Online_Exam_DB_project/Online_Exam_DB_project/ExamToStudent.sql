
Go
--- function display all exam for Student
CREATE FUNCTION YMF.select_Exam_To_Student (@Std_Id int)
RETURNS @Exams_valiable_to_student table(
Exam_Id int,
Exam_Name nvarchar(50),
Exam_Date date,
Start_Exam time,
student_Name nvarchar(50)
) 
AS
begin

	insert into @Exams_valiable_to_student(student_Name,Exam_Id,Exam_Name,Start_Exam,Exam_Date)
	select s.Std_Name, E.Exam_Id,E.Exam_Name,E.Start_Time,E.Exam_date from YMF.Exam as E,YMF.Student_Exam AS SE,YMF.Student as S
	where SE.Exam_Id= E.Exam_Id and SE.Std_Id=s.Std_Id and s.Std_Id=@Std_Id 
	
	return
 end 

 drop function YMF.select_Exam_To_Student

 select * from YMF.select_Exam_To_Student(3)

 Go


 -------------------------------------------------------

-- function  to select Exam to student in specific Date

GO
CREATE or ALTER FUNCTION YMF.select_Exam_To_Student_in_specific_Date (@Std_Id int,@Exam_id int )
RETURNS @Exams_to_student_Will table(
student_Name nvarchar(50),
Exam_Id int,
Exam_Name nvarchar(50),
Exam_Date date,
Start_Time  time,
End_Time time
) 
AS
begin
	insert into @Exams_to_student_Will(student_Name,Exam_Id,Exam_Name,Start_Time,End_Time,Exam_Date)
	select s.Std_Name, E.Exam_Id,E.Exam_Name,E.Start_Time,E.End_Time,E.Exam_date 
	from YMF.Exam as E,YMF.Student_Exam AS SE,YMF.Student as S
	where SE.Exam_Id= E.Exam_Id and SE.Std_Id=s.Std_Id and 
	s.Std_Id=@Std_Id and e.Exam_Id=@Exam_id ;
	return
 end 
 drop function YMF.select_Exam_To_Student_in_specific_Date
 select * from YMF.select_Exam_To_Student_in_specific_Date(6,5)


 select *from YMF.Student
 select *from YMF.Student_Exam
  select *from YMF.Exam



GO

create or alter proc YMF.Display_Exam_To_Student(@std_Id int ,@Exam_Id int)
as 
begin
	declare @start_Time time,@End_Time Time,@current_Time time,@Current_Date date,@Exam_Date date;

	SELECT @current_Time=CURRENT_TIMESTAMP AT TIME ZONE 'Egypt Standard Time';
	select @Current_Date=GETDATE();
	--select @current_Time
	--select @Current_Date
	select @start_Time=Start_Time,@End_Time=End_Time,@Exam_Date=Exam_Date
	from YMF.select_Exam_To_Student_in_specific_Date(@std_Id,@Exam_Id)
	--select @Exam_Id
    --select @start_Time
    --select @End_Time
    --select @Exam_Date
	

	if(@current_Time not between @start_Time and @End_Time) or (@Current_Date!=@Exam_Date)
	begin
		print 'Exam Closed'
	end 
	else
	begin
	   if exists(select 1 from YMF.select_Exam_To_Student_in_specific_Date(@std_Id,@Exam_Id))
			begin
				select e.Exam_Id,Q.Q_ID,Q.Q_Content,Q.Q_ans_A,Q.Q_ans_B 
				from YMF.Question as Q,YMF.Exam_Question as EQ,YMF.Exam as E
				where EQ.Q_ID=Q.Q_ID and EQ.Exam_Id=E.Exam_Id
				and E.Exam_Id=@Exam_Id ;
		    end
			else
			begin
			print 'student  do not have exam';
			end
	end
end

drop proc YMF.Display_Question_To_Student

exec  YMF.Display_Exam_To_Student @std_Id=6,@Exam_Id=4;
 select *from YMF.Student
 Go


 --------------------------------------------------------------

-- correct Exam to Student
GO

create or alter proc YMF.Answer_Exam_Student_PRO(@Q_Id int ,@Std_Answer nvarchar(50)=null,@std_Id int ,@Exam_Id int)
as
begin
	--join to find or determined Question Find At any Exam
	declare @Q_Ans nvarchar(50),@Q_Degree int ;
	declare @start_Time time,@End_Time Time,@current_Time time,@Current_Date date,@Exam_Date date;
	SELECT @current_Time=CURRENT_TIMESTAMP AT TIME ZONE 'Egypt Standard Time';
	select @Current_Date=GETDATE();

if exists(	select 1 from YMF.All_Student_exams as SE ,YMF.Exam_Question as EQ,YMF.Question as Q
	where EQ.Exam_Id=SE.Exam_Id and EQ.Q_ID=Q.Q_ID and
	SE.Exam_Id=@Exam_Id and SE.Std_Id=@std_Id and Q.Q_ID=@Q_Id)
	begin 
	   select @Q_Degree=Q_Degree from YMF.Exam_Question where Exam_Id=@Exam_Id and Q_ID=@Q_Id;
	   select @Q_Ans=Q_answer from Ymf.Question where Q_ID=@Q_Id;

	   	select @start_Time=Start_Time,@End_Time=End_Time,@Exam_Date=Exam_date
		from YMF.Exam where Exam_Id=@Exam_Id;
       if(@current_Time not between @start_Time and @End_Time) or (@Current_Date!=@Exam_Date)
		begin
		   print 'Exam Closed'
		end 
		else
		begin
		
		if Exists (select 1 from YMF.Student_EXam_Answer
		where Std_Id=@std_Id and Exam_Id=@Exam_Id and Q_ID=@Q_Id)
		begin
		--select @Q_Degree
		  update YMF.Student_EXam_Answer
		  set Std_Answer=@Std_Answer ,Question_Degree=@Q_Degree
		  where  Std_Id=@std_Id and Exam_Id=@Exam_Id and Q_ID=@Q_Id;
		  print 'update success'
		 end
			else
			begin
					--select @std_Id
			 insert into YMF.Student_EXam_Answer(Std_Id,Exam_Id,Q_ID,Std_Answer,[Question_Degree])
			 values(@std_Id,@Exam_Id,@Q_Id,@Std_Answer,@Q_Degree);
		     print 'insert success'

			end
		end
	end
	else
	begin
	print 'student or Exam is not exist  '
	end
end
drop proc YMF.Answer_Exam_PRO


exec YMF.Answer_Exam_Student_PRO @Q_Id=12,@Std_Answer='true',@std_Id=6,@Exam_Id=13;

select * from YMF.Question

select * from YMF.Student_EXam_Answer
select * from YMF.Student_Exam
Go
--------------------------------------------------------------
 create or alter Trigger YMF.correct_Exam_For_Student
 on YMF.Student_EXam_Answer
 after insert
 as
 begin
	declare @Q_Id int, @Std_id int,@Exam_ID int,@Sum_Result int,
	@student_answer nvarchar(50) ,@Q_Answer  nvarchar(50),@Q_Degree  int;

	select @Q_Id=Q_ID ,@student_answer=Std_Answer,@Std_id=Std_Id,@Exam_ID=Exam_Id
	from inserted 
	--select @Q_Id;
	   select @Q_Degree=Q_degree from YMF.Exam_Question where Exam_Id=@Exam_Id and Q_ID=@Q_Id;

	select @Q_Answer=Q.Q_answer from YMF.Question as Q where Q_ID=@Q_Id;

	if(@Q_Answer!=@student_answer)
	begin 
		update YMF.Student_EXam_Answer
		set Question_Degree=0
		where Std_Id=@Std_id and Exam_Id=@Exam_ID and Q_ID=@Q_Id;
		
	  select @Sum_Result= sum(Question_Degree) from YMF.Student_EXam_Answer where Std_Id=@Std_id and Exam_Id=@Exam_ID
		update YMf.Student_Exam
		set Result= @Sum_Result
		where  Std_Id=@Std_id and Exam_Id=@Exam_ID;
	end
	else
	begin
	    select @Sum_Result= sum(Question_Degree) from YMF.Student_EXam_Answer where Std_Id=@Std_id and Exam_Id=@Exam_ID
		update YMf.Student_Exam
		set Result= @Sum_Result
		where  Std_Id=@Std_id and Exam_Id=@Exam_ID;
	
	end
		declare @have_degree float =0.000,@result float ;
		set @have_degree= Ymf.Total_Degree_question(@Exam_ID)/2;
		--update YMf.Student_Exam
		--set Result=Result+@Q_Degree
		--where  Std_Id=@Std_id and Exam_Id=@Exam_ID;

		select @result=Result from YMF.Student_Exam where Std_Id=@Std_id and Exam_Id=@Exam_ID

		if(@result< @have_degree)
		begin
			update YMf.Student_Exam
			set Status_std ='fail'
			where  Std_Id=@Std_id and Exam_Id=@Exam_ID;
		end
		else
		begin
			update YMf.Student_Exam
			set Status_std ='Success'
			where  Std_Id=@Std_id and Exam_Id=@Exam_ID;
			
		end
	end
	GO
 --end

 drop trigger YMF.correct_Exam_For_Student

 Go

 -------------------------after Update
  create or alter Trigger YMF.correct_Exam_For_Student_Update
 on YMF.Student_EXam_Answer
 after update
 as
 begin
	declare @Q_Id int, @Std_id int,@Exam_ID int,@Sum_Result int,
	@student_answer nvarchar(50) ,@Q_Answer  nvarchar(50),@Q_Degree  int;

	select @Q_Id=Q_ID ,@student_answer=Std_Answer,@Std_id=Std_Id,@Exam_ID=Exam_Id
	from inserted 
	--select @Q_Id;
	   select @Q_Degree=Q_degree from YMF.Exam_Question where Exam_Id=@Exam_Id and Q_ID=@Q_Id;


	select @Q_Answer=Q.Q_answer from YMF.Question as Q where Q_ID=@Q_Id;
	
	if(@Q_Answer!=@student_answer)
	begin 
		update YMF.Student_EXam_Answer
		set Question_Degree=0
		where Std_Id=@Std_id and Exam_Id=@Exam_ID and Q_ID=@Q_Id;
	
	  select @Sum_Result= sum(Question_Degree) from YMF.Student_EXam_Answer where Std_Id=@Std_id and Exam_Id=@Exam_ID
		update YMf.Student_Exam
		set Result= @Sum_Result
		where  Std_Id=@Std_id and Exam_Id=@Exam_ID;
	end
	else
	begin
	    select @Sum_Result= sum(Question_Degree) from YMF.Student_EXam_Answer where Std_Id=@Std_id and Exam_Id=@Exam_ID
		update YMf.Student_Exam
		set Result= @Sum_Result
		where  Std_Id=@Std_id and Exam_Id=@Exam_ID;
	end
	
		declare @have_degree float =0.000,@result float ;
		set @have_degree= Ymf.Total_Degree_question(@Exam_ID)/2;
	
		select @result=Result from YMF.Student_Exam where Std_Id=@Std_id and Exam_Id=@Exam_ID

		if(@result< @have_degree)
		begin
			update YMf.Student_Exam
			set Status_std ='fail'
			where  Std_Id=@Std_id and Exam_Id=@Exam_ID;
		end
		else
		begin
			update YMf.Student_Exam
			set Status_std ='Success'
			where  Std_Id=@Std_id and Exam_Id=@Exam_ID;
			
		end
		

	
 end

 ----------------------------------------

 -- status of student 

 
 
 
 
 
 
 GO


 create or alter function YMF.Student_Status_Result(@std_id int,@Exam_id int)
 returns @status_Result table(
 Student_Name nvarchar(50),
 Exam_Name Nvarchar(50),
 [status] varchar(10),
 result int 
 ) 
 as 
 begin
	declare @Status varchar(10);
	declare @start_Time time,@End_Time Time,@current_Time time,@Current_Date date,@Exam_Date date;
	SELECT @current_Time=CURRENT_TIMESTAMP AT TIME ZONE 'Egypt Standard Time';
	select @Current_Date=GETDATE();	
	 if Exists (select 1 from YMf.Student_Exam where Std_Id=@std_id and Exam_Id=@Exam_id)
		 begin
			 select @start_Time=Start_Time,@End_Time=End_Time,@Exam_Date=Exam_date
				from YMF.Exam where Exam_Id=@Exam_Id;
			if(@current_Time >= @End_Time) and (@Current_Date>=@Exam_Date)
			begin
			 insert into @status_Result(Student_Name,Exam_Name,status,result)
				select s.Std_Name,E.Exam_Name, SE.Status_std,SE.Result from Ymf.Student as S , YMf.Student_Exam as SE,YMF.Exam as E
				where SE.Std_Id=S.Std_Id and SE.Exam_Id=E.Exam_Id and
				SE.Std_Id=@std_id and SE.Exam_Id=@Exam_id
		     end
			--select @Status
         end
		 return 
end 
drop function YMF.Student_Status_Result


select * from YMF.Student_Status_Result(6,4)