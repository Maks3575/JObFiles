SELECT 
[IDPerson] 
,B.grupName
,P.PersonFullName
FROM [UGTU].[FIS].[ApplicationView] A 
inner join [UGTU].[dbo].Person P on A.IDPerson = P.nCode
left join (
		SELECT DISTINCT 
		     Person.nCode as studId
			,Grup.Cname_grup as grupName
		FROM             dbo.Fac INNER JOIN
                         dbo.Relation_spec_fac ON dbo.Fac.Ik_fac = dbo.Relation_spec_fac.ik_fac INNER JOIN
                         dbo.EducationBranch ON dbo.Relation_spec_fac.ik_spec = dbo.EducationBranch.ik_spec INNER JOIN
                         dbo.Grup ON dbo.Relation_spec_fac.ik_spec_fac = dbo.Grup.ik_spec_fac INNER JOIN
                         dbo.StudGrup ON dbo.Grup.Ik_grup = dbo.StudGrup.Ik_grup 
							AND StudGrup.[Ik_prikazOtch] is null --AND StudGrup.[Ik_prikazZach] is not null
						 
						 INNER JOIN
                         dbo.Zach ON dbo.StudGrup.Ik_zach = dbo.Zach.Ik_zach INNER JOIN
                         dbo.Student ON dbo.Zach.nCode = dbo.Student.nCode INNER JOIN
                         dbo.Person ON dbo.Student.nCode = dbo.Person.nCode INNER JOIN
                        dbo.Form_ed ON dbo.Relation_spec_fac.Ik_form_ed = dbo.Form_ed.Ik_form_ed
			WHERE  --Grup.Cname_grup like '%17%'
			YEAR(Grup.DateCreate) = 2017 
	) B on A.IDPerson = B.studId
where IDStateZachFIS = 8 
--and PersonFullName like '%Жиленков%'
and [Year] = 2017 
--and A.IDFaculty = 31
--and grupName is not null 
--and IDFormEducation = 1
order by P.PersonFullName