WITH allTable as
(SELECT [IDApplication]
      ,[ApplicationNumber]
	  ,IDTypeDirection
	  ,TypeDirection
      ,[NeedHostel]
      ,[IDPerson]
	  ,[LastName]
	  ,[FirstName]
	  ,[MiddleName]
      ,[IDGenderFIS]
      ,[DateBirth]
      ,[IsInvalid]
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
		AND IDFormEducation = 2 --(1-оч, 2-з, 7-оз)
		AND IDTypeDirection = 3 --(1-б, 2-с, 3-м, 5-спо)
		AND IDNationality = 1)

SELECT * FROM 
(SELECT '01' [№ строки]
		, ISNULL(COUNT(IDApplication), 0)										[Подано заявлений]
		, ISNULL(SUM(IIF (IDGenderFIS = 2, 1, 0)), 0)							[Подано заявлений (женщины)]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8, 1, 0)), 0)						[Зачислено]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8 AND IDGenderFIS = 2, 1, 0)), 0)	[Зачислено (женщины)]
		, ISNULL(SUM(IIF(P.IDPerson IS NULL, 0, 1)), 0)							[Выпускники прошлых лет]
		, ISNULL(SUM(IIF (P.IDPerson IS NOT NULL AND IDGenderFIS = 2, 1, 0)),0)	[Выпускники прошлых лет (женщины)]
	FROM allTable 
	LEFT JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  --INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  --INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  --INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 ) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth) A
UNION
SELECT * FROM 
(SELECT '02' [№ строки]
		, ISNULL(COUNT(IDApplication), 0)										[Подано заявлений]
		, ISNULL(SUM(IIF (IDGenderFIS = 2, 1, 0)), 0)							[Подано заявлений (женщины)]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8, 1, 0)), 0)						[Зачислено]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8 AND IDGenderFIS = 2, 1, 0)), 0)	[Зачислено (женщины)]
		, ISNULL(SUM(IIF(P.IDPerson IS NULL, 0, 1)), 0)							[Выпускники прошлых лет]
		, ISNULL(SUM(IIF (P.IDPerson IS NOT NULL AND IDGenderFIS = 2, 1, 0)),0)	[Выпускники прошлых лет (женщины)]
	FROM allTable 
	LEFT JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  --INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  --INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  --INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 ) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth
	WHERE DATEDIFF(year, allTable.DateBirth,'01-01-2017') < 15) A
UNION
SELECT * FROM 
(SELECT '03' [№ строки]
		, ISNULL(COUNT(IDApplication), 0)										[Подано заявлений]
		, ISNULL(SUM(IIF (IDGenderFIS = 2, 1, 0)), 0)							[Подано заявлений (женщины)]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8, 1, 0)), 0)						[Зачислено]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8 AND IDGenderFIS = 2, 1, 0)), 0)	[Зачислено (женщины)]
		, ISNULL(SUM(IIF(P.IDPerson IS NULL, 0, 1)), 0)							[Выпускники прошлых лет]
		, ISNULL(SUM(IIF (P.IDPerson IS NOT NULL AND IDGenderFIS = 2, 1, 0)),0)	[Выпускники прошлых лет (женщины)]
	FROM allTable 
	LEFT JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  --INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  --INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  --INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 ) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth
	WHERE DATEDIFF(year, allTable.DateBirth,'01-01-2017') = 15) A
UNION
SELECT * FROM 
(SELECT '04' [№ строки]
		, ISNULL(COUNT(IDApplication), 0)										[Подано заявлений]
		, ISNULL(SUM(IIF (IDGenderFIS = 2, 1, 0)), 0)							[Подано заявлений (женщины)]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8, 1, 0)), 0)						[Зачислено]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8 AND IDGenderFIS = 2, 1, 0)), 0)	[Зачислено (женщины)]
		, ISNULL(SUM(IIF(P.IDPerson IS NULL, 0, 1)), 0)							[Выпускники прошлых лет]
		, ISNULL(SUM(IIF (P.IDPerson IS NOT NULL AND IDGenderFIS = 2, 1, 0)),0)	[Выпускники прошлых лет (женщины)]
	FROM allTable 
	LEFT JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  --INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  --INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  --INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 ) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth
	WHERE DATEDIFF(year, allTable.DateBirth,'01-01-2017') = 16) A
