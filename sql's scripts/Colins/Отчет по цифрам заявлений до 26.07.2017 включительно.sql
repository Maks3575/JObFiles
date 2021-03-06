/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT --COUNT(IDApplication)
		--[IDApplication]

      /*,[ApplicationNumber]
      ,[NeedHostel]
      ,[IDPerson]
      ,[LastName]
      ,[FirstName]
      ,[MiddleName]
      ,[IDGender]
      ,[DateBirth]
      ,[IDCompetitiveGroup]*/
	  --IIF([Faculty] LIKE '%усинск%', 
	  --[IDFaculty]
	  IIF([IDFaculty]=17, 'Филиал УГТУ, Усинск'
			, IIF([IDFaculty]=15, 'Филиал УГТУ, Воркута', 'УГТУ, Ухта'))	[Филиал]		
	  ,[TypeDirection]														[Направление]
      ,[FormEducation]														[Форма обучения]
	  ,[FinancialSource]													[Источник финансирования]
	  ,A.[Speciality]														[Специальность]
      ,SUM(IIF(A.[CompetitiveGroup] LIKE '%целевой%',1,0))					[Целевой прием]
      ,SUM(IIF(A.[CompetitiveGroup] LIKE '%квота%',1,0))					[Особая квота]
      ,SUM(IIF((A.[CompetitiveGroup] NOT LIKE '%целевой%') AND (A.[CompetitiveGroup] NOT LIKE '%квота%'),1,0)) [Общий конкурс]
	  
	  /*
      ,[IDTargetOrganization]
      ,[TargetOrganization]
      ,[DateRegistration]
      ,[AverMark]
      ,[IDStateZachFIS]
      ,[StateZach]
      ,[IDDirection]
      ,[Direction]
      ,[IDTypeDirection]
      ,[TypeDirection]
      ,[IDDirectionFIS]
      ,[IDFormEducation]
      ,[IDFormEducationFIS]
      ,[FormEducation]
      ,[IDFaculty]
      ,[Faculty]
      ,[FacultyShort]
      ,[IDSpeciality]
      ,[IDSpecialityFIS]
      ,[Speciality]
      ,[SpecialityShort]
      ,[IDNationality]
      ,[Nationality]
      ,[IDCategoryZach]
      ,[CategoryZach]
      ,[IDCategoryZachBenefit]
      ,[IDTypeCategoryZach]
      ,[TypeCategoryZach]
      ,[JournalIsActual]
      ,[Year]
      ,[IDOrder]*/
  FROM [UGTU].[FIS].[ApplicationView]		A
  INNER JOIN [FIS].[CompetitiveGroupView]	C ON C.IDCompetitiveGroup = A.IDCompetitiveGroup
  WHERE [Year] = 2017
		AND [DateRegistration] < '27-07-2017'
  GROUP BY A.[Speciality], [TypeDirection], [IDTypeDirection], [FormEducation], [IDFormEducation], [Faculty], [IDFaculty], [CategoryZach], [FinancialSource]
  ORDER BY [IDFaculty] DESC, [IDTypeDirection], [IDFormEducation], [FinancialSource], A.[Speciality]

/*SELECT IDApplication, IDDictionary, IDDocumentFIS, Document 
  FROM [FIS].[ApplicationView] A
  LEFT JOIN [FIS].[DocumentsView] D ON D.IDPerson = A.IDPerson
  WHERE [Year] = 2017
		AND IDDictionary NOT IN (22, 31)
  ORDER BY IDDictionary, IDDocumentFIS*/