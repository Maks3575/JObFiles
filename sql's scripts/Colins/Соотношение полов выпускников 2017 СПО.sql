SELECT DISTINCT 
			EDU.Cname_spec	[Специальность]
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
				AND (ik_pricOtch IS NULL OR ik_pricOtch = 3)
		GROUP BY EDU.Cname_spec, [Grup].Ik_grup, [Grup].Cname_grup
		ORDER BY EDU.Cname_spec, [Grup].Cname_grup