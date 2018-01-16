SELECT 'Ухта', Count(ID)
 FROM
(SELECT  DISTINCT
		P.nCode [ID]
FROM[dbo].[Zach]
INNER JOIN [dbo].[StudGrup]						ON [Zach].Ik_zach = [StudGrup].Ik_zach
INNER JOIN [dbo].[Grup]							ON [Grup].Ik_grup = [StudGrup].Ik_grup
INNER JOIN [dbo].[Relation_spec_fac]	RSF		ON RSF.ik_spec_fac = [Grup].ik_spec_fac
INNER JOIN [dbo].[EducationBranch]		EDU		ON EDU.[ik_spec] = RSF.[ik_spec]
INNER JOIN [dbo].Person					P		ON P.nCode = [Zach].nCode
INNER JOIN [FIS].AddressView			A		ON A.IDPerson = P.nCode
INNER JOIN Direction					D		ON D.ik_direction = EDU.ik_direction
INNER JOIN TypeDirection				TD		ON TD.id_type_direction = D.id_type_direction
INNER JOIN [dbo].[Form_ed]				F		ON F.Ik_form_ed = RSF.Ik_form_ed
WHERE	
		(Year(DateExit) BETWEEN 2011 AND 2017)		--дата окончания
		AND TD.id_type_direction = 5				--СПО
		AND (ik_pricOtch = 3)						--причина отчисления - завершил учебучение
		AND A.IDRaion = 18787						--район
		AND EDU.Cname_spec LIKE '%9 кл%'
		GROUP BY P.nCode) AA
UNION

SELECT 'Коми', Count(ID)
 FROM
(SELECT  DISTINCT
		P.nCode [ID]
FROM[dbo].[Zach]
INNER JOIN [dbo].[StudGrup]						ON [Zach].Ik_zach = [StudGrup].Ik_zach
INNER JOIN [dbo].[Grup]							ON [Grup].Ik_grup = [StudGrup].Ik_grup
INNER JOIN [dbo].[Relation_spec_fac]	RSF		ON RSF.ik_spec_fac = [Grup].ik_spec_fac
INNER JOIN [dbo].[EducationBranch]		EDU		ON EDU.[ik_spec] = RSF.[ik_spec]
INNER JOIN [dbo].Person					P		ON P.nCode = [Zach].nCode
INNER JOIN [FIS].AddressView			A		ON A.IDPerson = P.nCode
INNER JOIN Direction					D		ON D.ik_direction = EDU.ik_direction
INNER JOIN TypeDirection				TD		ON TD.id_type_direction = D.id_type_direction
INNER JOIN [dbo].[Form_ed]				F		ON F.Ik_form_ed = RSF.Ik_form_ed
WHERE	
		(Year(DateExit) BETWEEN 2011 AND 2017)		--дата окончания
		AND TD.id_type_direction = 5				--СПО
		AND (ik_pricOtch = 3)						--причина отчисления - завершил учебучение
		AND A.Region = 'Респ Коми'						--район
		AND EDU.Cname_spec LIKE '%9 кл%'
		GROUP BY P.nCode) BB

--select Distinct [FIS].AddressView.IDRegion, Region from [FIS].AddressView
		