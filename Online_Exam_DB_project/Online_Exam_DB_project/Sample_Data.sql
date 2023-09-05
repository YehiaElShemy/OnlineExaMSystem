------insert data into Department table-------------------
exec YMF.Add_DepartMent_PRo @Dept_Name='Testing'
exec YMF.Add_DepartMent_PRo @Dept_Name='Cyber security'
exec YMF.Add_DepartMent_PRo @Dept_Name='software development'
exec YMF.Add_DepartMent_PRo @Dept_Name='Artificial intelligence'
exec YMF.Add_DepartMent_PRo @Dept_Name='Testing'
exec YMF.Add_DepartMent_PRo @Dept_Name='Multi media'

select * from ymf.Department


------ insert data into  Track Table ------------------------
exec Add_Track_PRo @Track_Name='Full stack using .net'
exec Add_Track_PRo @Track_Name='Full stack using php'
exec Add_Track_PRo @Track_Name='Full stack using mearn'
exec Add_Track_PRo @Track_Name='Full stack using python '
exec Add_Track_PRo @Track_Name='Software testing'
exec Add_Track_PRo @Track_Name='Introduction syber security'
exec Add_Track_PRo @Track_Name='Machine learning'
exec Add_Track_PRo @Track_Name='UX/UI'
exec Add_Track_PRo @Track_Name='Social media'
exec Add_Track_PRo @Track_Name='AI'

select * from ymf.Track




------------ insert data into branch table -------------------------
exec YMF.Add_Branch_PRo @branch_Name='Mansoura ',@Location='Mansoura university'
exec YMF.Add_Branch_PRo @branch_Name='Smart village ',@Location='Alexandira desert road '
exec YMF.Add_Branch_PRo @branch_Name='Assuit ',@Location='Assuit university';
exec YMF.Add_Branch_PRo @branch_Name='Sohag ',@Location='Sohag university';
exec YMF.Add_Branch_PRo @branch_Name='Menofia ',@Location='Menofia university';
exec YMF.Add_Branch_PRo @branch_Name='Aswan ',@Location='Aswan university';
exec YMF.Add_Branch_PRo @branch_Name='Minia ',@Location='Minia university';

select * from ymf.Branch
-------------update add manager to branch---------------

exec YMF.Assign_instructor_To_Branch_as_Manager_PRO @branch_Name='Mansoura  ',@inst_Id=8
exec YMF.Assign_instructor_To_Branch_as_Manager_PRO @branch_Name='Minia  ',@inst_Id=4
exec YMF.Assign_instructor_To_Branch_as_Manager_PRO @branch_Name='Assuit  ',@inst_Id=3
exec YMF.Assign_instructor_To_Branch_as_Manager_PRO @branch_Name='Sohag  ',@inst_Id=7
exec YMF.Assign_instructor_To_Branch_as_Manager_PRO @branch_Name='Aswan  ',@inst_Id=10
exec YMF.Assign_instructor_To_Branch_as_Manager_PRO @branch_Name='Menofia  ',@inst_Id=9
exec YMF.Assign_instructor_To_Branch_as_Manager_PRO @branch_Name='Smart village  ',@inst_Id=11

select * from ymf.Branch

GO


