
--creation of proc that create question manual to specific exam and insert it in question table
--check on type of Question
create function YMF.Get_Id_instructor(@inst_Email nvarchar(50))
returns int
begin 
declare @inst_id int ;
	select @inst_id=Inst_Id from YMF.Instructor where Inst_Email=@inst_Email;
	return @inst_id
end

go
---add question to exam 
create or Alter proc YMF.create_question_PRo(@exam_id int,@Crs_Id int,@inst_Email nvarchar(MAX),@Q_Content nvarchar(max),
@Q_Type nvarchar(10)  ,@Q_Degree int , @Q_answer	nvarchar(255),@Q_ans_A nvarchar(255) = null ,@Q_ans_B nvarchar(255)=null,	
@Q_ans_C nvarchar(255)=null,@Q_ans_D nvarchar(255)=null)
as
begin
	declare @inst_Id int;
	set @inst_Id=YMF.Get_Id_instructor(@inst_Email);

	declare @isExist int;
			set @isExist=Ymf.checkQuestion(@Q_Content,@Crs_Id);
			select @isExist;--1 is not exist in this course

	--SELECT @inst_Id
	--check this exam and instructor and course 
	if exists (select 1 from YMf.Intake_Exam 
	where Inst_Id=@inst_Id and Crs_Id =@Crs_Id and Exam_Id=@exam_id)
	and @isExist=1
		begin
		 
		 declare @Q_id int,@max_degree int=0,@sum_Degree int=0;
		
		 select @max_degree=C.Crs_Max_Degree from Ymf.Courses as C , YMF.Question as Q 
			where C.Crs_Id=Q.Crs_Id and C.Crs_Id=@Crs_Id;
			--select @max_degree as 'max'
		    set @sum_Degree= YMF.Total_Degree_question(@exam_id);
			-- select @sum_Degree;
		 if(@sum_Degree<=@max_degree)
		  begin 
			 
		    -- begin tran add_Question
		     	if(@Q_Type='T_F')
		    	begin
				insert into ymf.Question(Q_Content,Q_type,Q_answer,Q_ans_A,Q_ans_B,Q_ans_C,Q_ans_D,Crs_Id)
				values(@Q_Content,@Q_Type,@Q_answer,'true','false',@Q_ans_C,@Q_ans_D,@Crs_Id)
			end
			else if(@Q_Type='MCQ')
				begin
				if(@Q_answer=@Q_ans_A or @Q_answer=@Q_ans_B or @Q_answer=@Q_ans_C or @Q_answer=@Q_ans_D)
					begin
						insert into ymf.Question(Q_Content,Q_type,Q_answer,Q_ans_A,Q_ans_B,Q_ans_C,Q_ans_D,Crs_Id)
						values(@Q_Content,@Q_Type,@Q_answer,@Q_ans_A,@Q_ans_B,@Q_ans_C,@Q_ans_D,@Crs_Id)
					end
				else
					begin
					select 'Chooses do not contain the Right Answer';
				end
		     	end
			else
				begin
				insert into ymf.Question(Q_Content,Q_type,Q_answer,Q_ans_A,Q_ans_B,Q_ans_C,Q_ans_D,Crs_Id)
				values(@Q_Content,@Q_Type,@Q_answer,@Q_ans_A,@Q_ans_B,@Q_ans_C,@Q_ans_D,@Crs_Id)				
			end
	
			select @Q_id= max(Q_ID) from YMF.Question
		
				insert into ymf.Exam_Question(Q_ID,Exam_Id,Q_Degree)
			    values(@Q_id,@exam_id,@Q_Degree)
				
			--end
	
		end
		
		  else 
		  begin
		       print 'sum Of Question degree is bigger than max degree for this courses '
		    end
	end --if
	    else
		begin
			print 'The instructor does not teach this course or Exam Not Exist or Question is exist';
		end

end


drop proc YMF.create_question_PRo

exec YMF.create_question_PRo @exam_id=15,@Crs_Id=4,@inst_Email='mahmoud.abdelkhalek@gmail.com', 
@Q_Content='ali is good man  ',@Q_Type='T_F',@Q_Degree=2 , @Q_answer='true'


