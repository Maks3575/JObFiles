SELECT DISTINCT 
			--P.nCode				[IDPerson]
			P.Clastname 
				+ IIF(P.Cfirstname IS NULL, '', ' ' + P.Cfirstname)
				+ IIF(P.Cotch IS NULL, '', ' ' + P.Cotch)					[���]
			--, P.Dd_birth		[DateBirth]
			--, RSF.ik_spec		[IDSpeciality]
			, IIF(DIR.ik_direction=5 OR DIR.ik_direction=12, '���', '��')	[�������]
			, DIR.cName_direction											[����������]
			, EDU.Cname_spec												[����������c��]
			, [Grup].Cname_grup												[������]
			, IIF(RSF.Ik_form_ed = 1, '�����', IIF(RSF.Ik_form_ed = 2, '�������',''))	[�����]
			, ADR.Region
				+ ', '
				+ ADR.Raion 
				+ IIF(ADR.Town IS NULL, '', ', ' + ADR.Town)
				+ IIF(ADR.Street IS NULL, '', ', ' + ADR.Street)			[�����]
			, P.ctelefon													[�������1]
			, P.cSotTel														[�������2]
			, Year(DateExit)												[��� �������]
		FROM[dbo].[Zach]
		INNER JOIN [dbo].[StudGrup]						ON [Zach].Ik_zach = [StudGrup].Ik_zach
		INNER JOIN [dbo].[Grup]							ON [Grup].Ik_grup = [StudGrup].Ik_grup
		INNER JOIN [dbo].[Relation_spec_fac]	RSF		ON RSF.ik_spec_fac = [Grup].ik_spec_fac
		INNER JOIN [dbo].[EducationBranch]		EDU		ON EDU.[ik_spec] = RSF.[ik_spec]
		INNER JOIN [dbo].[Direction]			DIR		ON DIR.ik_direction = EDU.ik_direction
		INNER JOIN [dbo].Person					P		ON P.nCode = [Zach].nCode
		INNER JOIN [FIS].[AddressView]			ADR		ON ADR.IDPerson = P.nCode
		WHERE (ik_pricOtch = 3 OR ik_pricOtch	IS NULL)	--������� ���������� - �������� ����������
				--AND ADR.IDRaion = 18798								--�����
				AND DateExit >= '2017'	--��� �������
				AND (EDU.Cname_spec LIKE '%�����%'
						OR EDU.Cname_spec LIKE '%����������%')
