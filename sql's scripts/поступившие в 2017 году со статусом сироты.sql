select 
FullName as [ФИО]
,FacultyShort as [Институт]
,CategoryZach as [Категория зачисления]
,FormEducation as [Форма обучения]
from [FIS].[ApplicationView]
where Year= 2017 and IDStateZachFIS = 8 and IDCategoryZachBenefit is not null and IsInvalid = 0
order by FullName, FacultyShort, CategoryZach