GO
create function YMF.checkQuestion(@Qentent_Quest nvarchar(50),@crs_id int)
returns int 
begin 
		declare @x int=1;
		if (@Qentent_Quest in(select Q_Content from Ymf.Question as Q where 
			Q.Q_Content = @Qentent_Quest and Crs_Id=@Crs_Id))
			begin
				set @x=0;
			end
			return @x;

end
Go
drop function YMF.checkQuestion
Go
select YMF.checkQuestion('test ',4)

Go
-----------------------------------
--trigger to valid on exam is Exist or not
create Trigger Check_Exam_ISExsit_Or_Not
on YMF.Exam_Question 
after insert 
as
begin
	begin tran check_on_Exam
		declare @Q_id int,@Exam_Id int
		select @Q_id= max(Q_ID) from YMF.Exam_Question
		select @Exam_Id=Exam_Id from YMF.Exam_Question where Q_ID=@Q_id;
		if EXISTS (select 1 from YMF.Exam_Question where Q_ID=@Q_id and Exam_Id=@Exam_Id)
		begin 
			print 'insert Success';
			commit
		end
		else
		begin
			print 'Exam Is Exist';
			rollback;
		end
end

drop trigger Check_Exam_ISExsit_Or_Not
GO
select * from YMF.Exam_Question
select * from YMF.Question
select * from YMF.Exam
--------------------------------------------------------------------------------------------
GO
-------------Update on Question

create or alter proc YMF.Update_question_PRo(@Exam_Id int,@Crs_Id int,@inst_Email nvarchar(50), @Q_Id int,@Q_Content nvarchar(max),@Q_Type nvarchar(10) 
,@Q_Degree int , @Q_answer	nvarchar(255),@Q_ans_A nvarchar(255) = null ,@Q_ans_B nvarchar(255)=null,	
@Q_ans_C nvarchar(255)=null,@Q_ans_D nvarchar(255)=null)
as
begin
	declare @inst_Id int;
	set @inst_Id=YMF.Get_Id_instructor(@inst_Email);

	declare @isExist int;
			set @isExist=Ymf.checkQuestion(@Q_Content,@Crs_Id);
			select @isExist;--1 is not exist in this course

	--SELECT @inst_Id
	--check this exam and instructor and course 
	if exists (select 1 from YMf.Intake_Exam 
	where Inst_Id=@inst_Id and Crs_Id =@Crs_Id and Exam_Id=@exam_id)
	and @isExist=1
		begin
		 declare @max_degree int=0,@sum_Degree int=0;
		
		 select @max_degree=C.Crs_Max_Degree from Ymf.Courses as C , YMF.Question as Q 
			where C.Crs_Id=Q.Crs_Id and C.Crs_Id=@Crs_Id;
			--select @max_degree as 'max'
		    set @sum_Degree= YMF.Total_Degree_question(@exam_id);
			-- select @sum_Degree;
		 if(@sum_Degree<=@max_degree)
		 begin
			if exists (select 1 from YMF.Question where Q_ID=@Q_Id)
			begin
			  if(@Q_Type='T_F')
				begin
					begin tran update_Question_T_F
					print 'update True'
					Update YMF.Question
					set Q_Content=@Q_Content,Q_answer=@Q_answer,Q_type=@Q_Type,
					Q_ans_A='true',Q_ans_B='false',Q_ans_C=@Q_ans_C,Q_ans_D=@Q_ans_D
					where Q_ID=@Q_Id;

					update YMF.Exam_Question 
					set Q_Degree=@Q_Degree
					where Q_ID=@Q_Id and Exam_Id=@Exam_Id;

					   set @sum_Degree= YMF.Total_Degree_question(@exam_id);
			            select @sum_Degree;
						if(@sum_Degree=@max_degree)
						begin
							print 'Update Success';
							commit;
							
						end
						else
						begin
							print 'some of degree less than or more than max degree please increase degree of the question'+@sum_Degree;
							rollback
						end
		 

				end
			else if(@Q_Type='MCQ')
				begin
				begin tran UPdate_Question_MCQ
					if(@Q_answer=@Q_ans_A or @Q_answer=@Q_ans_B or @Q_answer=@Q_ans_C or @Q_answer=@Q_ans_D)
						begin
							Update YMF.Question
							set Q_Content=@Q_Content,Q_answer=@Q_answer,Q_type=@Q_Type,
							Q_ans_A=@Q_ans_A,Q_ans_B=@Q_ans_B,Q_ans_C=@Q_ans_C,	Q_ans_D=@Q_ans_D
							where Q_ID=@Q_Id

							update YMF.Exam_Question 
							set Q_Degree=@Q_Degree
							where Q_ID=@Q_Id and Exam_Id=@Exam_Id;

						   set @sum_Degree= YMF.Total_Degree_question(@exam_id);
			               -- select @sum_Degree;
						if(@sum_Degree=@max_degree)
						begin
							print 'Update Success';
							commit;
							
						end
						else
						begin
							print 'some of degree less than or more than max degree please increase degree of the question'+@sum_Degree;
							rollback
						end
						end
					else
						begin
							select 'Chooses do not contain the Right Answer';
						end
				end
			else
				begin
					begin tran Update_Question_Text
					Update YMF.Question
						set Q_Content=@Q_Content,Q_answer=@Q_answer,Q_type=@Q_Type,
						Q_ans_A=@Q_ans_A,Q_ans_B=@Q_ans_B,Q_ans_C=@Q_ans_C,	Q_ans_D=@Q_ans_D
						where Q_ID=@Q_Id

						update YMF.Exam_Question 
							set Q_Degree=@Q_Degree
						where Q_ID=@Q_Id and Exam_Id=@Exam_Id;

					   set @sum_Degree= YMF.Total_Degree_question(@exam_id);
			-- select @sum_Degree;
						if(@sum_Degree=@max_degree)
						begin
							print 'Update Success';
							commit;
							
						end
						else
						begin
							print 'some of degree less than or more than max degree please increase degree of the question'+@sum_Degree;
							rollback
						end

				end
			end
	else 
	begin
		print 'Question do not exist'
	end
		end
		 
		 end
		   else
		begin
			print 'The instructor does not teach this course or Exam Not Exist or Question is exist';
		end
