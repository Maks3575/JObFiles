SELECT Distinct
			F.Cshort_name_fac  [Институт]
			,EB.Cname_spec [Специальность]
			,G.Cname_grup [Группа]
			,P.PersonFullName [ФИО]
			--,Re.Cregion [Регион]
			--,Ra.Craion [Район]
			--,Gor.Cgorod [Город]
			--,St.CStreet [Улица]
		FROM             dbo.Fac F 
		INNER JOIN	dbo.Relation_spec_fac RSF ON F.Ik_fac = RSF.ik_fac 
		INNER JOIN	dbo.EducationBranch EB ON RSF.ik_spec = EB.ik_spec 
		INNER JOIN	dbo.Grup G ON RSF.ik_spec_fac = G.ik_spec_fac 
		INNER JOIN	dbo.StudGrup SG ON G.Ik_grup = SG.Ik_grup 
					AND SG.[Ik_prikazOtch] is null --AND StudGrup.[Ik_prikazZach] is not null
		INNER JOIN	dbo.Zach Z ON SG.Ik_zach = Z.Ik_zach 
		INNER JOIN	dbo.Student S ON Z.nCode = S.nCode 
		INNER JOIN	dbo.Person P ON S.nCode = P.nCode 
		Left JOIN	dbo.PersonAddress PA on Pa.nCode = P.nCode 
		Left JOIN	dbo.Address A on A.ik_address = PA.ik_address 
		Left JOIN	dbo.Street St on St.Ik_street = A.Ik_street
		Left JOIN	dbo.Gorod Gor on Gor.Ik_gorod = St.ik_gorod 
		Left JOIN	dbo.Raion Ra on Ra.Ik_raion = Gor.Ik_raion 
		Left JOIN	dbo.Region Re on Re.Ik_region = Ra.Ik_region

where PA.ik_AddressType = 2 and Gor.Cgorod like '%Вук%' --or Ra.Craion like '%Вук%'
order by [Институт], [Специальность], [Группа], [ФИО]