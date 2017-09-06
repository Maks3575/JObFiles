select *
from UGTU_TEST.dbo.Raion
where
Ik_region in (select Ik_region from 
UGTU_TEST.dbo.Region
where Ik_strana = 2 
) and (GUID is null or GUID = '00000000-0000-0000-0000-000000000000')
--and Ik_gorod in(select distinct Ik_gorod from UGTU_TEST.dbo.Zaved_stud) 
order by Craion, GUID