end


drop proc YMF.Update_question_PRo

exec YMF.Update_question_PRo @Exam_Id=4,@inst_Email='wesam.ahmed@gmail.com',@Crs_Id=3, @Q_Id =11,@Q_Content='Javascript is structural language ',@Q_Type='T_F' 
,@Q_Degree=5 , @Q_answer='true'

select * from YMF.Question

Go
-------------------------------------------------------------------------

create or alter proc YMF.Delete_question_PRo(@Q_Id int)
as
begin
	if EXISTS (select 1 from YMF.Question where Q_ID=@Q_id)
		begin 
			delete from Ymf.Question
				where Q_ID=@Q_Id;
		end	
		else 
		begin
			print 'Question is not Exist';
		end
end

Go

drop proc YMf.Delete_question_PRo

exec YMF.Delete_question_PRo @Q_Id =6

select * from YMF.Question
select * from YMF.Exam_Question
select * from YMF.Question
select * from YMF.Exam


-----------------------
Go

------------------------------------
--function to count total degree


alter function YMF.Total_Degree_question(@Exam_Id int)
returns int
as
begin
declare @total_degree int=0;
	 select @total_degree=sum(EQ.[Q_Degree])
	from Ymf.Exam as e ,Ymf.Exam_Question as EQ,YMF.Question as Q
	where EQ.Exam_Id=e.Exam_Id and EQ.Q_ID=Q.Q_ID and e.Exam_Id=@Exam_Id;
	if(@total_degree is NUll)
	begin
		set @total_degree=0;
	end
	return @total_degree;
end
GO
drop function YMF.Total_Degree_question

select YMF.Total_Degree_question(4)  

