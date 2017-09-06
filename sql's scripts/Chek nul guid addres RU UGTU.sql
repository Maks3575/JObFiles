
SELECT *
  FROM [UGTU].[dbo].[Region]
  where GUID is null and Ik_strana =2

  go 

  SELECT *
  FROM [UGTU].[dbo].[Raion]
  where GUID is null and 
  Ik_region in (select Reg.Ik_region from [UGTU].[dbo].Region as Reg where Reg.Ik_strana =2
  )

    go 

  SELECT *
  FROM [UGTU].[dbo].[Gorod]
  where GUID is null and 
  Ik_gorod in (select G.Ik_gorod from [UGTU].[dbo].[Gorod] as G inner join [UGTU].[dbo].[Raion] as Ra
  on G.Ik_raion = Ra.Ik_raion inner join [UGTU].[dbo].[Region] as Re 
  on Ra.Ik_region = Re.Ik_region  where Re.Ik_strana =2
  )

      go 

  SELECT *
  FROM [UGTU].[dbo].[Street]
  where GUID is null and 
  Ik_street in (select St.Ik_street  from [UGTU].[dbo].[Street] as St inner join  [UGTU].[dbo].[Gorod] as G 
  on St.ik_gorod = G.ik_gorod
  inner join [UGTU].[dbo].[Raion] as Ra
  on G.Ik_raion = Ra.Ik_raion inner join [UGTU].[dbo].[Region] as Re 
  on Ra.Ik_region = Re.Ik_region  where Re.Ik_strana =2
  )