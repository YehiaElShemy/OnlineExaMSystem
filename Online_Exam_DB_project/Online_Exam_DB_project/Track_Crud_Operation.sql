
--store procedure to add department

create or alter proc YMF.Add_Track_PRo(@Track_Name nvarchar(50))
as
begin
	IF not EXISTS(select 1 from  YMF.Track where Track_Name=@Track_Name)
		begin
			insert into YMF.Track(Track_Name)
			values(@Track_Name)
		end
	else
	begin
		select 'track is exist';
	end
end

exec YMF.Add_Track_PRo @Track_Name='security';

drop proc YMF.Add_Track_PRo

select * from YMF.Track
Go

--view to select all Track

select * from YMF.Track
--------------------------------------------------
--store procedure to update track
create or alter proc YMF.Update_Track_PRO(@Old_track_Name nvarchar(50),@New_track_Name nvarchar(50))
as 
begin 
	IF EXISTS(select 1 from  YMF.Track where Track_Name=@Old_track_Name)
		begin
			update YMF.Track
				set Track_Name=@New_track_Name
				where Track_Name=@Old_track_Name
		end
	else
	begin
		select 'Track Does not is exist';
	end
end

drop proc Update_Track_PRO
exec YMF.Update_Track_PRO @Old_track_Name='FullStack Using .Net', @New_track_Name='FullStack Using .Net2'
Go

select * from YMF.Track
select * from YMF.Intake

------------------------------------------------



--store procedure to delete track

create or alter proc YMF.Delete_track_PRo(@Delete_Track_Name nvarchar(50))
as 
begin 
	IF EXISTS(select 1 from  YMF.Track where Track_Name=@Delete_Track_Name)
		begin
			delete from YMF.Track
				where Track_Name=@Delete_Track_Name
		end
	else
	begin
		select 'Track Does not is exist';
	end
end

drop proc Delete_track_PRo

exec YMF.Delete_track_PRo @Delete_Track_Name='security'
Go

select * from YMF.Track





-----------------------------------Views Track--------------------------------

GO

create View YMF.Show_All_Track
	with encryption
as
 select * from YMF.Track

select Track_Name from YMF.Show_All_Track 

EXEC sp_helptext 'YMF.Show_All_Track';


GO

