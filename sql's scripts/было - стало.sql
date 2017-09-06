select
--A.idAddress [idAddress] 
distinct 
 A.Region+', '+A.Area+', '+A.typeCity+' '+A.City+', '+A.typeStreet+' '+A.Street as [было]
,B.Region+', '+B.Area+', '+B.typeCity+' '+B.City+', '+B.typeStreet+' '+B.Street as [стало]
, CAST(A.idStreet as  varchar(MAX)) as [OldIdStreet]
from
(
select 
 S.Ik_strana [idCountry]
,S.Cstrana [Country]
,Reg.Ik_region [idRegion]
,Reg.Cregion [Region]
,Rai.Ik_raion [idArea]
,Rai.Craion [Area]
,Gor.Ik_gorod [idCity]
,TGor.cshort_type_gorod [typeCity]
,Gor.Cgorod [City]
,St.Ik_street [idStreet]
,TSt.cshort_type_street [typeStreet]
,St.CStreet [Street]
,Ad.ik_address [idAddress]
from [UGTUTestForAddress2].[dbo].[Strana] S inner join [UGTUTestForAddress2].[dbo].[Region] Reg 
on S.Ik_strana = Reg.Ik_strana and S.Ik_strana = 2 inner join [UGTUTestForAddress2].[dbo].[Raion] Rai 
on Reg.Ik_region = Rai.Ik_region inner join [UGTUTestForAddress2].[dbo].[Gorod] Gor 
on Rai.Ik_raion = Gor.Ik_raion inner join [UGTUTestForAddress2].[dbo].[Street] St 
on Gor.Ik_gorod = St.ik_gorod inner join [UGTUTestForAddress2].[dbo].[Address] Ad
on St.Ik_street = Ad.Ik_street

inner join [UGTUTestForAddress2].[dbo].[type_gorod] TGor 
on Gor.ik_type_gorod = TGor.ik_type_gorod
inner join [UGTUTestForAddress2].[dbo].[Type_street] TSt
on St.Ik_type_street = TSt.Ik_type_street 
) as B inner join 
(
select 
 S.Ik_strana [idCountry]
,S.Cstrana [Country]
,Reg.Ik_region [idRegion]
,Reg.Cregion [Region]
,Rai.Ik_raion [idArea]
,Rai.Craion [Area]
,Gor.Ik_gorod [idCity]
,TGor.cshort_type_gorod [typeCity]
,Gor.Cgorod [City]
,St.Ik_street [idStreet]
,TSt.cshort_type_street [typeStreet]
,St.CStreet [Street]
,Ad.ik_address [idAddress]
from [UGTU].[dbo].[Strana] S inner join [UGTU].[dbo].[Region] Reg 
on S.Ik_strana = Reg.Ik_strana and S.Ik_strana = 2 inner join [UGTU].[dbo].[Raion] Rai 
on Reg.Ik_region = Rai.Ik_region inner join [UGTU].[dbo].[Gorod] Gor 
on Rai.Ik_raion = Gor.Ik_raion inner join [UGTU].[dbo].[Street] St 
on Gor.Ik_gorod = St.ik_gorod inner join [UGTU].[dbo].[Address] Ad
on St.Ik_street = Ad.Ik_street 

inner join [UGTU].[dbo].[type_gorod] TGor 
on Gor.ik_type_gorod = TGor.ik_type_gorod
inner join [UGTU].[dbo].[Type_street] TSt
on St.Ik_type_street = TSt.Ik_type_street 

) as A on B.idAddress = A.idAddress 
--where (B.Region+', '+B.Area+', '+B.City+', '+B.Street) like '%не указано%'
order by (B.Region+', '+B.Area+', '+B.typeCity+' '+B.City+', '+B.typeStreet+' '+B.Street)