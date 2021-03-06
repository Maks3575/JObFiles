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
(SELECT '01'	[№ строки]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)		[Подано заявлений (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)		[Принято (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)		[Подано заявлений (договор)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)		[Принято (договор)]
	FROM allTable) A
UNION
SELECT * FROM 
(SELECT '02' [№ строки]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)	[Подано заявлений (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)	[Принято (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)	[Подано заявлений (договор)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)	[Принято (договор)]
	FROM allTable 
	LEFT JOIN (SELECT IDPerson
					  ,SUM(IIF(IDDocumentFIS IN  (4,7,25,26), 1, 0))	[CountV]
					  ,SUM(IIF(IDDocumentFIS = 3, 1, 0))				[CountS]
					  ,SUM(IIF(IDDocumentFIS = 5, 1, 0))				[CountSPRO]
				FROM [FIS].[DocumentsView]
				WHERE IDDictionaryFIS = 31
				GROUP BY IDPerson) DV	ON DV.IDPerson = allTable.IDPerson
	WHERE ISNULL(DV.CountV,0) = 0 
		  AND ISNULL(DV.CountSPRO,0) = 0
		  AND DV.CountS > 0) A
UNION
SELECT * FROM 
(SELECT '03' [№ строки]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)	[Подано заявлений (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)	[Принято (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)	[Подано заявлений (договор)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)	[Принято (договор)]
	FROM allTable 
	LEFT JOIN (SELECT IDPerson
					  ,SUM(IIF(IDDocumentFIS IN  (4,7,25,26), 1, 0))	[CountV]
					  ,SUM(IIF(IDDocumentFIS = 3, 1, 0))				[CountS]
					  ,SUM(IIF(IDDocumentFIS = 5, 1, 0))				[CountSPRO]
				FROM [FIS].[DocumentsView]
				WHERE IDDictionaryFIS = 31
						AND DateDocument BETWEEN '01-10-2016' AND '30-09-2017'
				GROUP BY IDPerson) DV	ON DV.IDPerson = allTable.IDPerson
	WHERE ISNULL(DV.CountV,0) = 0 
		  AND ISNULL(DV.CountSPRO,0) = 0
		  AND DV.CountS > 0) A
UNION
SELECT * FROM 
(SELECT '04' [№ строки]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)	[Подано заявлений (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)	[Принято (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)	[Подано заявлений (договор)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)	[Принято (договор)]
	FROM allTable 
	LEFT JOIN (SELECT IDPerson
					  ,SUM(IIF(IDDocumentFIS IN  (4,7,25,26), 1, 0))	[CountV]
					  ,SUM(IIF(IDDocumentFIS = 3, 1, 0))				[CountS]
					  ,SUM(IIF(IDDocumentFIS = 5, 1, 0))				[CountSPRO]
				FROM [FIS].[DocumentsView]
				WHERE IDDictionaryFIS = 31
						AND DateDocument BETWEEN '01-10-2016' AND '30-09-2017'
				GROUP BY IDPerson) DV	ON DV.IDPerson = allTable.IDPerson
	WHERE ISNULL(DV.CountV,0) = 0 
		  AND ISNULL(DV.CountSPRO,0) = 0
		  AND DV.CountS > 0) A
UNION
SELECT '05',0,0,0,0
UNION
SELECT '06',0,0,0,0
UNION
SELECT '07',0,0,0,0
UNION 
SELECT * FROM 
(SELECT '08' [№ строки]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)	[Подано заявлений (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)	[Принято (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)	[Подано заявлений (договор)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)	[Принято (договор)]
	FROM allTable 
	LEFT JOIN (SELECT IDPerson
					  ,SUM(IIF(IDDocumentFIS IN  (4,7,25,26), 1, 0))	[CountV]
					  ,SUM(IIF(IDDocumentFIS = 3, 1, 0))				[CountS]
					  ,SUM(IIF(IDDocumentFIS = 5, 1, 0))				[CountSPRO]
				FROM [FIS].[DocumentsView]
				WHERE IDDictionaryFIS = 31
				GROUP BY IDPerson) DV	ON DV.IDPerson = allTable.IDPerson
	WHERE ISNULL(DV.CountV,0) = 0 
		  AND ISNULL(DV.CountS,0) = 0
		  AND DV.CountSPRO > 0) A
UNION
SELECT * FROM 
(SELECT '09' [№ строки]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)	[Подано заявлений (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 14, 1, 0)), 0)	[Принято (бюджет)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)	[Подано заявлений (договор)]
		, ISNULL(SUM(IIF(IDTypeCategoryZach = 15, 1, 0)), 0)	[Принято (договор)]
	FROM allTable 
	LEFT JOIN (SELECT IDPerson
					  ,SUM(IIF(IDDocumentFIS IN  (4,7,25,26), 1, 0))	[CountV]
					  ,SUM(IIF(IDDocumentFIS = 3, 1, 0))				[CountS]
					  ,SUM(IIF(IDDocumentFIS = 5, 1, 0))				[CountSPRO]
				FROM [FIS].[DocumentsView]
				WHERE IDDictionaryFIS = 31
					  AND DateDocument BETWEEN '01-10-2016' AND '30-09-2017'
				GROUP BY IDPerson) DV	ON DV.IDPerson = allTable.IDPerson
	WHERE ISNULL(DV.CountV,0) = 0 
		  AND ISNULL(DV.CountS,0) = 0
		  AND DV.CountSPRO > 0) A