UNION
SELECT * FROM 
(SELECT '05' [№ строки]
		, ISNULL(COUNT(IDApplication), 0)										[Подано заявлений]
		, ISNULL(SUM(IIF (IDGenderFIS = 2, 1, 0)), 0)							[Подано заявлений (женщины)]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8, 1, 0)), 0)						[Зачислено]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8 AND IDGenderFIS = 2, 1, 0)), 0)	[Зачислено (женщины)]
		, ISNULL(SUM(IIF(P.IDPerson IS NULL, 0, 1)), 0)							[Выпускники прошлых лет]
		, ISNULL(SUM(IIF (P.IDPerson IS NOT NULL AND IDGenderFIS = 2, 1, 0)),0)	[Выпускники прошлых лет (женщины)]
	FROM allTable 
	LEFT JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  --INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  --INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  --INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 ) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth
	WHERE DATEDIFF(year, allTable.DateBirth,'01-01-2017') = 17) A
UNION
SELECT * FROM 
(SELECT '06' [№ строки]
		, ISNULL(COUNT(IDApplication), 0)										[Подано заявлений]
		, ISNULL(SUM(IIF (IDGenderFIS = 2, 1, 0)), 0)							[Подано заявлений (женщины)]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8, 1, 0)), 0)						[Зачислено]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8 AND IDGenderFIS = 2, 1, 0)), 0)	[Зачислено (женщины)]
		, ISNULL(SUM(IIF(P.IDPerson IS NULL, 0, 1)), 0)							[Выпускники прошлых лет]
		, ISNULL(SUM(IIF (P.IDPerson IS NOT NULL AND IDGenderFIS = 2, 1, 0)),0)	[Выпускники прошлых лет (женщины)]
	FROM allTable 
	LEFT JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  --INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  --INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  --INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 ) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth
	WHERE DATEDIFF(year, allTable.DateBirth,'01-01-2017') = 18) A
UNION
SELECT * FROM 
(SELECT '07' [№ строки]
		, ISNULL(COUNT(IDApplication), 0)										[Подано заявлений]
		, ISNULL(SUM(IIF (IDGenderFIS = 2, 1, 0)), 0)							[Подано заявлений (женщины)]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8, 1, 0)), 0)						[Зачислено]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8 AND IDGenderFIS = 2, 1, 0)), 0)	[Зачислено (женщины)]
		, ISNULL(SUM(IIF(P.IDPerson IS NULL, 0, 1)), 0)							[Выпускники прошлых лет]
		, ISNULL(SUM(IIF (P.IDPerson IS NOT NULL AND IDGenderFIS = 2, 1, 0)),0)	[Выпускники прошлых лет (женщины)]
	FROM allTable 
	LEFT JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  --INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  --INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  --INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 ) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth
	WHERE DATEDIFF(year, allTable.DateBirth,'01-01-2017') = 19) A
UNION
SELECT * FROM 
(SELECT '08' [№ строки]
		, ISNULL(COUNT(IDApplication), 0)										[Подано заявлений]
		, ISNULL(SUM(IIF (IDGenderFIS = 2, 1, 0)), 0)							[Подано заявлений (женщины)]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8, 1, 0)), 0)						[Зачислено]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8 AND IDGenderFIS = 2, 1, 0)), 0)	[Зачислено (женщины)]
		, ISNULL(SUM(IIF(P.IDPerson IS NULL, 0, 1)), 0)							[Выпускники прошлых лет]
		, ISNULL(SUM(IIF (P.IDPerson IS NOT NULL AND IDGenderFIS = 2, 1, 0)),0)	[Выпускники прошлых лет (женщины)]
	FROM allTable 
	LEFT JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  --INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  --INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  --INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 ) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth
	WHERE DATEDIFF(year, allTable.DateBirth,'01-01-2017') = 20) A
