/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT 
 AV.LastName as [Фамилия]
,AV.FirstName as [Имя]
,isNull(AV.MiddleName, 'не указано') as [Отчество]
,AV.StateZach as [Состояние зачисления]
,AV.Direction as [Направление]
,AV.FormEducation as [Форма обучения]
,AV.SpecialityShort as [Специальность]
,AV.CategoryZach as [Категория зачисления]
,AV.TypeCategoryZach as [Тип категории зачисления]
,AEV.cosenka as [Ко-во баллов] 
,AEV.cname_sdach as [Вид экзамена]
  FROM [UGTU].[FIS].[ApplicationView] as AV
  inner join [UGTU].[dbo].[ABit_Exam_View] as AEV
  -- on AV.IDPerson = AEV.nCode
  on AV.IdApplication = AEV.NN_abit
  where AV.DateRegistration like '%2016%' -- год 
  and	AV.IDSpeciality in (354548, 354549, 354487) -- ИВТ ИСТ ТЛП 
  and	AV.IDStateZachFIS = 8 -- зачисленные
  and   AEV.ik_disc = 2 -- физика
  order by AV.IDSpeciality, AV.LastName, AV.FirstName, AV.MiddleName