select 
		a.Cname_fac
		,a.Cname_form_ed as [Форма обучения]
		, Count(a.Ik_form_ed) as [Количество] 
from
(SELECT DISTINCT 
			Fac.Ik_fac as Ik_fac
			,Fac.Cname_fac as Cname_fac
			,EducationBranch.Cname_spec as Cname_spec
			,Form_ed.Ik_form_ed  as  Ik_form_ed
			,Form_ed.Cname_form_ed  as  Cname_form_ed
			,Zach.Ik_zach as Ik_zach
			,Zach.nCode as nCode
			,EducationBranch.ik_spec  as ik_spec
		FROM             dbo.Fac INNER JOIN
                         dbo.Relation_spec_fac ON dbo.Fac.Ik_fac = dbo.Relation_spec_fac.ik_fac INNER JOIN
                         dbo.EducationBranch ON dbo.Relation_spec_fac.ik_spec = dbo.EducationBranch.ik_spec INNER JOIN
                         dbo.Grup ON dbo.Relation_spec_fac.ik_spec_fac = dbo.Grup.ik_spec_fac INNER JOIN
                         dbo.StudGrup ON dbo.Grup.Ik_grup = dbo.StudGrup.Ik_grup 
							AND StudGrup.[Ik_prikazOtch] is null AND StudGrup.[Ik_prikazZach] is not null
						 
						 INNER JOIN
                         dbo.Zach ON dbo.StudGrup.Ik_zach = dbo.Zach.Ik_zach INNER JOIN
                         dbo.Student ON dbo.Zach.nCode = dbo.Student.nCode INNER JOIN
                         dbo.Person ON dbo.Student.nCode = dbo.Person.nCode INNER JOIN
                        dbo.Form_ed ON dbo.Relation_spec_fac.Ik_form_ed = dbo.Form_ed.Ik_form_ed --INNER JOIN
			WHERE  Grup.[DateExit] > GETDATE() and EducationBranch.ik_direction  in (1,2,3,4,9,10)) as a -- 2- специалисты , 1 -бакалавры, 3- магистратутра, 4-аспиратнтура, 9 -сокр бакалавриат, 10 -прикладной бакалавриат
group by a.Cname_fac, a.Cname_form_ed, a.Ik_form_ed