UNION
SELECT * FROM 
(SELECT '09' [№ строки]
		, ISNULL(COUNT(IDApplication), 0)										[Подано заявлений]
		, ISNULL(SUM(IIF (IDGenderFIS = 2, 1, 0)), 0)							[Подано заявлений (женщины)]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8, 1, 0)), 0)						[Зачислено]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8 AND IDGenderFIS = 2, 1, 0)), 0)	[Зачислено (женщины)]
		, ISNULL(SUM(IIF(P.IDPerson IS NULL, 0, 1)), 0)							[Выпускники прошлых лет]
		, ISNULL(SUM(IIF (P.IDPerson IS NOT NULL AND IDGenderFIS = 2, 1, 0)),0)	[Выпускники прошлых лет (женщины)]
	FROM allTable 
	LEFT JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  --INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  --INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  --INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 ) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth
	WHERE DATEDIFF(year, allTable.DateBirth,'01-01-2017') = 21) A
UNION
SELECT * FROM 
(SELECT '10' [№ строки]
		, ISNULL(COUNT(IDApplication), 0)										[Подано заявлений]
		, ISNULL(SUM(IIF (IDGenderFIS = 2, 1, 0)), 0)							[Подано заявлений (женщины)]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8, 1, 0)), 0)						[Зачислено]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8 AND IDGenderFIS = 2, 1, 0)), 0)	[Зачислено (женщины)]
		, ISNULL(SUM(IIF(P.IDPerson IS NULL, 0, 1)), 0)							[Выпускники прошлых лет]
		, ISNULL(SUM(IIF (P.IDPerson IS NOT NULL AND IDGenderFIS = 2, 1, 0)),0)	[Выпускники прошлых лет (женщины)]
	FROM allTable 
	LEFT JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  --INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  --INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  --INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 ) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth
	WHERE DATEDIFF(year, allTable.DateBirth,'01-01-2017') = 22) A
UNION
SELECT * FROM 
(SELECT '11' [№ строки]
		, ISNULL(COUNT(IDApplication), 0)										[Подано заявлений]
		, ISNULL(SUM(IIF (IDGenderFIS = 2, 1, 0)), 0)							[Подано заявлений (женщины)]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8, 1, 0)), 0)						[Зачислено]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8 AND IDGenderFIS = 2, 1, 0)), 0)	[Зачислено (женщины)]
		, ISNULL(SUM(IIF(P.IDPerson IS NULL, 0, 1)), 0)							[Выпускники прошлых лет]
		, ISNULL(SUM(IIF (P.IDPerson IS NOT NULL AND IDGenderFIS = 2, 1, 0)),0)	[Выпускники прошлых лет (женщины)]
	FROM allTable 
	LEFT JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  --INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  --INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  --INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 ) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth
	WHERE DATEDIFF(year, allTable.DateBirth,'01-01-2017') = 23) A
UNION
SELECT * FROM 
(SELECT '12' [№ строки]
		, ISNULL(COUNT(IDApplication), 0)										[Подано заявлений]
		, ISNULL(SUM(IIF (IDGenderFIS = 2, 1, 0)), 0)							[Подано заявлений (женщины)]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8, 1, 0)), 0)						[Зачислено]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8 AND IDGenderFIS = 2, 1, 0)), 0)	[Зачислено (женщины)]
		, ISNULL(SUM(IIF(P.IDPerson IS NULL, 0, 1)), 0)							[Выпускники прошлых лет]
		, ISNULL(SUM(IIF (P.IDPerson IS NOT NULL AND IDGenderFIS = 2, 1, 0)),0)	[Выпускники прошлых лет (женщины)]
	FROM allTable 
	LEFT JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  --INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  --INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  --INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 ) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth
	WHERE DATEDIFF(year, allTable.DateBirth,'01-01-2017') = 24) A
