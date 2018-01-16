SELECT Distinct
			F.Cshort_name_fac  [��������]
			,EB.Cname_spec [�������������]
			,G.Cname_grup [������]
			,P.PersonFullName [���]
			,Gor.Cgorod [�����]
			,ZS.cName_zaved [���������]
		FROM             dbo.Fac F 
		INNER JOIN	dbo.Relation_spec_fac RSF ON F.Ik_fac = RSF.ik_fac 
		INNER JOIN	dbo.EducationBranch EB ON RSF.ik_spec = EB.ik_spec 
		INNER JOIN	dbo.Grup G ON RSF.ik_spec_fac = G.ik_spec_fac 
		INNER JOIN	dbo.StudGrup SG ON G.Ik_grup = SG.Ik_grup 
					AND SG.[Ik_prikazOtch] is null --AND StudGrup.[Ik_prikazZach] is not null
		INNER JOIN	dbo.Zach Z ON SG.Ik_zach = Z.Ik_zach 
		INNER JOIN	dbo.Student S ON Z.nCode = S.nCode 
		INNER JOIN	dbo.Person P ON S.nCode = P.nCode 

		LEFT JOIN dbo.Zaved_stud ZS ON S.Ik_zaved = ZS.ik_zaved
		LEFT JOIN dbo.Gorod Gor ON ZS.Ik_gorod = Gor.Ik_gorod

where F.Ik_fac = 27 and RSF.Ik_form_ed = 1 and (Gor.Cgorod = '����' or ZS.cName_zaved like '%���%')
order by ZS.cName_zaved, [��������], [�������������], [������], [���]