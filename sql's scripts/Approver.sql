/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [id]
      ,[DateBegin]
      ,[DateEnd]
      ,[idApproverType]
      ,[idDepartment]
      ,[idEmployee]
  FROM [Kadr].[ShemaTabel].[Approver]
  where [DateEnd] is null and [idDepartment] 