-------------- insert data into  instructor ---------------------------------
exec YMF.Add_Instructor_PRo @Inst_Name='Wesam',@Inst_Email='wesam.ahmed@gmail.com',@branch_Name='Assuit'
exec YMF.Add_Instructor_PRo @Inst_Name='Ahmed Mamdouh',@Inst_Email='ahmed.mamdouh@gmail.com',@branch_Name='Assuit'
exec YMF.Add_Instructor_PRo @Inst_Name='Hany saad',@Inst_Email='hany.saad@gmail.com',@branch_Name='Assuit'
exec YMF.Add_Instructor_PRo @Inst_Name='Mirhan',@Inst_Email='mirhan.mohamed@gmail.com',@branch_Name='Minia'
exec YMF.Add_Instructor_PRo @Inst_Name='Sara',@Inst_Email='sara.salah@gmail.com',@branch_Name='Minia'
exec YMF.Add_Instructor_PRo @Inst_Name='Nawal zaki',@Inst_Email='nawal.zaki@gmail.com',@branch_Name='Minia'
exec YMF.Add_Instructor_PRo @Inst_Name='Mahmoud Abdelkhalek',@Inst_Email='mahmoud.abdelkhalek@gmail.com',@branch_Name='Sohag'
exec YMF.Add_Instructor_PRo @Inst_Name='Ramy',@Inst_Email='ramy.ahmed@gmail.com',@branch_Name='Mansoura'
exec YMF.Add_Instructor_PRo @Inst_Name='Ali Nasr',@Inst_Email='ali.nasr@gmail.com',@branch_Name='Menofia'
exec YMF.Add_Instructor_PRo @Inst_Name='Taha Abdelsabour',@Inst_Email='taha.abdelsabour@gmail.com',@branch_Name='Aswan'
exec YMF.Add_Instructor_PRo @Inst_Name='Gorge Iskander',@Inst_Email='gorge.iskander@gmail.com',@branch_Name='Smart village'

select * from ymf.Instructor
DBCC CHECKIDENT ('ymf.Instructor ',reseed,0)



--------------------- insert data into  instuctor address---------------
exec YMF.add_instructor_address_Pro @Ins_Id = 11,@City ='Octobar',@Street ='6 elkashf'
exec YMF.add_instructor_address_Pro @Ins_Id = 4,@City ='Minia',@Street ='Taha hussin'
exec YMF.add_instructor_address_Pro @Ins_Id = 5,@City ='Minia',@Street ='Elgmohoria'
exec YMF.add_instructor_address_Pro @Ins_Id = 6,@City ='Minia-Malawy',@Street ='Elgmohoria'
exec YMF.add_instructor_address_Pro @Ins_Id = 1,@City ='Assuit',@Street ='Elgmohoria'
exec YMF.add_instructor_address_Pro @Ins_Id = 3,@City ='Assuit',@Street ='Elgash'
exec YMF.add_instructor_address_Pro @Ins_Id = 2,@City ='Assuit',@Street ='Elnamace'
exec YMF.add_instructor_address_Pro @Ins_Id = 7,@City ='Sohag',@Street ='15 street'
exec YMF.add_instructor_address_Pro @Ins_Id = 9,@City ='Menofia-Menof',@Street ='elmasry street'
exec YMF.add_instructor_address_Pro @Ins_Id = 10,@City ='Aswan',@Street ='Elkornash'
exec YMF.add_instructor_address_Pro @Ins_Id = 8,@City ='Mansoura',@Street ='Ahmed zaki street'

select * from ymf.Instructor_Address
order by Inst_Id 



---------insert into  course table --------------------------
exec Add_Course_PRo @Crs_Name='Python',@Crs_Description='langauge use to machine learning',
@Crs_Min_Degree=10	,@Crs_Max_Degree=20
exec Add_Course_PRo @Crs_Name='java',@Crs_Description=' high level langauge from sun ',
@Crs_Min_Degree=10	,@Crs_Max_Degree=20
exec Add_Course_PRo @Crs_Name='Javascript',@Crs_Description='high level langauge from ECMA script',
@Crs_Min_Degree=10	,@Crs_Max_Degree=20
exec Add_Course_PRo @Crs_Name='C#',@Crs_Description='high level langauge from Microsoft',
@Crs_Min_Degree=10	,@Crs_Max_Degree=20
exec Add_Course_PRo @Crs_Name='OOP ',@Crs_Description='object oriented programming using c#',
@Crs_Min_Degree=10	,@Crs_Max_Degree=20
exec Add_Course_PRo @Crs_Name='introduction sybersecurity',@Crs_Description='fundamental of syber security',
@Crs_Min_Degree=10	,@Crs_Max_Degree=20
exec Add_Course_PRo @Crs_Name='machine learning',@Crs_Description='this is one of AI courses',
@Crs_Min_Degree=10	,@Crs_Max_Degree=20
exec Add_Course_PRo @Crs_Name='IOT',@Crs_Description='Internet of things',
@Crs_Min_Degree=10	,@Crs_Max_Degree=20
exec Add_Course_PRo @Crs_Name='Intro graphic',@Crs_Description='multimedia course',
@Crs_Min_Degree=10	,@Crs_Max_Degree=20
exec Add_Course_PRo @Crs_Name='HTML',@Crs_Description='hyber text markup language',
@Crs_Min_Degree=10	,@Crs_Max_Degree=20
exec Add_Course_PRo @Crs_Name='CSS',@Crs_Description='casded sytel sheet',
@Crs_Min_Degree=10	,@Crs_Max_Degree=20
exec Add_Course_PRo @Crs_Name='Bootstrap',@Crs_Description='CSS framework',
@Crs_Min_Degree=10	,@Crs_Max_Degree=20
exec Add_Course_PRo @Crs_Name='SQL',@Crs_Description='structure qurey language',
@Crs_Min_Degree=10	,@Crs_Max_Degree=20
exec Add_Course_PRo @Crs_Name='Mango DB',@Crs_Description='database prefer to node js',
@Crs_Min_Degree=10	,@Crs_Max_Degree=20

