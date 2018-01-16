SELECT  DiSTINCT
	P.Clastname 
		+ IIF(P.Cfirstname IS NULL, '', ' ' + P.Cfirstname)
		+ IIF(P.Cotch IS NULL, '', ' ' + P.Cotch)		[ФИО]
	,ISNULL(P.cSotTel,'') 
		+ IIF(P.ctelefon IS NULL, '', ' ' + P.ctelefon)	[Телефон]	
	, A.Region 
		+ IIF(A.Town IS NULL, '', ', ' + A.Town)
		+ IIF(A.Street IS NULL, '', ', ' + A.Street)	[Адрес]
	, D.cName_direction									[Направление]
	, EDU.Cname_spec									[Специальность]
	, [Grup].Cname_grup									[Группа]
	, IIF(ik_pricOtch IS NULL, 'Нет', 'Есть')			[Приказ по заверщинию обучения]
FROM[dbo].[Zach]
INNER JOIN [dbo].[StudGrup]						ON [Zach].Ik_zach = [StudGrup].Ik_zach
INNER JOIN [dbo].[Grup]							ON [Grup].Ik_grup = [StudGrup].Ik_grup
INNER JOIN [dbo].[Relation_spec_fac]	RSF		ON RSF.ik_spec_fac = [Grup].ik_spec_fac
INNER JOIN [dbo].[EducationBranch]		EDU		ON EDU.[ik_spec] = RSF.[ik_spec]
INNER JOIN [dbo].Person					P		ON P.nCode = [Zach].nCode
INNER JOIN [FIS].AddressView			A		ON A.IDPerson = P.nCode
INNER JOIN Direction					D		ON D.ik_direction = EDU.ik_direction
WHERE	D.ik_direction NOT IN (5, 12)					--ВО
		AND (ik_pricOtch = 3
			OR ik_pricOtch IS NULL)						--причина отчисления - завершил учебучение
		AND Year(DateExit) in (2015, 2016, 2017)		--дата окончания
		AND A.IDRaion = 15								--район

		--select Distinct IDRaion, Raion from [FIS].AddressView
		