UNION
SELECT * FROM 
(SELECT '13' [№ строки]
		, ISNULL(COUNT(IDApplication), 0)										[Подано заявлений]
		, ISNULL(SUM(IIF (IDGenderFIS = 2, 1, 0)), 0)							[Подано заявлений (женщины)]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8, 1, 0)), 0)						[Зачислено]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8 AND IDGenderFIS = 2, 1, 0)), 0)	[Зачислено (женщины)]
		, ISNULL(SUM(IIF(P.IDPerson IS NULL, 0, 1)), 0)							[Выпускники прошлых лет]
		, ISNULL(SUM(IIF (P.IDPerson IS NOT NULL AND IDGenderFIS = 2, 1, 0)),0)	[Выпускники прошлых лет (женщины)]
	FROM allTable 
	LEFT JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  --INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  --INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  --INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 ) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth
	WHERE DATEDIFF(year, allTable.DateBirth,'01-01-2017') = 25) A
UNION
SELECT * FROM 
(SELECT '14' [№ строки]
		, ISNULL(COUNT(IDApplication), 0)										[Подано заявлений]
		, ISNULL(SUM(IIF (IDGenderFIS = 2, 1, 0)), 0)							[Подано заявлений (женщины)]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8, 1, 0)), 0)						[Зачислено]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8 AND IDGenderFIS = 2, 1, 0)), 0)	[Зачислено (женщины)]
		, ISNULL(SUM(IIF(P.IDPerson IS NULL, 0, 1)), 0)							[Выпускники прошлых лет]
		, ISNULL(SUM(IIF (P.IDPerson IS NOT NULL AND IDGenderFIS = 2, 1, 0)),0)	[Выпускники прошлых лет (женщины)]
	FROM allTable 
	LEFT JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  --INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  --INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  --INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 ) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth
	WHERE DATEDIFF(year, allTable.DateBirth,'01-01-2017') = 26) A
UNION
SELECT * FROM 
(SELECT '15' [№ строки]
		, ISNULL(COUNT(IDApplication), 0)										[Подано заявлений]
		, ISNULL(SUM(IIF (IDGenderFIS = 2, 1, 0)), 0)							[Подано заявлений (женщины)]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8, 1, 0)), 0)						[Зачислено]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8 AND IDGenderFIS = 2, 1, 0)), 0)	[Зачислено (женщины)]
		, ISNULL(SUM(IIF(P.IDPerson IS NULL, 0, 1)), 0)							[Выпускники прошлых лет]
		, ISNULL(SUM(IIF (P.IDPerson IS NOT NULL AND IDGenderFIS = 2, 1, 0)),0)	[Выпускники прошлых лет (женщины)]
	FROM allTable 
	LEFT JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  --INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  --INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  --INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 ) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth
	WHERE DATEDIFF(year, allTable.DateBirth,'01-01-2017') = 27) A
UNION
SELECT * FROM 
(SELECT '16' [№ строки]
		, ISNULL(COUNT(IDApplication), 0)										[Подано заявлений]
		, ISNULL(SUM(IIF (IDGenderFIS = 2, 1, 0)), 0)							[Подано заявлений (женщины)]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8, 1, 0)), 0)						[Зачислено]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8 AND IDGenderFIS = 2, 1, 0)), 0)	[Зачислено (женщины)]
		, ISNULL(SUM(IIF(P.IDPerson IS NULL, 0, 1)), 0)							[Выпускники прошлых лет]
		, ISNULL(SUM(IIF (P.IDPerson IS NOT NULL AND IDGenderFIS = 2, 1, 0)),0)	[Выпускники прошлых лет (женщины)]
	FROM allTable 
	LEFT JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  --INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  --INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  --INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 ) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth
	WHERE DATEDIFF(year, allTable.DateBirth,'01-01-2017') = 28) A
UNION
SELECT * FROM 
(SELECT '17' [№ строки]
		, ISNULL(COUNT(IDApplication), 0)										[Подано заявлений]
		, ISNULL(SUM(IIF (IDGenderFIS = 2, 1, 0)), 0)							[Подано заявлений (женщины)]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8, 1, 0)), 0)						[Зачислено]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8 AND IDGenderFIS = 2, 1, 0)), 0)	[Зачислено (женщины)]
		, ISNULL(SUM(IIF(P.IDPerson IS NULL, 0, 1)), 0)							[Выпускники прошлых лет]
		, ISNULL(SUM(IIF (P.IDPerson IS NOT NULL AND IDGenderFIS = 2, 1, 0)),0)	[Выпускники прошлых лет (женщины)]
	FROM allTable 
	LEFT JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  --INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  --INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  --INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 ) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth
	WHERE DATEDIFF(year, allTable.DateBirth,'01-01-2017') = 29) A
