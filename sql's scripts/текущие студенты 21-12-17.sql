SELECT DISTINCT 
			Fac.[Cshort_name_fac] as [Институт]
			,EducationBranch.Cname_spec as [Специальность]
			,Grup.[Cname_grup] as [Группа]
			,Person.[PersonFullName] as [ФИО]
			,CONVERT(VARCHAR(24),Person.[Dd_birth],104) as [Дата Рождения]

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
                        dbo.Form_ed ON dbo.Relation_spec_fac.Ik_form_ed = dbo.Form_ed.Ik_form_ed 

			WHERE  Grup.[DateExit] > GETDATE() and Fac.[Ik_fac] not in (17,15) -- без филиалов
			and DATEDIFF(year, Person.[Dd_birth] ,GETDATE()) in (15,16,17)
			and Form_ed.Ik_form_ed = 1 --очники
			order by [Институт], [Специальность], [Группа], [ФИО]