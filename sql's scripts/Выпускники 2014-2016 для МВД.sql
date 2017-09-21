SELECT  DiSTINCT
	P.PersonFullName			[ФИО]
	,P.Dd_birth												[Дата рождения]
	--, [Grup].Cname_grup									[Группа]
	--, F.Cname_form_ed									[Форма обучения]
	--, D.cName_direction									[Направление]
	--, EDU.Cname_spec									[Специальность]
	, A.FullAddress 
		--+ IIF(A.Region IS NULL, '', ', ' + A.Region)
		--+ IIF(A.Raion IS NULL, '', ', ' + A.Raion)
		--+ IIF(A.Town IS NULL, '', ', ' + A.Town)
		--+ IIF(A.Street IS NULL, '', ', ' + A.Street)	
		--+ IIF(A.House IS NULL, '', ', ' + A.House)
		[Адрес]

	,iif(rtrim(isnull(P.cSotTel,''))='',''
		,rtrim(P.cSotTel)+'; ')
		+
	 iif(rtrim(isnull(P.ctelefon,''))='',''
		,rtrim(P.ctelefon)+';') as [Телефон]

	,Year([Grup].DateExit) as [Год выпуска]

FROM[dbo].[Zach]
INNER JOIN [dbo].[StudGrup]						ON [Zach].Ik_zach = [StudGrup].Ik_zach
INNER JOIN [dbo].[Grup]							ON [Grup].Ik_grup = [StudGrup].Ik_grup
INNER JOIN [dbo].[Relation_spec_fac]	RSF		ON RSF.ik_spec_fac = [Grup].ik_spec_fac
INNER JOIN [dbo].[EducationBranch]		EDU		ON EDU.[ik_spec] = RSF.[ik_spec]
INNER JOIN [dbo].Person					P		ON P.nCode = [Zach].nCode
LEFT JOIN [FIS].AddressView			A		ON A.IDPerson = P.nCode
INNER JOIN Direction					D		ON D.ik_direction = EDU.ik_direction
INNER JOIN [dbo].[Form_ed]				F		ON F.Ik_form_ed = RSF.Ik_form_ed
WHERE	--D.ik_direction NOT IN (5, 12)					--ВО
		--AND 
		(
		ik_pricOtch = 3
			OR 
			ik_pricOtch IS NULL
			)						--причина отчисления - завершил учебучение
		AND Year(DateExit) in (2014, 2015, 2016)		--дата окончания
		--AND F.Ik_form_ed = 1							--очная форма
		--AND RSF.ik_fac <> 31
		--AND EDU.ik_spec = 354442						--специальность "Электроэнергетика и электротехника"
		AND P.lSex = 1									--пол М 
		--select * from [FIS].AddressView
		AND A.IDTypeAddress = 2
order by Year([Grup].DateExit), P.PersonFullName