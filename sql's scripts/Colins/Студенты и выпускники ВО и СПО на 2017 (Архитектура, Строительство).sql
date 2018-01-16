SELECT DISTINCT 
			--P.nCode				[IDPerson]
			P.Clastname 
				+ IIF(P.Cfirstname IS NULL, '', ' ' + P.Cfirstname)
				+ IIF(P.Cotch IS NULL, '', ' ' + P.Cotch)					[ФИО]
			--, P.Dd_birth		[DateBirth]
			--, RSF.ik_spec		[IDSpeciality]
			, IIF(DIR.ik_direction=5 OR DIR.ik_direction=12, 'СПО', 'ВО')	[Уровень]
			, DIR.cName_direction											[Напраление]
			, EDU.Cname_spec												[Специальноcть]
			, [Grup].Cname_grup												[Группа]
			, IIF(RSF.Ik_form_ed = 1, 'Очная', IIF(RSF.Ik_form_ed = 2, 'Заочная',''))	[Форма]
			, ADR.Region
				+ ', '
				+ ADR.Raion 
				+ IIF(ADR.Town IS NULL, '', ', ' + ADR.Town)
				+ IIF(ADR.Street IS NULL, '', ', ' + ADR.Street)			[Адрес]
			, P.ctelefon													[Телефон1]
			, P.cSotTel														[Телефон2]
			, Year(DateExit)												[Год выпуска]
		FROM[dbo].[Zach]
		INNER JOIN [dbo].[StudGrup]						ON [Zach].Ik_zach = [StudGrup].Ik_zach
		INNER JOIN [dbo].[Grup]							ON [Grup].Ik_grup = [StudGrup].Ik_grup
		INNER JOIN [dbo].[Relation_spec_fac]	RSF		ON RSF.ik_spec_fac = [Grup].ik_spec_fac
		INNER JOIN [dbo].[EducationBranch]		EDU		ON EDU.[ik_spec] = RSF.[ik_spec]
		INNER JOIN [dbo].[Direction]			DIR		ON DIR.ik_direction = EDU.ik_direction
		INNER JOIN [dbo].Person					P		ON P.nCode = [Zach].nCode
		INNER JOIN [FIS].[AddressView]			ADR		ON ADR.IDPerson = P.nCode
		WHERE (ik_pricOtch = 3 OR ik_pricOtch	IS NULL)	--Причина отчисления - завершил учебучение
				--AND ADR.IDRaion = 18798								--район
				AND DateExit >= '2017'	--год выпуска
				AND (EDU.Cname_spec LIKE '%архит%'
						OR EDU.Cname_spec LIKE '%строительс%')
