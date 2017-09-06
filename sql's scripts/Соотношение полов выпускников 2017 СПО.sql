SELECT DISTINCT 
			--P.nCode			[IDPerson]
			 EDU.Cname_spec	[Специальность]
			, CAST(SUM(IIF(P.[lSex] = 1, 1, 0)) AS VARCHAR) + '/' +  CAST(SUM(IIF(P.[lSex] = 0, 1, 0)) AS VARCHAR) [М/Ж]
			--, ik_pricOtch
			--, P.Clastname	[LastName]
			--, P.Cfirstname	[FirstName]
			--, P.Cotch		[MiddleName]
			--, [Grup].Cname_grup	[GroupName]
		FROM[dbo].[Zach]
		INNER JOIN [dbo].[StudGrup]					ON [Zach].Ik_zach = [StudGrup].Ik_zach
		INNER JOIN [dbo].[Grup]						ON [Grup].Ik_grup = [StudGrup].Ik_grup
		INNER JOIN [dbo].[Relation_spec_fac] RSF	ON RSF.ik_spec_fac = [Grup].ik_spec_fac
		INNER JOIN [dbo].[EducationBranch]	EDU		ON EDU.[ik_spec] = RSF.[ik_spec]
		INNER JOIN [dbo].Person				P		ON P.nCode = [Zach].nCode
		WHERE ik_direction = 5
				AND [DateExit] Like '%2017%'
				AND (ik_pricOtch IS NULL OR ik_pricOtch = 3)
		GROUP BY EDU.Cname_spec
		ORDER BY EDU.Cname_spec