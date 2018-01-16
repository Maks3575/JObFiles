SELECT  DiSTINCT
	P.Clastname 
		+ IIF(P.Cfirstname IS NULL, '', ' ' + P.Cfirstname)
		+ IIF(P.Cotch IS NULL, '', ' ' + P.Cotch)			[ФИО]
	,P.Dd_birth												[Дата рождения]
	, A.Region 
		+ IIF(A.Town IS NULL, '', ', ' + A.Town)
		+ IIF(A.Street IS NULL, '', ', ' + A.Street)	[Адрес]
	,ISNULL(P.cSotTel,'') 
		+ IIF(P.ctelefon IS NULL, '', ', ' + P.ctelefon)	[Телефон]	
	--, D.cName_direction									[Направление]
	--, EDU.Cname_spec									[Специальность]
	--, F.Cname_form_ed									[Форма обучения]
	--, [Grup].Cname_grup									[Группа]
	, IIF(ik_pricOtch IS NULL, 'Нет', 'Есть')			[Приказ по заверщинию обучения]
FROM[dbo].[Zach]
INNER JOIN [dbo].[StudGrup]						ON [Zach].Ik_zach = [StudGrup].Ik_zach
INNER JOIN [dbo].[Grup]							ON [Grup].Ik_grup = [StudGrup].Ik_grup
INNER JOIN [dbo].[Relation_spec_fac]	RSF		ON RSF.ik_spec_fac = [Grup].ik_spec_fac
INNER JOIN [dbo].[EducationBranch]		EDU		ON EDU.[ik_spec] = RSF.[ik_spec]
INNER JOIN [dbo].Person					P		ON P.nCode = [Zach].nCode
INNER JOIN [FIS].AddressView			A		ON A.IDPerson = P.nCode
INNER JOIN Direction					D		ON D.ik_direction = EDU.ik_direction
INNER JOIN [dbo].[Form_ed]				F		ON F.Ik_form_ed = RSF.Ik_form_ed
WHERE	D.ik_direction NOT IN (5, 12)					--ВО
		AND (ik_pricOtch = 3
			OR ik_pricOtch IS NULL)						--причина отчисления - завершил учебучение
		AND Year(DateExit) in (2017)					--дата окончания
		AND A.IDRaion = 18807							--район
		AND F.Ik_form_ed = 1							--очная форма
		AND EDU.ik_spec = 354442						--специальность "Электроэнергетика и электротехника"

		--select Distinct IDRaion, Raion from [FIS].AddressView
		