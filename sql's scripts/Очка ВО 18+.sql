USE UGTU
SELECT DISTINCT 
--Person.nCode,
		Fac.Cname_fac as [Институт]
		, EducationBranch.Cname_spec as [Специальность]
		, Grup.[Cname_grup] as [Группа]
		, Person.[PersonFullName] as [ФИО]
		, CONVERT(VARCHAR(24),Person.[Dd_birth],104) as [Дата Рождения]
		
		, isNull((select top 1 [Region]+', '+[Town]+', '+Street
					from [FIS].[AddressView]
					where IDPerson = Person.nCode and [IDTypeAddress]  in (2,3))
				,'Нет') Прописка

		, isNull((select top 1 [Region]+' '+[Town]+' '+Street
					from [FIS].[AddressView]
					where IDPerson = Person.nCode and [IDTypeAddress] = 1)
				,'Нет') [Факт. проживание]

		--, isNull(Person.[cSotTel],'  ')+' '+isNull(Person.[ctelefon],'') as [Телефон]
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
			Fac.[Ik_fac] not in(14, 15, 17, 20, 31) -- ВО (без филиалов и ЦДО)
			and
			Form_ed.[Ik_form_ed] = 1
			and
			DATEDIFF(year, Person.[Dd_birth] ,GETDATE())>18 -- 18+
order by  Институт, Специальность, Группа, ФИО
