SELECT DISTINCT 
			Fac.Cshort_name_fac  [Институт]
			,EducationBranch.Cname_spec [Специальность]
			--,Form_ed.Ik_form_ed  as  Ik_form_ed
			--,Form_ed.Cname_form_ed  as  Cname_form_ed 
			--,Zach.Ik_zach as Ik_zach
			--,Zach.nCode as nCode
			--,EducationBranch.ik_spec  as ik_spec
			,Grup.Cname_grup [Группа]
			,Person.PersonFullName [ФИО]
			,Lang.Cname_lang [Язык]
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
                        dbo.Form_ed ON dbo.Relation_spec_fac.Ik_form_ed = dbo.Form_ed.Ik_form_ed Left JOIN
						dbo.Lang_stud ON dbo.Person.nCode = dbo.Lang_stud.nCode left join 
						dbo.Lang on dbo.Lang_stud.Ik_lang = dbo.Lang.Ik_lang 
			WHERE  --Grup.Cname_grup like '%17%'
			YEAR(Grup.DateCreate) = 2017 
			and Fac.Ik_fac <> 31
			order by [Институт], [Специальность], [Группа], [ФИО]