UNION
SELECT * FROM 
(SELECT '18' [№ строки]
		, ISNULL(COUNT(IDApplication), 0)										[Подано заявлений]
		, ISNULL(SUM(IIF (IDGenderFIS = 2, 1, 0)), 0)							[Подано заявлений (женщины)]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8, 1, 0)), 0)						[Зачислено]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8 AND IDGenderFIS = 2, 1, 0)), 0)	[Зачислено (женщины)]
		, ISNULL(SUM(IIF(P.IDPerson IS NULL, 0, 1)), 0)							[Выпускники прошлых лет]
		, ISNULL(SUM(IIF (P.IDPerson IS NOT NULL AND IDGenderFIS = 2, 1, 0)),0)	[Выпускники прошлых лет (женщины)]
	FROM allTable 
	LEFT JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  --INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  --INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  --INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 ) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth
	WHERE DATEDIFF(year, allTable.DateBirth,'01-01-2017') BETWEEN 30 AND 34) A
UNION
SELECT * FROM 
(SELECT '19' [№ строки]
		, ISNULL(COUNT(IDApplication), 0)										[Подано заявлений]
		, ISNULL(SUM(IIF (IDGenderFIS = 2, 1, 0)), 0)							[Подано заявлений (женщины)]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8, 1, 0)), 0)						[Зачислено]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8 AND IDGenderFIS = 2, 1, 0)), 0)	[Зачислено (женщины)]
		, ISNULL(SUM(IIF(P.IDPerson IS NULL, 0, 1)), 0)							[Выпускники прошлых лет]
		, ISNULL(SUM(IIF (P.IDPerson IS NOT NULL AND IDGenderFIS = 2, 1, 0)),0)	[Выпускники прошлых лет (женщины)]
	FROM allTable 
	LEFT JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  --INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  --INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  --INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 ) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth
	WHERE DATEDIFF(year, allTable.DateBirth,'01-01-2017') BETWEEN 35 AND 39) A
UNION
SELECT * FROM 
(SELECT '20' [№ строки]
		, ISNULL(COUNT(IDApplication), 0)										[Подано заявлений]
		, ISNULL(SUM(IIF (IDGenderFIS = 2, 1, 0)), 0)							[Подано заявлений (женщины)]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8, 1, 0)), 0)						[Зачислено]
		, ISNULL(SUM(IIF (IDStateZachFIS = 8 AND IDGenderFIS = 2, 1, 0)), 0)	[Зачислено (женщины)]
		, ISNULL(SUM(IIF(P.IDPerson IS NULL, 0, 1)), 0)							[Выпускники прошлых лет]
		, ISNULL(SUM(IIF (P.IDPerson IS NOT NULL AND IDGenderFIS = 2, 1, 0)),0)	[Выпускники прошлых лет (женщины)]
	FROM allTable 
	LEFT JOIN (SELECT P.nCode [IDPerson]
					  ,P.Clastname [LastName]
					  ,P.Cfirstname [FirstName]
					  ,P.Cotch [MiddleName]
					  ,P.Dd_birth [DateBirth] 
				  FROM Person P
				  INNER JOIN Zach					ON Zach.nCode = P.nCode
				  INNER JOIN StudGrup			SG	ON SG.Ik_zach = Zach.Ik_zach
				  --INNER JOIN Grup				G	ON G.Ik_grup = SG.Ik_grup
				  --INNER JOIN Relation_spec_fac	RSF	ON RSF.ik_spec_fac = G.ik_spec_fac
				  --INNER JOIN EducationBranch	EB	ON EB.ik_spec = RSF.ik_spec
				  WHERE SG.ik_pricOtch = 3 ) P ON P.LastName = allTable.LastName
																AND P.FirstName = allTable.FirstName
																AND P.MiddleName = allTable.MiddleName
																AND P.DateBirth = allTable.DateBirth
	WHERE DATEDIFF(year, allTable.DateBirth,'01-01-2017') > 39) A