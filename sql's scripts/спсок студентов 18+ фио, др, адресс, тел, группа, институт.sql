SELECT DISTINCT 
--Person.nCode,
			Person.[PersonFullName] as [ФИО]
			,CONVERT(VARCHAR(24),Person.[Dd_birth],104) as [Дата Рождения]

			,isNull(Person.[cSotTel],'  ')+' '+isNull(Person.[ctelefon],'') as [Телефон]

			,isNull(isNull((select top 1 [Region]+' '+[Town]+' '+[Address]
						from [FIS].[AddressView]
						where IDPerson = Person.nCode and [IDTypeAddress] in (2,3)),
					(select top 1 [Region]+' '+[Town]+' '+[Address]
						from [FIS].[AddressView]
						where IDPerson = Person.nCode and [IDTypeAddress] = 1)),
			'Нет') as [Адрес]
			,Grup.[Cname_grup] as [Группа]
			,Fac.Cname_fac as [Институт]
		FROM             dbo.Fac INNER JOIN
                         dbo.Relation_spec_fac ON dbo.Fac.Ik_fac = dbo.Relation_spec_fac.ik_fac INNER JOIN
                         dbo.EducationBranch ON dbo.Relation_spec_fac.ik_spec = dbo.EducationBranch.ik_spec INNER JOIN
                         dbo.Grup ON dbo.Relation_spec_fac.ik_spec_fac = dbo.Grup.ik_spec_fac INNER JOIN
                         dbo.StudGrup ON dbo.Grup.Ik_grup = dbo.StudGrup.Ik_grup 
							AND 
							StudGrup.[Ik_prikazOtch] is null 
							AND 
							StudGrup.[Ik_prikazZach] is not null
						 INNER JOIN
                         dbo.Zach ON dbo.StudGrup.Ik_zach = dbo.Zach.Ik_zach INNER JOIN
                         dbo.Student ON dbo.Zach.nCode = dbo.Student.nCode INNER JOIN
                         dbo.Person ON dbo.Student.nCode = dbo.Person.nCode INNER JOIN
                        dbo.Form_ed ON dbo.Relation_spec_fac.Ik_form_ed = dbo.Form_ed.Ik_form_ed 
						--LEFT JOIN 
						--[FIS].[AddressView] on dbo.Student.nCode = [FIS].[AddressView].[IDPerson]
			WHERE  
			(Grup.[DateExit] > GETDATE() or Grup.[DateExit] is null) 
			and 
			Fac.[Ik_fac] not in(15, 17) -- без филиалов
			and
			Person.[Ik_grazd] = 2 --русские
			and
			DATEDIFF(year, Person.[Dd_birth] ,GETDATE())>18
order by  Институт, Группа, ФИО