select * from YMF.Courses

GO



----------- insert data into intake table------------------------------
exec  YMF.Add_Intake @intake_number=43 ,@Dept_Name='software development' ,@Track_Name ='Full stack using .net',
@Branch_Name='Minia';
exec  YMF.Add_Intake @intake_number=43 ,@Dept_Name='software development' ,@Track_Name ='Full stack using mearn',
@Branch_Name='Minia';
exec  YMF.Add_Intake @intake_number=43 ,@Dept_Name='software development' ,@Track_Name ='Full stack using python',
@Branch_Name='Minia';
exec  YMF.Add_Intake @intake_number=43 ,@Dept_Name='Artificial intelligence' ,@Track_Name ='Machine learning',
@Branch_Name='Smart village';
exec  YMF.Add_Intake @intake_number=43 ,@Dept_Name='Multi media' ,@Track_Name ='Social media',
@Branch_Name='Assuit';
exec  YMF.Add_Intake @intake_number=43 ,@Dept_Name='Cyber security' ,@Track_Name ='Introduction syber security',
@Branch_Name='Mansoura';
exec  YMF.Add_Intake @intake_number=43 ,@Dept_Name='Multi media' ,@Track_Name ='UX/UI',
@Branch_Name='Sohag';
exec  YMF.Add_Intake @intake_number=43 ,@Dept_Name='software development' ,@Track_Name ='full stack using mearn',
@Branch_Name='Sohag';
exec  YMF.Add_Intake @intake_number=43 ,@Dept_Name='Testing' ,@Track_Name ='Software testing',
@Branch_Name='Menofia';

select * from YMF.Department
select * from YMF.Branch
select * from YMF.Track
select * from [YMF].[Intake]
order by Intake_Id
DBCC CHECKIDENT ('ymf.Intake',reseed,0)



GO

--------------- insert into  student table-------------------------
exec YMF.Add_Student_PRo @Std_Name='Yehia Zakaria',@Std_Email='yahia@gmail.com',@Intake_Id=1
exec YMF.Add_Student_PRo @Std_Name='Mohamed fouly',@Std_Email='mohamed.fouly@gmail.com',@Intake_Id=1
exec YMF.Add_Student_PRo @Std_Name='Mahmoud Abu Deif',@Std_Email='mahmoud.abudeif@gmail.com',@Intake_Id=1
exec YMF.Add_Student_PRo @Std_Name='Abdo goda',@Std_Email='abdo.goda@gmail.com',@Intake_Id=3
exec YMF.Add_Student_PRo @Std_Name='Abdalla Mohamed',@Std_Email='abdalla.moh@gmail.com',@Intake_Id=2
exec YMF.Add_Student_PRo @Std_Name='Mahmoud Nagy',@Std_Email='mahmoud.nagy@gmail.com',@Intake_Id=1
exec YMF.Add_Student_PRo @Std_Name='Essam Ahmed',@Std_Email='essam.ahmed@gmail.com',@Intake_Id=5
exec YMF.Add_Student_PRo @Std_Name='Ayman Mohamed',@Std_Email='ayman.mon@gmail.com',@Intake_Id=1
exec YMF.Add_Student_PRo @Std_Name='Ali Ahmed',@Std_Email='ali.ahmed@gmail.com',@Intake_Id=1
exec YMF.Add_Student_PRo @Std_Name='Abdo Ali',@Std_Email='abdo.ali@gmail.com',@Intake_Id=3
exec YMF.Add_Student_PRo @Std_Name='Ahmed Mohamed',@Std_Email='ahmed.mohamed@gmail.com',@Intake_Id=2

