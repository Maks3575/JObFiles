/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT 
Rai.Craion + ', ' + Gor.Cgorod as [Прописка]
,P.PersonFullName as [ФИО]
,Gr.Cname_grup as [Группа]
  FROM [UGTU].[dbo].[PersonAddress] as PA inner join [UGTU].[dbo].[Person] as P on PA.nCode = P.nCode
  
  inner join  [UGTU].[dbo].[Address] as A on PA.ik_address = A.ik_address 
  inner join [UGTU].[dbo].[Street] as St on A.Ik_street = St.Ik_street
  inner join  [UGTU].[dbo].[Gorod] as Gor on St.ik_gorod = Gor.Ik_gorod
  inner join  [UGTU].[dbo].[Raion] as Rai on Gor.Ik_raion = Rai.Ik_raion

  inner join [UGTU].[dbo].[Zach] as Za on P.nCode = Za.nCode 
  inner join [UGTU].[dbo].[StudGrup] as SG on Za.Ik_zach = SG.Ik_zach
  inner join  [UGTU].[dbo].[Grup] as Gr on SG.Ik_grup = Gr.Ik_grup
  

  where PA.[ik_AddressType] = 2 --прописка
  and
  Gr.DateExit Like '%2017%'
  AND (SG.ik_pricOtch IS NULL OR SG.ik_pricOtch = 3)
  and ( 
  Rai.Ik_raion = 15 -- Ижемский р-н
  or Gor.Ik_gorod =270 or Gor.Ik_gorod =11051  --Троицко - Печорск
	   )

order by Rai.Craion + ' ' + Gor.Cgorod, P.PersonFullName, Gr.Cname_grup