select * from Ymf.Exam 
Go
---view to select exam with question
create View YMF.select_Question_to_Exam
as
select Q.Q_ID, Q.Q_Content,Q.Q_ans_A,Q.Q_ans_B ,e.Exam_Name,e.Exam_Id 
from Ymf.Exam as e ,Ymf.Exam_Question as EQ,YMF.Question as Q
where EQ.Exam_Id=e.Exam_Id and EQ.Q_ID=Q.Q_ID 

drop view YMF.select_Question_to_Exam
select * from YMF.select_Question_to_Exam where Exam_id=4;
GO
---------------------------------------------------------


----create question  to course 

select * from YMF.Courses
select * from YMF.Question

create or alter proc YMF.Add_Question_to_Course(@Crs_Id int,@inst_Id int, @Q_Content nvarchar(max),@Q_Type nvarchar(10) 
, @Q_answer	nvarchar(255),@Q_ans_A nvarchar(255) = null ,@Q_ans_B nvarchar(255)=null,	
@Q_ans_C nvarchar(255)=null,@Q_ans_D nvarchar(255)=null)
as
begin
	declare @Q_id int;
	begin try

		declare @isExist int;
			set @isExist=Ymf.checkQuestion(@Q_Content,@Crs_Id);
			select @isExist;--1 is not exist in this course
		if Exists (select 1 from YMF.Intake_Exam where Crs_Id=@Crs_Id and Inst_Id=@inst_Id)
		and @isExist=1
			begin
				if(@Q_Type='T_F')
					begin
						insert into ymf.Question(Q_Content,Q_type,Q_answer,Q_ans_A,Q_ans_B,Q_ans_C,Q_ans_D,[Crs_Id])
						values(@Q_Content,@Q_Type,@Q_answer,'true','false',@Q_ans_C,@Q_ans_D,@Crs_Id)
					end
				else if(@Q_Type='MCQ')
					begin
						if(@Q_answer=@Q_ans_A or @Q_answer=@Q_ans_B or @Q_answer=@Q_ans_C or @Q_answer=@Q_ans_D)
							begin
								insert into ymf.Question(Q_Content,Q_type,Q_answer,Q_ans_A,Q_ans_B,Q_ans_C,Q_ans_D,[Crs_Id])
								values(@Q_Content,@Q_Type,@Q_answer,@Q_ans_A,@Q_ans_B,@Q_ans_C,@Q_ans_D,@Crs_Id)
							end
						else
							begin
								select 'Chooses do not contain the Right Answer';
							end
					end
	
			    else
			     	begin
					insert into ymf.Question(Q_Content,Q_type,Q_answer,Q_ans_A,Q_ans_B,Q_ans_C,Q_ans_D,[Crs_Id])
					values(@Q_Content,@Q_Type,@Q_answer,@Q_ans_A,@Q_ans_B,@Q_ans_C,@Q_ans_D,@Crs_Id)		
				end
		    end
			else
			begin
			
			   print 'instructor or course not found or Question is exist' ;
			   THROW 50005, N'An error occurred', 16;
			end
	end try
	 begin catch
	    
	     SELECT  ERROR_LINE() AS ErrorLine ,
         ERROR_MESSAGE() AS ErrorMessage; 

	 end catch
END
drop proc YMF.Add_Question_to_Course

EXEC YMF.Add_Question_to_Course @Crs_Id=3,@inst_Id=11 ,@Q_Content='STRING is immutable type ',@Q_Type='T_F',
@Q_answer='true',@Q_ans_A='true',@Q_ans_B='false';

select * from YMF.Question

GO



------------------------------------------------------
GO
---select  exam random


create or alter procedure YMF.select_Question_Random(@number_Quest int ,@crs_Id int,@Exam_Id int,@inst_id int,@Q_Degree int)
as 
begin
---create variable table 
declare  @Random_Question table (
    Q_ID int, Q_Content nvarchar(max),Q_type nvarchar(10), Q_answer nvarchar(255),
    Q_ans_A nvarchar(255), Q_ans_B nvarchar(255), Q_ans_C nvarchar(255), Q_ans_D nvarchar(255), Crs_Id int
);

