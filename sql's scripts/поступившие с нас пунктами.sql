select
reg.Cregion [Регион]
, r.Craion [Район]
, g.Cgorod [Нас. пункт]
, zs.cName_zaved [Название заведения]
, count(*) [Количество]
, IIF(av.IDTypeDirection not in (5),'ВПО', 'СПО') [Оброзование]
from [FIS].[ApplicationView] av 
left join [dbo].[Student] s on av.IDPerson = s.nCode
left join [dbo].[Zaved_stud] zs on s.Ik_zaved = zs.ik_zaved
left join [dbo].[Gorod] g on zs.Ik_gorod = g.Ik_gorod
left join [dbo].[Raion] r on g.Ik_raion = r.Ik_raion
left join [dbo].[Region] reg on r.Ik_region = reg.Ik_region

where av.Year = 2017 and av.IDStateZachFIS = 8 
and reg.Ik_region in (18719 -- Komi
,18724 -- Arhangel obl
,18736 -- Kirovskaya obl
,18722 --Vologodskaya obl
) 
--(g.Cgorod like '%ухт%' or zs.cName_zaved like '%ухт%') 
group by reg.Cregion, r.Craion, g.Cgorod, zs.cName_zaved, IIF(av.IDTypeDirection not in (5),'ВПО', 'СПО')
order by reg.Cregion, r.Craion, g.Cgorod, zs.cName_zaved asc--, kol desc