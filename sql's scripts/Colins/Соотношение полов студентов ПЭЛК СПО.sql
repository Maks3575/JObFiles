SELECT * FROM
--по группам
(SELECT [Grup].Cname_grup [Группа]
	 , CAST(DATEDIFF(year, P.Dd_birth, GetDate()) AS VARCHAR) Возраст
	 , CAST(SUM(IIF(P.[lSex] = 1, 1, 0)) AS VARCHAR) + '/' +  CAST(SUM(IIF(P.[lSex] = 0, 1, 0)) AS VARCHAR) [М/Ж]

		FROM[dbo].[Zach]
		INNER JOIN [dbo].[StudGrup]					ON [Zach].Ik_zach = [StudGrup].Ik_zach
		INNER JOIN [dbo].[Grup]						ON [Grup].Ik_grup = [StudGrup].Ik_grup
		INNER JOIN [dbo].[Relation_spec_fac] RSF	ON RSF.ik_spec_fac = [Grup].ik_spec_fac
		INNER JOIN [dbo].[EducationBranch]	EDU		ON EDU.[ik_spec] = RSF.[ik_spec]
		INNER JOIN [dbo].Person				P		ON P.nCode = [Zach].nCode
		INNER JOIN [dbo].Direction			DIR		ON DIR.ik_direction = EDU.ik_direction
		INNER JOIN [dbo].TypeDirection		TDIR	ON TDIR.id_type_direction = DIR.id_type_direction
		WHERE TDIR.id_type_direction = 5	
			  AND RSF.Ik_form_ed = 2 -- форма обучения
			  --AND Year(Grup.DateCreate) > 14
			  --AND [Grup].Ik_grup IN (9962, 9723, 9532, 9715, 9902, 9963, 9716, 9525, 6271, 9530, 9722, 9961, 6272, 9527, 9717, 9956, 9958, 9959, 9719, 9720, 9528, 6265, 6276, 9529, 9721, 9960, 9533, 9718, 9957)
			  AND [Grup].Ik_grup IN (9756, 6225, 9598, 9761,9863, 9863, 9595, 9864, 9596, 9591, 6227)
				--AND (ik_pricOtch IS NULL OR ik_pricOtch = 3)
		GROUP BY [Grup].Ik_grup, [Grup].Cname_grup, DATEDIFF(year, P.Dd_birth, GetDate()) ORDER BY [Grup].Cname_grup) A

UNION
--сумма по специальностья
SELECT * FROM
(SELECT EDU.Cshort_spec [Группа]
	 , 'Все' Возраст
	 , CAST(SUM(IIF(P.[lSex] = 1, 1, 0)) AS VARCHAR) + '/' +  CAST(SUM(IIF(P.[lSex] = 0, 1, 0)) AS VARCHAR) [М/Ж]
		FROM[dbo].[Zach]
		INNER JOIN [dbo].[StudGrup]					ON [Zach].Ik_zach = [StudGrup].Ik_zach
		INNER JOIN [dbo].[Grup]						ON [Grup].Ik_grup = [StudGrup].Ik_grup
		INNER JOIN [dbo].[Relation_spec_fac] RSF	ON RSF.ik_spec_fac = [Grup].ik_spec_fac
		INNER JOIN [dbo].[EducationBranch]	EDU		ON EDU.[ik_spec] = RSF.[ik_spec]
		INNER JOIN [dbo].Person				P		ON P.nCode = [Zach].nCode
		INNER JOIN [dbo].Direction			DIR		ON DIR.ik_direction = EDU.ik_direction
		INNER JOIN [dbo].TypeDirection		TDIR	ON TDIR.id_type_direction = DIR.id_type_direction
		WHERE TDIR.id_type_direction = 5	
			  AND RSF.Ik_form_ed = 2 -- форма обучения
			  --AND [Grup].Ik_grup IN (9962, 9723, 9532, 9715, 9902, 9963, 9716, 9525, 6271, 9530, 9722, 9961, 6272, 9527, 9717, 9956, 9958, 9959, 9719, 9720, 9528, 6265, 6276, 9529, 9721, 9960, 9533, 9718, 9957)
			  AND [Grup].Ik_grup IN (9756, 6225, 9598, 9761,9863, 9863, 9595, 9864, 9596, 9591, 6227)
		GROUP BY EDU.Cshort_spec) B
  ORDER BY [Группа]