declare @last_Q int,@i int =1,@rundom_Quest int ,@Count_Course_Q int;

SELECT @last_Q= max(Q_ID) FROM YMF.Question;--use random method

SELECT  @Count_Course_Q=count(crs_Id) FROM YMF.Question where Crs_Id=@crs_Id;
--select @Count_Course_Q
--select @last_Q

if exists (select 1 from YMf.Intake_Exam 
	where Inst_Id=@inst_Id and Crs_Id =@Crs_Id and Exam_Id=@exam_id)
	begin
	begin try
	if (@number_Quest <=@Count_Course_Q and exists(select 1 from YMf.Exam where Exam_Id=@Exam_Id))
		begin
			begin transaction 

			while (@i<=@number_Quest) 
				begin 
					set @rundom_Quest=CEILING(RAND() * @last_Q)
					if exists(select 1 from YMF.Question  where Crs_Id=@crs_Id and Q_ID=@rundom_Quest)
						 and not exists(select 1 from @Random_Question where Crs_Id=@crs_Id and Q_ID=@rundom_Quest)
						begin

						 insert INTO @Random_Question 
						 select * FROM YMF.Question as Q where Crs_Id=@crs_Id and Q_ID=@rundom_Quest

						 ------insert question to exam
						 if Exists(select 1 from YMF.Exam_Question where Exam_Id=@Exam_Id and Q_ID=@rundom_Quest)
							begin 
							print 'sucess 5'
							--to avoid duplication
								update YMf.Exam_Question
								set Exam_Id=@Exam_Id,Q_ID=@rundom_Quest
								where Exam_Id=@Exam_Id and Q_ID=@rundom_Quest
							end
						else
							begin
							print 'success 4';

							 insert into YMF.Exam_Question(Exam_Id,Q_ID,[Q_Degree])
							 values(@Exam_Id,@rundom_Quest,@Q_Degree);
						 
							end
						set @i=@i+1;
					end

				end


			declare @Q_id int,@max_degree int=0,@sum_Degree int=0;
		
			 select @max_degree=C.Crs_Max_Degree from Ymf.Courses as C , YMF.Question as Q 
				where C.Crs_Id=Q.Crs_Id and C.Crs_Id=@Crs_Id;
				--select @max_degree as 'max'
				set @sum_Degree= YMF.Total_Degree_question(@exam_id);
				 select @sum_Degree;
			 if(@sum_Degree=@max_degree)
			 begin
				 print 'Questions add success';
				
			     	select * from @Random_Question;
					commit;
			
			 end
			 else
			 begin
				print 'Degree of the Exam is less than max degree for this course ';
				rollback;
			 end
	     end
	else
		begin
		     print 'The number of questions you requested is greater than the available number of questions.
			         Please ask for a smaller number or Exam Is Not Exam';
			   THROW 50005, N'Exam Not Exists', 16;
		
		end

end try
begin catch
	
	     SELECT  ERROR_LINE() AS ErrorLine ,
         ERROR_MESSAGE() AS ErrorMessage; 
end catch

--select * from @Random_Question
end
else
begin
  print 'The instructor does not teach this course or Exam Not Exist or Question is exist';

end
end

drop proc YMF.select_Question_Random

exec  YMF.select_Question_Random @crs_Id=4,@number_Quest=3,@Exam_Id=15,@inst_id=17,@Q_Degree=5;
GO

select * from YMF.Exam_Question
select * from YMF.Intake_Exam
select * from YMF.Exam
select * from YMF.Question


create or alter proc YMF.Display_Question_Pool_For_Course(@Crs_Id int )
as 
begin 
	if exists (select 1 from YMF.Courses where Crs_Id=@Crs_Id)
	and exists(select 1 from YMF.Question where Crs_Id=@Crs_Id)
	begin 
		select * from YMF.Question where Crs_Id=@Crs_Id; 
	end
	else
	begin
		print 'Course not exist or Course has no Question';
	end
