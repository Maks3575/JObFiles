SELECT DISTINCT 
			--Zach.Nn_zach as [№ зачетки]
			--,
			Person.PersonFullName [ФИО]
			--,Grup.Cname_grup [Группа]
			--,Fac.Cshort_name_fac  [Институт]
			,DV.Document
			,DV.DocumentSeria
			,DV.DocumentNumber
			,DV.DateDocument
			,DV.DocumentOrganization
			,AV.FullAddress

			

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
						 left join [UGTU].[FIS].[DocumentsView] as DV on dbo.Person.nCode = DV.IDPerson and (DV.IDDictionaryFIS = 22 or DV.IDDictionaryFIS is null)
						 left join [UGTU].[FIS].[AddressView] as AV on dbo.Person.nCode = AV.IDPerson and AV.IDTypeAddress = 2
						 where YEAR(dbo.Grup.DateExit) > 2017 

			order by [ФИО]