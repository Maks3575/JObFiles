WITH allTable as
(SELECT [IDApplication]
      ,[ApplicationNumber]
      ,[NeedHostel]
      ,[IDPerson]
	  ,[LastName]
	  ,[FirstName]
	  ,[MiddleName]
      ,[IDGenderFIS]
      ,[DateBirth]
      ,[IsInvalid]
      ,[IDCompetitiveGroup]
      ,[CompetitiveGroup]
      ,[DateRegistration]
      ,[AverMark]
      ,[IDStateZachFIS]
      ,[StateZach]
      ,[IDFormEducation]
      ,[FormEducation]
      ,[IDFaculty]
      ,[Faculty]
      ,[SpecialityShort]
      ,[IDCategoryZach]
      ,[CategoryZach]
      ,[IDCategoryZachBenefit]
      ,[IDTypeCategoryZach]
      ,[TypeCategoryZach]
      ,[Year]
  FROM [UGTU].[FIS].[ApplicationView]
  WHERE [Year] = 2017
		AND IDFaculty = 18
		AND IDFormEducation = 1 --(1-о, 2-з, 7-оз)
		AND IDNationality = 1)

SELECT * FROM 
(SELECT '01' [№ строки]
		, ISNULL(SUM(IIF (IDTypeCategoryZach = 1, 1, 0)),0)							[Подано заявлений (бюжет)]
		, ISNULL(SUM(IIF (IDCategoryZach = 1 AND IDStateZachFIS = 8, 1, 0)),0)	[Принято заявлений (бюжет)]
		, ISNULL(SUM(IIF (IDCategoryZach = 3, 1, 0)),0)							[Подано заявлений (договор)]
		, ISNULL(SUM(IIF (IDCategoryZach = 3  AND IDStateZachFIS = 8, 1, 0)),0)	[Принято заявлений (договор)]
	FROM allTable) A
UNION
SELECT * FROM 
(SELECT '02' [№ строки]
		, ISNULL(SUM(IIF (IDCategoryZach = 1, 1, 0)),0)							[Подано заявлений (бюжет)]
		, ISNULL(SUM(IIF (IDCategoryZach = 1 AND IDStateZachFIS = 8, 1, 0)),0)	[Принято заявлений (бюжет)]
		, ISNULL(SUM(IIF (IDCategoryZach = 3, 1, 0)),0)							[Подано заявлений (договор)]
		, ISNULL(SUM(IIF (IDCategoryZach = 3  AND IDStateZachFIS = 8, 1, 0)),0)	[Принято заявлений (договор)]
	FROM allTable 
	INNER JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 
						AND EB.ik_direction IN (1, 9, 10)) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth) A
UNION
SELECT * FROM 
(SELECT '03' [№ строки]
		, ISNULL(SUM(IIF (IDCategoryZach = 1, 1, 0)),0)							[Подано заявлений (бюжет)]
		, ISNULL(SUM(IIF (IDCategoryZach = 1 AND IDStateZachFIS = 8, 1, 0)),0)	[Принято заявлений (бюжет)]
		, ISNULL(SUM(IIF (IDCategoryZach = 3, 1, 0)),0)							[Подано заявлений (договор)]
		, ISNULL(SUM(IIF (IDCategoryZach = 3  AND IDStateZachFIS = 8, 1, 0)),0)	[Принято заявлений (договор)]
	FROM allTable 
	INNER JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 
						AND G.DateExit BETWEEN '01-10-2016' AND '30-09-2017'
						AND EB.ik_direction IN (1, 9, 10)) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth) A