end

GO

drop proc YMF.Display_Question_Pool_For_Course



exec YMF.Display_Question_Pool_For_Course @Crs_Id=3;

GO

create or alter proc YMF.Select_Question_Manualy(
@Q_Id nvarchar(50),@Crs_id int ,@Exam_Id int, @Inst_Id int,@Q_Degree int)
as
begin

	if exists (select 1 from YMf.Intake_Exam 
	where Inst_Id=@inst_Id and Crs_Id =@Crs_Id and Exam_Id=@exam_id)
	and Exists (select 1 from YMF.Question where Q_ID=@Q_Id and Crs_Id=@Crs_id)
	begin
		if exists (select 1 from YMF.Exam_Question where Q_ID=@Q_Id and Exam_Id=@Exam_Id)
		begin
		 print 'Question is exists in exam choose anthor Question';
		end
		else
		begin
			begin tran manaual_Question 
		    	 insert into YMf.Exam_Question(Q_ID,Exam_Id,Q_Degree)
		         values (@Q_Id,@Exam_Id,@Q_Degree);
		
		      declare @max_degree int=0,@sum_Degree int=0;
		
		   	 select @max_degree=C.Crs_Max_Degree from Ymf.Courses as C , YMF.Question as Q 
				where C.Crs_Id=Q.Crs_Id and C.Crs_Id=@Crs_Id;
				--select @max_degree as 'max'
				set @sum_Degree= YMF.Total_Degree_question(@exam_id);
				 select @sum_Degree;
			 if(@sum_Degree<=@max_degree)
			 begin
			  print 'Questions add success';
			   commit
				
			 end
			 else
			 begin
			  print 'Degree of the Exam is less than max degree for this course ';
				rollback
			 end		
		end
	end
	else
	begin
		print 'instructor , Course,Exam,Question, may be not Exist'
	end
end

drop proc YMF.Select_Question_Manualy

exec YMf.Select_Question_Manualy @Q_Id=17,@Crs_id=3,@Exam_Id=4,@Inst_Id=11 ,@Q_Degree=5;

select * from YMF.Question
select * from YMF.Intake_Exam 











create proc YMF.Add_question_PRo(@Q_Content nvarchar(max),@Q_Type nvarchar(10) 
, @Q_answer	nvarchar(255),@Q_ans_A nvarchar(255) = null ,@Q_ans_B nvarchar(255)=null,	
@Q_ans_C nvarchar(255)=null,@Q_ans_D nvarchar(255)=null,@Crs_Id int)
as
begin
	declare @Q_id int;
	--declare @Qestion_type nvarchar(10);
	if(@Q_Type='T_F')
		begin
			insert into ymf.Question(Q_Content,Q_type,Q_answer,Q_ans_A,Q_ans_B,Q_ans_C,Q_ans_D,Crs_Id)
			values(@Q_Content,@Q_Type,@Q_answer,'true','false',@Q_ans_C,@Q_ans_D,@Crs_Id)
		end
	else if(@Q_Type='MCQ')
		begin
			if(@Q_answer=@Q_ans_A or @Q_answer=@Q_ans_B or @Q_answer=@Q_ans_C or @Q_answer=@Q_ans_D)
				begin
					insert into ymf.Question(Q_Content,Q_type,Q_answer,Q_ans_A,Q_ans_B,Q_ans_C,Q_ans_D,Crs_Id)
					values(@Q_Content,@Q_Type,@Q_answer,@Q_ans_A,@Q_ans_B,@Q_ans_C,@Q_ans_D,@Crs_Id)
				end
			else
				begin
					select 'Chooses do not contain the Right Answer';
				end
		end
	else
		begin
			insert into ymf.Question(Q_Content,Q_type,Q_answer,Q_ans_A,Q_ans_B,Q_ans_C,Q_ans_D,Crs_Id)
			values(@Q_Content,@Q_Type,@Q_answer,@Q_ans_A,@Q_ans_B,@Q_ans_C,@Q_ans_D,@Crs_Id)				
		end

end