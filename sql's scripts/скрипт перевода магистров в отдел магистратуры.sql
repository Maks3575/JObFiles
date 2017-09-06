--ik_direction=3 магистры
--ik_fac = 18 отдел магистратуры
/* скрипт под коментами
update dbo.Relation_spec_fac
set dbo.Relation_spec_fac.ik_fac = 18
where dbo.Relation_spec_fac.ik_spec_fac in 
(
SELECT  distinct
			--Relation_spec_fac.ik_fac,
			--Relation_spec_fac.ik_spec,
			Relation_spec_fac.ik_spec_fac as rsf--,
			--Grup.ik_spec_fac as grsf
		FROM             dbo.Fac INNER JOIN
                         dbo.Relation_spec_fac ON dbo.Fac.Ik_fac = dbo.Relation_spec_fac.ik_fac INNER JOIN
                         dbo.EducationBranch ON dbo.Relation_spec_fac.ik_spec = dbo.EducationBranch.ik_spec INNER JOIN
                         dbo.Grup ON dbo.Relation_spec_fac.ik_spec_fac = dbo.Grup.ik_spec_fac     
WHERE  Grup.[DateExit] > GETDATE() and EducationBranch.ik_direction=3
)*/
go
select *
from dbo.Relation_spec_fac
where ik_spec_fac in (
SELECT  distinct
			--Relation_spec_fac.ik_fac,
			--Relation_spec_fac.ik_spec,
			Relation_spec_fac.ik_spec_fac as rsf--,
			--Grup.ik_spec_fac as grsf
		FROM             dbo.Fac INNER JOIN
                         dbo.Relation_spec_fac ON dbo.Fac.Ik_fac = dbo.Relation_spec_fac.ik_fac INNER JOIN
                         dbo.EducationBranch ON dbo.Relation_spec_fac.ik_spec = dbo.EducationBranch.ik_spec INNER JOIN
                         dbo.Grup ON dbo.Relation_spec_fac.ik_spec_fac = dbo.Grup.ik_spec_fac     
WHERE  Grup.[DateExit] > GETDATE() and EducationBranch.ik_direction=3--3 - магистры
)