---add instructor

exec YMF.Add_Instructor_PRo @Inst_Name='ali mohamed',@Inst_Email='Alimohamed@gmail.com'


-- add course to instructor
exec YMf.Assign_Instructor_To_Course @inst_Id=5 ,@Crs_Id=6

--add assign to intake ----------------------------

exec YMF.Assign_Course_To_Intake @intake_Id=1,@Crs_Id=6,@Inst_Id=5


-- instructor add exam to course

exec YMF.pro_Create_Exam @inst_id =5,@crs_id=6,@Type_Exam ='exam',
@Exam_Name ='programming', @Start_time='3:00',@End_time='23:00',@Exam_Date='08-31-2023'


exec Ymf.Delete_Exam_PRO @Exam_Id=10

---------------Display all question for this Course
exec YMF.Display_Question_Pool_For_Course @Crs_Id=6;


--------------select manualy question

exec YMF.Select_Question_Manualy @Q_Id=11,@Crs_id=6,@Exam_Id=13,@Inst_Id=5 ,@Q_Degree=5

exec YMF.Delete_Question_from_Exam @exam_id=13,@inst_id=5,@crs_id=6,@Q_ID=11; 

-----------------Select Random Question----------------

exec  YMF.select_Question_Random @crs_Id=6,@number_Quest=4,@Exam_Id=13,@inst_id=5,@Q_Degree=5
GO
----------------------------------------------


--instructor add Question for his exam and his Course


--- ADD STUDENT TO EXAM

select * from YMF.select_Exam_To_Student(6)

--GRANT SELECT ON [YMf].select_Exam_To_Student TO [Ali];


exec YMF.Add_Exam_TO_Student @std_id=6,@Exam_id=13,@intake_Id=1
Select * from Ymf.Student
Select * from Ymf.Exam
-- DISPlay exam
exec  YMF.Display_Exam_To_Student @std_Id=6,@Exam_Id=13;

--GRANT SELECT ON [YMf].Display_Exam_To_Student TO [Ali];


--answer Exam



select * from YMF.Student_Status_Result(6,13)

GRANT SELECT ON [YMf].[Student_Status_Result] TO [Ali];











