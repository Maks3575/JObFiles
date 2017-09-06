SELECT DISTINCT 
			Fac.Cname_fac_small as [Факультет]
			,EducationBranch.Cname_spec as [Специальность]
			,Grup.[Cname_grup] as [Группа]
			,Person.[PersonFullName] as [ФИО]
			,CONVERT(VARCHAR(24),Person.[Dd_birth],104) as [Дата Рождения]
		    ,FacProjAdr.Address as [Фактический адрес проживания]
			,PropisAdr.Address as [Адрес прописки]
			,VremPropisAdr.Address as [Временная прописка]

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

						left join (
		select isnull(S.Cstrana,'не указано')+', '+ isnull(Reg.Cregion, 'не указано')+', '+isnull(Ra.Craion, 'не указано')+', '+ isnull(G.Cgorod,'не указано')+', '+isnull(St.CStreet, 'не указано')+', '+ isnull(A.BuildingNumber, 'не указано') + '-' + isnull(A.FlatNumber, 'не указано') as [Address]
		, PA.nCode as [IdStud]
		, PA.ik_AddressType as [AddressType]
		from dbo.PersonAddress PA 
	    inner join dbo.Address A on PA.ik_address = A.ik_address
		inner join dbo.AddressType AType on PA.ik_AddressType = AType.ik_AddressType
		inner join dbo.Street St on A.Ik_street = St.Ik_street
		inner join dbo.Gorod G on St.ik_gorod = G.ik_gorod
		inner join dbo.Raion Ra on G.Ik_raion = Ra.Ik_raion
		inner join dbo.Region Reg on Ra.Ik_region = Reg.Ik_region
		inner join dbo.Strana S on Reg.Ik_strana = S.Ik_strana
		where PA.ik_AddressType = 1
	) FacProjAdr on dbo.Person.nCode = FacProjAdr.IdStud

			left join (
		select isnull(S.Cstrana,'не указано')+', '+ isnull(Reg.Cregion, 'не указано')+', '+isnull(Ra.Craion, 'не указано')+', '+ isnull(G.Cgorod,'не указано')+', '+isnull(St.CStreet, 'не указано')+', '+ isnull(A.BuildingNumber, 'не указано') + '-' + isnull(A.FlatNumber, 'не указано') as [Address]
		, PA.nCode as [IdStud]
		, PA.ik_AddressType as [AddressType]
		from dbo.PersonAddress PA 
	    inner join dbo.Address A on PA.ik_address = A.ik_address
		inner join dbo.AddressType AType on PA.ik_AddressType = AType.ik_AddressType
		inner join dbo.Street St on A.Ik_street = St.Ik_street
		inner join dbo.Gorod G on St.ik_gorod = G.ik_gorod
		inner join dbo.Raion Ra on G.Ik_raion = Ra.Ik_raion
		inner join dbo.Region Reg on Ra.Ik_region = Reg.Ik_region
		inner join dbo.Strana S on Reg.Ik_strana = S.Ik_strana
		where PA.ik_AddressType = 2
	) PropisAdr on dbo.Person.nCode = PropisAdr.IdStud

				left join (
		select isnull(S.Cstrana,'не указано')+', '+ isnull(Reg.Cregion, 'не указано')+', '+isnull(Ra.Craion, 'не указано')+', '+ isnull(G.Cgorod,'не указано')+', '+isnull(St.CStreet, 'не указано')+', '+ isnull(A.BuildingNumber, 'не указано') + '-' + isnull(A.FlatNumber, 'не указано') as [Address]
		, PA.nCode as [IdStud]
		, PA.ik_AddressType as [AddressType]
		from dbo.PersonAddress PA 
	    inner join dbo.Address A on PA.ik_address = A.ik_address
		inner join dbo.AddressType AType on PA.ik_AddressType = AType.ik_AddressType
		inner join dbo.Street St on A.Ik_street = St.Ik_street
		inner join dbo.Gorod G on St.ik_gorod = G.ik_gorod
		inner join dbo.Raion Ra on G.Ik_raion = Ra.Ik_raion
		inner join dbo.Region Reg on Ra.Ik_region = Reg.Ik_region
		inner join dbo.Strana S on Reg.Ik_strana = S.Ik_strana
		where PA.ik_AddressType = 3
	) VremPropisAdr on dbo.Person.nCode = VremPropisAdr.IdStud

			WHERE  Grup.[DateExit] > GETDATE() and Fac.[Ik_fac] = 31 -- ИИ СПО
			and DATEDIFF(year, Person.[Dd_birth] ,GETDATE())<18