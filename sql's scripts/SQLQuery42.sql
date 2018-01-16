WITH allTableAV as
(SELECT 
	   AV.[IDApplication]
      ,AV.[ApplicationNumber]
      ,AV.[NeedHostel]
      ,AV.[IDPerson]
      ,AV.[FullName]
      ,AV.[IDGenderFIS]
      ,AV.[DateBirth]
      ,AV.[IsInvalid]
      ,AV.[IDCompetitiveGroup]
      ,AV.[CompetitiveGroup]
      ,AV.[DateRegistration]
      ,AV.[AverMark]
      ,AV.[IDStateZachFIS]
      ,AV.[StateZach]
      ,AV.[IDFormEducation]
      ,AV.[FormEducation]
      ,AV.[IDFaculty]
      ,AV.[Faculty]
      ,AV.[SpecialityShort]
      ,AV.[IDCategoryZach]
      ,AV.[CategoryZach]
      ,AV.[IDCategoryZachBenefit]
      ,AV.[IDTypeCategoryZach]
      ,AV.[TypeCategoryZach]
      ,AV.[Year]
 
  FROM [UGTU].[FIS].[ApplicationView] AV
  WHERE ([Year] = 2017 or [Year] = 2016)
 )
 
-- WITH allTableDV as
--(SELECT DV.[IDPerson]


--	  ,DV.[IDDocument]
--      ,DV.[DocumentSeria]
--      ,DV.[DocumentNumber]
--      ,DV.[DateDocument]
--      ,DV.[Document]
--      ,DV.[DocumentOrganization]
--      ,DV.[IDDocumentFIS]
--      ,DV.[IDDictionaryFIS]
--      ,DV.[BonusBall]
 
--  FROM [UGTU].[FIS].[DocumentsView] DV
-- )

SELECT * FROM 
(SELECT '01' [№ строки]
    , SUM(IIF (IDCategoryZach = 1, 1, 0)) [Подано заявлений (бюджет)]
    , SUM(IIF (IDCategoryZach = 1 AND IDStateZachFIS = 8, 1, 0)) [Принято заявлений (бюджет)]
    , SUM(IIF (IDCategoryZach = 3, 1, 0)) [Подано заявлений (договор)]
    , SUM(IIF (IDCategoryZach = 3  AND IDStateZachFIS = 8, 1, 0)) [Принято заявлений (договор)]
  FROM allTableAV) A