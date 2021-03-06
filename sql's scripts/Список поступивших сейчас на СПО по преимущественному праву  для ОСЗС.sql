/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT 
   	 --[IDPerson]
	 --,
	 [LastName] as [Фамилия]
     ,[FirstName] as [Имя]
     ,[MiddleName] as [Отчество]
	 ,isNull(P.[cSotTel],'  ')+' '+isNull(P.[ctelefon],'') as [Телефон]
      ,CONVERT(VARCHAR(24),[DateBirth],104) as [Дата Рождения]
     ,[FacultyShort] as [Факультет]
     ,[Speciality] as [Специальность]
  FROM [UGTU].[FIS].[ApplicationView] AV inner join dbo.Person P on Av.IDPerson = P.nCode
  where Year = 2017 and [CategoryZach] = 'преимущественное право' and StateZach = 'зачислен' and TypeDirection = 'СПО'
  order by [Speciality], [LastName], [FirstName],[MiddleName]