select * from YMF.Student
select * from YMF.Courses
DBCC CHECKIDENT ('ymf.Student',reseed,0)



GO

-------------insert into  Student course ---------------------
exec YMF.Specific_Course_to_Student @Std_id=1 ,@Crs_id=1
exec YMF.Specific_Course_to_Student @Std_id=1 ,@Crs_id=12
exec YMF.Specific_Course_to_Student @Std_id=1,@Crs_id=13
exec YMF.Specific_Course_to_Student @Std_id=1,@Crs_id=14
exec YMF.Specific_Course_to_Student @Std_id=1,@Crs_id=15

exec YMF.Specific_Course_to_Student @Std_id=2 ,@Crs_id=1
exec YMF.Specific_Course_to_Student @Std_id=2 ,@Crs_id=12
exec YMF.Specific_Course_to_Student @Std_id=2,@Crs_id=14
exec YMF.Specific_Course_to_Student @Std_id=2,@Crs_id=13
exec YMF.Specific_Course_to_Student @Std_id=2,@Crs_id=15


exec YMF.Specific_Course_to_Student @Std_id=3 ,@Crs_id=1
exec YMF.Specific_Course_to_Student @Std_id=3 ,@Crs_id=13
exec YMF.Specific_Course_to_Student @Std_id=3,@Crs_id=14
exec YMF.Specific_Course_to_Student @Std_id=3,@Crs_id=12
exec YMF.Specific_Course_to_Student @Std_id=3,@Crs_id=15






select * from YMF.Student
select * from YMF.Courses

select * from YMF.STudent_Courses


GO


--------------insert into student address table--------------------
exec YMF.add_student_address_Pro  @Std_Id = 1,@City ='Assuit',@Street ='Elgmohoria'
exec YMF.add_student_address_Pro  @Std_Id = 2,@City ='Minia',@Street ='Taha hussin'
exec YMF.add_student_address_Pro  @Std_Id = 3,@City ='Sohag',@Street ='Elgmohoria'
exec YMF.add_student_address_Pro  @Std_Id = 6,@City ='Assuit-Abu tig',@Street ='Elgmohoria'
exec YMF.add_student_address_Pro  @Std_Id = 4,@City ='Cairo',@Street ='Elgmohoria'
exec YMF.add_student_address_Pro  @Std_Id = 9,@City ='Assuit',@Street ='Elgmohoria'
exec YMF.add_student_address_Pro  @Std_Id = 5,@City ='Sohag',@Street ='15 street'
exec YMF.add_student_address_Pro  @Std_Id = 7,@City ='giza',@Street ='eltahrier'

select *from ymf.Student_Address




------------------------------------add Question--------------------------


select * from YMF.Question

