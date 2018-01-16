select 
zs.cName_zaved, count(*) as kol, IIF(av.IDTypeDirection not in (5),'бон', 'яон') as typeOb
from [FIS].[ApplicationView] av 
left join [dbo].[Student] s on av.IDPerson = s.nCode
left join [dbo].[Zaved_stud] zs on s.Ik_zaved = zs.ik_zaved
left join [dbo].[Gorod] g on zs.Ik_gorod = g.Ik_gorod
where av.Year = 2017 and av.IDStateZachFIS = 8 and (g.Cgorod like '%СУР%' or zs.cName_zaved like '%СУР%') 
group by zs.cName_zaved, IIF(av.IDTypeDirection not in (5),'бон', 'яон')
order by zs.cName_zaved asc--, kol desc