
--SELECT App.Speciality
--		, SUM(IIF([IDFormEducation] = 1, 1, 0)) [Очная форма]
--		, SUM(IIF([IDFormEducation] = 2, 1, 0)) [Заочная форма]
SELECT App.Speciality
		, VIP2.GroupName
		, VIP.GroupName
		, SUM(IIF([IDFormEducation] = 1, 1, 0)) [Очная форма]
		, SUM(IIF([IDFormEducation] = 2, 1, 0)) [Заочная форма], COUNT(IDApplication)
FROM (SELECT DISTINCT 
			P.nCode			[IDPerson]
			, P.Clastname	[LastName]
			, P.Cfirstname	[FirstName]
			, P.Cotch		[MiddleName]
			, P.Dd_birth	[DateBirth]
			, RSF.ik_spec		[IDSpeciality]
			, EDU.Cshort_spec	[Speciality]
			, [Grup].Cname_grup	[GroupName]
		FROM[dbo].[Zach]
		INNER JOIN [dbo].[StudGrup]					ON [Zach].Ik_zach = [StudGrup].Ik_zach
		INNER JOIN [dbo].[Grup]						ON [Grup].Ik_grup = [StudGrup].Ik_grup
		INNER JOIN [dbo].[Relation_spec_fac] RSF	ON RSF.ik_spec_fac = [Grup].ik_spec_fac
		INNER JOIN [dbo].[EducationBranch]	EDU		ON EDU.[ik_spec] = RSF.[ik_spec]
		INNER JOIN [dbo].Person				P		ON P.nCode = [Zach].nCode
		WHERE ik_direction = 5
				AND ik_pricOtch = 3
				AND DateExit > '2016') VIP

INNER JOIN	(SELECT IDPerson
					, IDApplication
					, LastName
					, FirstName
					, MiddleName
					, DateBirth
					, Speciality
					, IDFormEducation 
					, IDSpeciality
					, SpecialityShort
				FROM [FIS].ApplicationView
				WHERE Year = 2016
						--AND IDSpeciality in (354440, 354690, 354432, 354487, 354442)
						AND IDSpecialityFIS in (17764, 17728, 17587, 17936, 18088)
						AND IDStateZachFIS = 8) App ON App.LastName = VIP.LastName
														AND App.FirstName = VIP.FirstName
														AND App.MiddleName = VIP.MiddleName
														AND App.DateBirth = VIP.DateBirth
	INNER JOIN (SELECT DISTINCT 
					P.nCode			[IDPerson]
					, P.Clastname	[LastName]
					, P.Cfirstname	[FirstName]
					, P.Cotch		[MiddleName]
					, P.Dd_birth	[DateBirth]
					, RSF.ik_spec		[IDSpeciality]
					, EDU.Cshort_spec	[Speciality]
					, [Grup].Cname_grup	[GroupName]
				FROM[dbo].[Zach]
				INNER JOIN [dbo].[StudGrup]					ON [Zach].Ik_zach = [StudGrup].Ik_zach
				INNER JOIN [dbo].[Grup]						ON [Grup].Ik_grup = [StudGrup].Ik_grup
				INNER JOIN [dbo].[Relation_spec_fac] RSF	ON RSF.ik_spec_fac = [Grup].ik_spec_fac
				INNER JOIN [dbo].[EducationBranch]	EDU		ON EDU.[ik_spec] = RSF.[ik_spec]
				INNER JOIN [dbo].Person				P		ON P.nCode = [Zach].nCode) VIP2		ON VIP2.IDPerson = App.IDPerson

GROUP BY App.Speciality, VIP.Speciality, IDFormEducation, VIP2.GroupName, VIP.GroupName