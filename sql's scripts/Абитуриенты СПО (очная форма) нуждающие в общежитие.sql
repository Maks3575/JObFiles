/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
USE UGTU

SELECT [Year]				[Cовершенолетний]
		, [Speciality]		[Специальность]
		, SUM([Male])		[Парни]
		, SUM([Female])		[Девушки]

FROM (SELECT IIF(DATEDIFF(Year, [DateBirth], GETDATE()) >= 18, 'Да', 'Нет') [Year]
			,[Speciality]
			,[IDGender]
			,IIF([IDGender]=1,1,0) [Male]
			,IIF([IDGender]=0,1,0) [Female]
		FROM [UGTU].[FIS].[ApplicationView] App
		WHERE [Year] = 2017
				AND [IDStateZachFIS] <> 6
				AND [NeedHostel] = 1
				AND [IDFaculty] = 31
				AND [IDFormEducation] = 1
				) App
  GROUP BY  [Year], [Speciality]
  ORDER BY [Year], [Speciality]