UNION
SELECT * FROM 
(SELECT '04' [№ строки]
		, ISNULL(SUM(IIF (IDCategoryZach = 1, 1, 0)),0)							[Подано заявлений (бюжет)]
		, ISNULL(SUM(IIF (IDCategoryZach = 1 AND IDStateZachFIS = 8, 1, 0)),0)	[Принято заявлений (бюжет)]
		, ISNULL(SUM(IIF (IDCategoryZach = 3, 1, 0)),0)							[Подано заявлений (договор)]
		, ISNULL(SUM(IIF (IDCategoryZach = 3  AND IDStateZachFIS = 8, 1, 0)),0)	[Принято заявлений (договор)]
	FROM allTable 
	INNER JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 
						AND EB.ik_direction = 2) P ON P.LastName = allTable.LastName
													  AND P.FirstName = allTable.FirstName
													  AND P.MiddleName = allTable.MiddleName
													  AND P.DateBirth = allTable.DateBirth) A
UNION
SELECT * FROM 
(SELECT '05' [№ строки]
		, ISNULL(SUM(IIF (IDCategoryZach = 1, 1, 0)),0)							[Подано заявлений (бюжет)]
		, ISNULL(SUM(IIF (IDCategoryZach = 1 AND IDStateZachFIS = 8, 1, 0)),0)	[Принято заявлений (бюжет)]
		, ISNULL(SUM(IIF (IDCategoryZach = 3, 1, 0)),0)							[Подано заявлений (договор)]
		, ISNULL(SUM(IIF (IDCategoryZach = 3  AND IDStateZachFIS = 8, 1, 0)),0)	[Принято заявлений (договор)]
	FROM allTable 
	INNER JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 
						AND G.DateExit BETWEEN '01-10-2016' AND '30-09-2017'
						AND EB.ik_direction = 2) P ON P.LastName = allTable.LastName
													  AND P.FirstName = allTable.FirstName
													  AND P.MiddleName = allTable.MiddleName
													  AND P.DateBirth = allTable.DateBirth) A
UNION
SELECT * FROM 
(SELECT '06' [№ строки]
		, ISNULL(SUM(IIF (IDCategoryZach = 1, 1, 0)),0)							[Подано заявлений (бюжет)]
		, ISNULL(SUM(IIF (IDCategoryZach = 1 AND IDStateZachFIS = 8, 1, 0)),0)	[Принято заявлений (бюжет)]
		, ISNULL(SUM(IIF (IDCategoryZach = 3, 1, 0)),0)							[Подано заявлений (договор)]
		, ISNULL(SUM(IIF (IDCategoryZach = 3  AND IDStateZachFIS = 8, 1, 0)),0)	[Принято заявлений (договор)]
	FROM allTable 
	INNER JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 
						AND EB.ik_direction = 3) P ON P.LastName = allTable.LastName
													  AND P.FirstName = allTable.FirstName
													  AND P.MiddleName = allTable.MiddleName
													  AND P.DateBirth = allTable.DateBirth) A
UNION
SELECT * FROM 
(SELECT '07' [№ строки]
		, ISNULL(SUM(IIF (IDCategoryZach = 1, 1, 0)),0)							[Подано заявлений (бюжет)]
		, ISNULL(SUM(IIF (IDCategoryZach = 1 AND IDStateZachFIS = 8, 1, 0)),0)	[Принято заявлений (бюжет)]
		, ISNULL(SUM(IIF (IDCategoryZach = 3, 1, 0)),0)							[Подано заявлений (договор)]
		, ISNULL(SUM(IIF (IDCategoryZach = 3  AND IDStateZachFIS = 8, 1, 0)),0)	[Принято заявлений (договор)]
	FROM allTable 
	INNER JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 
						AND G.DateExit BETWEEN '01-10-2016' AND '30-09-2017'
						AND EB.ik_direction = 3) P ON P.LastName = allTable.LastName
													  AND P.FirstName = allTable.FirstName
													  AND P.MiddleName = allTable.MiddleName
													  AND P.DateBirth = allTable.DateBirth) A
UNION 
SELECT '08', 0, 0, 0, 0
UNION 
SELECT '09', 0, 0, 0, 0
--SELECT * FROM Direction