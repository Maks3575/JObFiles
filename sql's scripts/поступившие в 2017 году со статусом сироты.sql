select 
FullName as [���]
,FacultyShort as [��������]
,CategoryZach as [��������� ����������]
,FormEducation as [����� ��������]
from [FIS].[ApplicationView]
where Year= 2017 and IDStateZachFIS = 8 and IDCategoryZachBenefit is not null and IsInvalid = 0
order by FullName, FacultyShort, CategoryZach