exec  YMF.Add_question_PRo @Q_Content='html is hyber text markup language ',@Q_Type='T_F',@Q_answer='true',@Q_ans_A='true',@Q_ans_B='false',@Crs_Id=12
exec  YMF.Add_question_PRo @Q_Content='<div> tag is inline block element ',@Q_Type='T_F',@Q_answer='false',@Q_ans_A='true',@Q_ans_B='false',@Crs_Id=12
exec  YMF.Add_question_PRo @Q_Content='html is programming language ',@Q_Type='T_F',@Q_answer='false',@Q_ans_A='true',@Q_ans_B='false'
exec  YMF.Add_question_PRo @Q_Content='To add image in html we will use  ',@Q_Type='MCQ',@Q_answer='<img>',@Q_ans_A='<i>',@Q_ans_B='<video>',@Q_ans_C='<img>',@Q_ans_D='<br>',@Crs_Id=12
exec  YMF.Add_question_PRo @Q_Content='To add line in html we will use  ',@Q_Type='MCQ',@Q_answer='<hr>',@Q_ans_A='<hr>',@Q_ans_B='<em>',@Q_ans_C='<i>',@Q_ans_D='<br>',@Crs_Id=12
exec  YMF.Add_question_PRo @Q_Content='To write paragraph in html we will use  ',@Q_Type='MCQ',@Q_answer='<p>',@Q_ans_A='<hr>',@Q_ans_B='<p>',@Q_ans_C='<h1>',@Q_ans_D='<mark>',@Crs_Id=12
exec  YMF.Add_question_PRo @Q_Content='<span> tag is inline block element ',@Q_Type='T_F',@Q_answer='true',@Q_ans_A='true',@Q_ans_B='false',@Crs_Id=12
exec YMF.Add_question_PRo @Q_Content='CSS is cascade style sheets ',@Q_Type='T_F',@Q_answer='true',@Q_ans_A='true',@Q_ans_B='false',@Crs_Id=13
exec  YMF.Add_question_PRo @Q_Content='To add line in html we will use  ',@Q_Type='MCQ',@Q_answer='<hr>',@Q_ans_A='<hr>',@Q_ans_B='<em>',@Q_ans_C='<i>',@Q_ans_D='<br>',@Crs_Id=12
exec  YMF.Add_question_PRo @Q_Content='How many styles to link css with html file   ',@Q_Type='MCQ',@Q_answer=4,@Q_ans_A=1,@Q_ans_B=3,@Q_ans_C=4,@Q_ans_D=2,@Crs_Id=13
exec  YMF.Add_question_PRo @Q_Content='Javascript is structural language ',@Q_Type='T_F',@Q_answer='false',@Q_ans_A='true',@Q_ans_B='false',@Crs_Id=6
exec  YMF.Add_question_PRo @Q_Content='JavaScript is a web client side scripting language ',@Q_Type='T_F',@Q_answer='true',@Q_ans_A='true',@Q_ans_B='false',@Crs_Id=6
exec  YMF.Add_question_PRo @Q_Content=' JavaScript is an object-Based language ',@Q_Type='T_F',@Q_answer='true',@Q_ans_A='true',@Q_ans_B='false',@Crs_Id=6
exec  YMF.Add_question_PRo @Q_Content=' JavaScript is Developed by Brendan Eich at Netscape in 1995 ',@Q_Type='T_F',@Q_answer='true',@Q_ans_A='true',@Q_ans_B='false',@Crs_Id=6
exec  YMF.Add_question_PRo @Q_Content=' Bootstrap is a powerful front-end development Framework  ',@Q_Type='T_F',@Q_answer='true',@Q_ans_A='true',@Q_ans_B='false',@Crs_Id=14
exec  YMF.Add_question_PRo @Q_Content='how many way to use bootstrap ',@Q_Type='MCQ',@Q_answer=2,@Q_ans_A=1,@Q_ans_B=2,@Q_ans_C=3,@Q_ans_D=5,@Crs_Id=14

select * from YMF.Courses
select * from YMF.Question
DBCC CHECKIDENT ('YMF.Question',reseed,0)



-----------------------insert into intake exam---------------------------

