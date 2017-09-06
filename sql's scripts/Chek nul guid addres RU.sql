
SELECT *
  FROM [UGTUTestForAddress2].[dbo].[Region]
  where GUID is null and Ik_strana =2

  go 

  SELECT *
  FROM [UGTUTestForAddress2].[dbo].[Raion]
  where GUID is null and 
  Ik_region in (select Reg.Ik_region from [UGTUTestForAddress2].[dbo].Region as Reg where Reg.Ik_strana =2
  )

    go 

  SELECT *
  FROM [UGTUTestForAddress2].[dbo].[Gorod]
  where GUID is null and 
  Ik_gorod in (select G.Ik_gorod from [UGTUTestForAddress2].[dbo].[Gorod] as G inner join [UGTUTestForAddress2].[dbo].[Raion] as Ra
  on G.Ik_raion = Ra.Ik_raion inner join [UGTUTestForAddress2].[dbo].[Region] as Re 
  on Ra.Ik_region = Re.Ik_region  where Re.Ik_strana =2
  )

      go 

  SELECT *
  FROM [UGTUTestForAddress2].[dbo].[Street]
  where GUID is null and 
  Ik_street in (select St.Ik_street  from [UGTUTestForAddress2].[dbo].[Street] as St inner join  [UGTUTestForAddress2].[dbo].[Gorod] as G 
  on St.ik_gorod = G.ik_gorod
  inner join [UGTUTestForAddress2].[dbo].[Raion] as Ra
  on G.Ik_raion = Ra.Ik_raion inner join [UGTUTestForAddress2].[dbo].[Region] as Re 
  on Ra.Ik_region = Re.Ik_region  where Re.Ik_strana =2
  )