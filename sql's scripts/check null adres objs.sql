/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [UGTU_TEST].[dbo].[Street]
  where GUID is null and 
  Ik_gorod in (select G.Ik_gorod from [UGTU_TEST].[dbo].[Gorod] as G inner join [UGTU_TEST].[dbo].[Raion] as Ra
  on G.Ik_raion = Ra.Ik_raion inner join [UGTU_TEST].[dbo].[Region] as Re 
  on Ra.Ik_region = Re.Ik_region  where Re.Ik_strana =2
  )