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
		AND IDFormEducation = 1 --(1-оч, 2-з, 7-оз)
		AND IDTypeDirection = 1 --(1-б, 2-с, 3-м, 5-спо)
		AND IDNationality = 1)

SELECT * FROM 
(SELECT '01' [№ строки]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)	[Подано заявлений (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)	[Принято (бюджет)]
		, 0														[Из них преимущественное право (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)	[Подано заявлений (договор)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)	[Принято (договор)]
		, 0														[Из них преимущественное право (договор)]
	FROM allTable) A
UNION
SELECT * FROM 
(SELECT '02' [№ строки]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)	[Подано заявлений (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)	[Принято (бюджет)]
		, 0														[Из них преимущественное право (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)	[Подано заявлений (договор)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)	[Принято (договор)]
		, 0														[Из них преимущественное право (договор)]
	FROM allTable 
	LEFT JOIN (SELECT IDPerson
					  ,COUNT(Document)		[Count]
				FROM [FIS].[DocumentsView]
				WHERE IDDictionaryFIS = 31
					  AND IDDocumentFIS IN  (4,7,25,26)
				GROUP BY IDPerson) DV	ON DV.IDPerson = allTable.IDPerson
	WHERE DV.Count = 0 OR DV.Count IS NULL) A
UNION
SELECT * FROM 
(SELECT '03' [№ строки]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)	[Подано заявлений (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)	[Принято (бюджет)]
		, 0														[Из них преимущественное право (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)	[Подано заявлений (договор)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)	[Принято (договор)]
		, 0														[Из них преимущественное право (договор)]
	FROM allTable 
	LEFT JOIN (SELECT IDPerson
					  ,COUNT(Document)		[Count]
				FROM [FIS].[DocumentsView]
				WHERE IDDictionaryFIS = 31
					  AND IDDocumentFIS IN  (4,7,25,26)
				GROUP BY IDPerson) DV	ON DV.IDPerson = allTable.IDPerson
	INNER JOIN (SELECT IDPerson
					  , SUM(IIF(IDTypeExamFIS = 1, 1, 0)) [EGE]
					  , SUM(IIF(IDTypeExamFIS = 2, 1, 0)) [EXAM] 
				FROM [FIS].[ExamView]
				GROUP BY IDPerson) EV	ON EV.IDPerson = allTable.IDPerson
										   AND EV.[EGE] > 0
										   AND EV.EXAM = 0

	WHERE DV.Count = 0 OR DV.Count IS NULL) A
UNION
SELECT * FROM 
(SELECT '04' [№ строки]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)	[Подано заявлений (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)	[Принято (бюджет)]
		, 0														[Из них преимущественное право (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)	[Подано заявлений (договор)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)	[Принято (договор)]
		, 0														[Из них преимущественное право (договор)]
	FROM allTable 
	LEFT JOIN (SELECT IDPerson
					  ,COUNT(Document)		[Count]
				FROM [FIS].[DocumentsView]
				WHERE IDDictionaryFIS = 31
					  AND IDDocumentFIS IN  (4,7,25,26)
				GROUP BY IDPerson) DV	ON DV.IDPerson = allTable.IDPerson
	INNER JOIN (SELECT IDPerson
					  , SUM(IIF(IDTypeExamFIS = 1, 1, 0)) [EGE]
					  , SUM(IIF(IDTypeExamFIS = 2, 1, 0)) [EXAM] 
				FROM [FIS].[ExamView]
				GROUP BY IDPerson) EV	ON EV.IDPerson = allTable.IDPerson
										   AND EV.[EGE] > 0
										   AND EV.EXAM > 0

	WHERE DV.Count = 0 OR DV.Count IS NULL) A
UNION
SELECT * FROM 
(SELECT '05' [№ строки]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)	[Подано заявлений (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)	[Принято (бюджет)]
		, 0														[Из них преимущественное право (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)	[Подано заявлений (договор)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)	[Принято (договор)]
		, 0														[Из них преимущественное право (договор)]
	FROM allTable 
	LEFT JOIN (SELECT IDPerson
					  ,COUNT(Document)		[Count]
				FROM [FIS].[DocumentsView]
				WHERE IDDictionaryFIS = 31
					  AND IDDocumentFIS IN  (4,7,25,26)
				GROUP BY IDPerson) DV	ON DV.IDPerson = allTable.IDPerson
	INNER JOIN (SELECT IDPerson
					  , SUM(IIF(IDTypeExamFIS = 1, 1, 0)) [EGE]
					  , SUM(IIF(IDTypeExamFIS = 2, 1, 0)) [EXAM] 
				FROM [FIS].[ExamView]
				GROUP BY IDPerson) EV	ON EV.IDPerson = allTable.IDPerson
										   AND EV.[EGE] = 0
										   AND EV.EXAM < 0

	WHERE DV.Count = 0 OR DV.Count IS NULL) A
UNION
SELECT '06', 0, 0, 0, 0, 0, 0
UNION
SELECT '07', 0, 0, 0, 0, 0, 0
UNION
SELECT * FROM 
(SELECT '08' [№ строки]
		, ISNULL(SUM(IIF(IDCategoryZachBenefit = 4 AND IDTypeCategoryZach = 14, 1, 0)), 0)	[Подано заявлений (бюджет)]
		, ISNULL(SUM(IIF(IDCategoryZachBenefit = 4 AND IDTypeCategoryZach = 14, 1, 0)), 0)	[Принято (бюджет)]
		, ISNULL(SUM(IIF(IDCategoryZachBenefit = 5 AND IDTypeCategoryZach = 14, 1, 0)), 0)	[Из них преимущественное право (бюджет)]
		, 0																					[Подано заявлений (договор)]
		, 0																					[Принято (договор)]
		, 0																					[Из них преимущественное право (договор)]
	FROM allTable 
	LEFT JOIN (SELECT IDPerson
					  ,COUNT(Document)		[Count]
				FROM [FIS].[DocumentsView]
				WHERE IDDictionaryFIS = 31
					  AND IDDocumentFIS IN  (4,7,25,26)
				GROUP BY IDPerson) DV	ON DV.IDPerson = allTable.IDPerson
	WHERE (DV.Count = 0 OR DV.Count IS NULL) AND IDCategoryZachBenefit IN (4, 5)) A
UNION
SELECT * FROM 
(SELECT '09' [№ строки]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)								[Подано заявлений (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)								[Принято (бюджет)]
		, ISNULL(SUM(IIF(IDCategoryZachBenefit = 5 AND IDTypeCategoryZach = 14, 1, 0)), 0)	[Из них преимущественное право (бюджет)]
		, 0 																				[Подано заявлений (договор)]
		, 0 																				[Принято (договор)]
		, 0 																				[Из них преимущественное право (договор)]
	FROM allTable 
	LEFT JOIN (SELECT IDPerson
					  ,COUNT(Document)		[Count]
				FROM [FIS].[DocumentsView]
				WHERE IDDictionaryFIS = 31
					  AND IDDocumentFIS IN  (4,7,25,26)
				GROUP BY IDPerson) DV	ON DV.IDPerson = allTable.IDPerson
	WHERE (DV.Count = 0 OR DV.Count IS NULL) AND IDCategoryZach = 2) A
UNION
SELECT * FROM 
(SELECT '10' [№ строки]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)								[Подано заявлений (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)								[Принято (бюджет)]
		, ISNULL(SUM(IIF(IDCategoryZachBenefit = 5 AND IDTypeCategoryZach = 14, 1, 0)), 0)	[Из них преимущественное право (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)								[Подано заявлений (договор)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)								[Принято (договор)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15 AND IDCategoryZachBenefit = 5, 1, 0)), 0)	[Из них преимущественное право (договор)]
	FROM allTable 
	LEFT JOIN (SELECT IDPerson
					  ,COUNT(Document)		[Count]
				FROM [FIS].[DocumentsView]
				WHERE IDDictionaryFIS = 31
					  AND IDDocumentFIS IN  (4,7,25,26)
				GROUP BY IDPerson) DV	ON DV.IDPerson = allTable.IDPerson
	WHERE (DV.Count = 0 OR DV.Count IS NULL) AND IDCategoryZach = 1) A
UNION
SELECT '11', 0, 0, 0, 0, 0, 0
UNION
SELECT * FROM 
(SELECT '12' [№ строки]
		, 0														[Подано заявлений (бюджет)]
		, 0														[Принято (бюджет)]
		, 0														[Из них преимущественное право (бюджет)]
		, ISNULL(COUNT(IDApplication), 0)						[Подано заявлений (договор)]
		, ISNULL(COUNT(IDApplication), 0)						[Принято (договор)]
		, ISNULL(SUM(IIF(IDCategoryZachBenefit = 5, 1, 0)), 0)	[Из них преимущественное право (договор)]
	FROM allTable 
	LEFT JOIN (SELECT IDPerson
					  ,COUNT(Document)		[Count]
				FROM [FIS].[DocumentsView]
				WHERE IDDictionaryFIS = 31
					  AND IDDocumentFIS IN  (4,7,25,26)
				GROUP BY IDPerson) DV	ON DV.IDPerson = allTable.IDPerson
	WHERE DV.Count > 0 AND IDTypeCategoryZach = 15) A