exec YMF.Assign_Instructor_To_Course @inst_Id=5 ,@Crs_Id=12
exec YMF.Assign_Course_To_Intake @intake_Id=1,@Crs_Id=12,@Inst_Id=5
---
exec YMF.Assign_Instructor_To_Course @inst_Id=5 ,@Crs_Id=6
exec YMF.Assign_Course_To_Intake @intake_Id=1,@Crs_Id=6,@Inst_Id=5
---
exec YMF.Assign_Instructor_To_Course @inst_Id=6 ,@Crs_Id=13
exec YMF.Assign_Course_To_Intake @intake_Id=1,@Crs_Id=13,@Inst_Id=6
---
exec YMF.Assign_Instructor_To_Course @inst_Id=6 ,@Crs_Id=14
exec YMF.Assign_Course_To_Intake @intake_Id=1,@Crs_Id=14,@Inst_Id=6
---YMF.
exec YMF.Assign_Instructor_To_Course @inst_Id=4 ,@Crs_Id=15
exec YMF.Assign_Course_To_Intake @intake_Id=1,@Crs_Id=15,@Inst_Id=4
---YMF.
exec YMF.Assign_Instructor_To_Course @inst_Id=4 ,@Crs_Id=7
exec YMF.Assign_Course_To_Intake @intake_Id=1,@Crs_Id=7,@Inst_Id=4

select *from YMF.Instructor
select * from YMF.Intake_Exam
DBCC CHECKIDENT ('YMF.Intake_Exam',reseed,0)






----------------------create exam-------------------

 exec YMF.pro_Create_Exam @inst_id =5,@crs_id=12,@Type_Exam ='exam',
@Exam_Name ='HTML', @Start_time='09:00',@End_time	='11:00',@Exam_Date='08-31-2023'
---
exec YMF.pro_Create_Exam @inst_id =6,@crs_id=13,@Type_Exam ='exam',
@Exam_Name ='CSS', @Start_time='11:00',@End_time	='13:00',@Exam_Date='09-03-2023'
---
exec YMF.pro_Create_Exam @inst_id =4,@crs_id=15,@Type_Exam ='exam',
@Exam_Name ='SQL', @Start_time='10:00',@End_time	='12:00',@Exam_Date='09-07-2023'

select * from Ymf.Exam
select * from Ymf.Intake_Exam
DBCC CHECKIDENT ('YMF.Exam',reseed,0)




------------------ add question to exam---------------------------
--add random
exec  YMF.select_Question_Random @crs_Id=12,@number_Quest=5,@Exam_Id=1,@inst_id=5,@Q_Degree=2;
--add manual
exec YMF.create_question_PRo @exam_id=2,@Crs_Id=13,@inst_Email='nawal.zaki@gmail.com', 
@Q_Content='class prefix with #  ',@Q_Type='T_F',@Q_Degree=2 , @Q_answer='false'

exec YMF.create_question_PRo @exam_id=2,@Crs_Id=13,@inst_Email='nawal.zaki@gmail.com', 
@Q_Content='Id prefix with #  ',@Q_Type='T_F',@Q_Degree=2 , @Q_answer='true'
--
exec YMF.create_question_PRo @exam_id=3,@Crs_Id=15,@inst_Email='mirhan.mohamed@gmail.com', 
@Q_Content='SQL is structure  query language ',@Q_Type='T_F',@Q_Degree=2 , @Q_answer='true'
exec YMF.create_question_PRo @exam_id=3,@Crs_Id=15,@inst_Email='mirhan.mohamed@gmail.com', 
@Q_Content='store procedure special type of function  ',@Q_Type='T_F',@Q_Degree=2 , @Q_answer='true'
exec YMF.create_question_PRo @exam_id=3,@Crs_Id=15,@inst_Email='mirhan.mohamed@gmail.com', 
@Q_Content='scalar function return table   ',@Q_Type='T_F',@Q_Degree=2 , @Q_answer='false'
exec YMF.create_question_PRo @exam_id=3,@Crs_Id=15,@inst_Email='mirhan.mohamed@gmail.com', 
@Q_Content='we can use insert or update queries inside inline function  ',@Q_Type='T_F',@Q_Degree=2 , @Q_answer='false'


select * from YMF.Exam_Question
select * from YMF.Intake_Exam
select * from YMF.Exam
select * from YMF.Question
select *from ymf.Instructor
select * from ymf.Courses




--------------add exam to student in student exam table----------
exec YMF.Add_Exam_TO_Student @std_id=1,@Exam_id=1,@intake_Id=1
exec YMF.Add_Exam_TO_Student @std_id=3,@Exam_id=1,@intake_Id=1
exec YMF.Add_Exam_TO_Student @std_id=2,@Exam_id=1,@intake_Id=1