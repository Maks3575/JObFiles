/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT  distinct TOP (1000) [Nn_zach]
      ,[docNumber]
      ,[docSeria]
      ,[facShortName]
      ,[specShortName]
  FROM [UGTU].[dbo].[CurrentStudentsIDs]
  where [Nn_zach] ='150395'