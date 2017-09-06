select *
from UGTU_TEST.dbo.Street
where
ik_gorod in (select st.ik_gorod from UGTU_TEST.dbo.Street st inner join 
UGTU_TEST.dbo.Gorod g on st.ik_gorod = g.ik_gorod inner join 
UGTU_TEST.dbo.Raion ra on g.Ik_raion = ra.Ik_raion inner join 
UGTU_TEST.dbo.Region re on ra.Ik_region = re.Ik_region 
where Ik_strana = 2 
) and (GUID is not null or GUID = '00000000-0000-0000-0000-000000000000')
--and Ik_gorod in(select distinct Ik_gorod from UGTU_TEST.dbo.Zaved_stud) 
order by CStreet, GUID