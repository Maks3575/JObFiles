SELECT DISTINCT 
			--Fac.Cname_fac as [Факультет]
			--,EducationBranch.Cname_spec as [Специальность]
			--,Grup.[Cname_grup] as [Группа]
			--,Form_ed.Cname_form_ed  as  [Форма обучения]
			--,Zach.Nn_zach as [Зачетка]
			--,Person.[PersonFullName] as [ФИО]
			--,CONVERT(VARCHAR(24),Person.[Dd_birth],104) as [Дата Рождения]
			--,DATEDIFF(year, Person.[Dd_birth] ,GETDATE()) as [Возраст]
			SUM(IIF( (DATEDIFF(year, Person.[Dd_birth] ,GETDATE()) BETWEEN 13 and 14),1,0)) as [13-14]
			, SUM(IIF( (DATEDIFF(year, Person.[Dd_birth] ,GETDATE()) BETWEEN 15 and 16),1,0)) as [15-16]
			, SUM(IIF( (DATEDIFF(year, Person.[Dd_birth] ,GETDATE()) BETWEEN 16 and 17),1,0)) as [16-17]
			, SUM(IIF( (DATEDIFF(year, Person.[Dd_birth] ,GETDATE()) BETWEEN 17 and 18),1,0)) as [17-18]
			, SUM(IIF( (DATEDIFF(year, Person.[Dd_birth] ,GETDATE()) BETWEEN 19 and 25),1,0)) as [19-25]
			, SUM(IIF( (DATEDIFF(year, Person.[Dd_birth] ,GETDATE()) BETWEEN 26 and 30),1,0)) as [26-30]
			, SUM(IIF( (DATEDIFF(year, Person.[Dd_birth] ,GETDATE()) BETWEEN 31 and 35),1,0)) as [31-35]
			, SUM(IIF( (DATEDIFF(year, Person.[Dd_birth] ,GETDATE()) BETWEEN 36 and 40),1,0)) as [36-40]
			, SUM(IIF( (DATEDIFF(year, Person.[Dd_birth] ,GETDATE()) BETWEEN 41 and 50),1,0)) as [41-50]
			, SUM(IIF( (DATEDIFF(year, Person.[Dd_birth] ,GETDATE()) BETWEEN 51 and 60),1,0)) as [51-60]
			, SUM(IIF( (DATEDIFF(year, Person.[Dd_birth] ,GETDATE()) BETWEEN 61 and 70),1,0)) as [61-70]
			, SUM(IIF( (DATEDIFF(year, Person.[Dd_birth] ,GETDATE()) BETWEEN 71 and 80),1,0)) as [71-80]
			, SUM(IIF( (DATEDIFF(year, Person.[Dd_birth] ,GETDATE()) BETWEEN 81 and 90),1,0)) as [81-90]


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
			WHERE  (Grup.[DateExit] > GETDATE() or  Grup.[DateExit] is null)
			--and DATEDIFF(year, Person.[Dd_birth] ,GETDATE())<=18