SELECT DISTINCT 
			Fac.Cname_fac_small as [���������]
			,EducationBranch.Cname_spec as [�������������]
			,Grup.[Cname_grup] as [������]
			,Person.[PersonFullName] as [���]
			,CONVERT(VARCHAR(24),Person.[Dd_birth],104) as [���� ��������]
		    ,FacProjAdr.Address as [����������� ����� ����������]
			,PropisAdr.Address as [����� ��������]
			,VremPropisAdr.Address as [��������� ��������]

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
		select isnull(S.Cstrana,'�� �������')+', '+ isnull(Reg.Cregion, '�� �������')+', '+isnull(Ra.Craion, '�� �������')+', '+ isnull(G.Cgorod,'�� �������')+', '+isnull(St.CStreet, '�� �������')+', '+ isnull(A.BuildingNumber, '�� �������') + '-' + isnull(A.FlatNumber, '�� �������') as [Address]
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
		select isnull(S.Cstrana,'�� �������')+', '+ isnull(Reg.Cregion, '�� �������')+', '+isnull(Ra.Craion, '�� �������')+', '+ isnull(G.Cgorod,'�� �������')+', '+isnull(St.CStreet, '�� �������')+', '+ isnull(A.BuildingNumber, '�� �������') + '-' + isnull(A.FlatNumber, '�� �������') as [Address]
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
		select isnull(S.Cstrana,'�� �������')+', '+ isnull(Reg.Cregion, '�� �������')+', '+isnull(Ra.Craion, '�� �������')+', '+ isnull(G.Cgorod,'�� �������')+', '+isnull(St.CStreet, '�� �������')+', '+ isnull(A.BuildingNumber, '�� �������') + '-' + isnull(A.FlatNumber, '�� �������') as [Address]
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

			WHERE  Grup.[DateExit] > GETDATE() and Fac.[Ik_fac] = 31 -- �� ���
			and DATEDIFF(year, Person.[Dd_birth] ,GETDATE())<18