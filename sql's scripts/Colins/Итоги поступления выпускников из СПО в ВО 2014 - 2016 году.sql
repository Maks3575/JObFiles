
--SELECT App.Speciality
--		, SUM(IIF([IDFormEducation] = 1, 1, 0)) [Очная форма]
--		, SUM(IIF([IDFormEducation] = 2, 1, 0)) [Заочная форма]
SELECT App.Speciality							[Специальность ВО]
		, VIP2.GroupName						[Группа ВО]
		, VIP.GroupName							[Группа СПО]
		, SUM(IIF([IDFormEducation] = 1, 1, 0)) [Очная форма]
		, SUM(IIF([IDFormEducation] = 2, 1, 0)) [Заочная форма]
		, COUNT(IDApplication)					[Всего заявлений]
		, DateExit								[Год Выпуска СПО]
		, App.Year								[Год Поступления ВО]
FROM (--Получаем выпускников
		SELECT DISTINCT 
			P.nCode				[IDPerson]
			, P.Clastname		[LastName]
			, P.Cfirstname		[FirstName]
			, P.Cotch			[MiddleName]
			, P.Dd_birth		[DateBirth]
			, RSF.ik_spec		[IDSpeciality]
			, EDU.Cshort_spec	[Speciality]
			, [Grup].Cname_grup	[GroupName]
			, Year(DateExit)	[DateExit]
		FROM[dbo].[Zach]
		INNER JOIN [dbo].[StudGrup]						ON [Zach].Ik_zach = [StudGrup].Ik_zach
		INNER JOIN [dbo].[Grup]							ON [Grup].Ik_grup = [StudGrup].Ik_grup
		INNER JOIN [dbo].[Relation_spec_fac]	RSF		ON RSF.ik_spec_fac = [Grup].ik_spec_fac
		INNER JOIN [dbo].[EducationBranch]		EDU		ON EDU.[ik_spec] = RSF.[ik_spec]
		INNER JOIN [dbo].Person					P		ON P.nCode = [Zach].nCode
		WHERE ik_direction = 5				--СПО
				AND (ik_pricOtch = 3 OR ik_pricOtch	IS NULL)	--Причина отчисления - завершил учебучение
				--AND DateExit > '2014' 
				AND DateExit < '2017') VIP	--год выпуска

INNER JOIN	(--Получаем абитуриентов
				SELECT IDPerson
					, IDApplication
					, LastName
					, FirstName
					, MiddleName
					, DateBirth
					, Speciality
					, IDFormEducation 
					, IDSpeciality
					, SpecialityShort
					, [Year]
				FROM [FIS].ApplicationView
				WHERE [Year] > 2013																--год поступления
						AND IDDirection <> 5													--направление 
						--AND IDSpecialityFIS in (17764, 17728, 17587, 17936, 18088)			--определенные специальности
						AND IDStateZachFIS = 8 ) App ON App.LastName = VIP.LastName				--сравниваем выпусников и абитуриентов по ФИО,
														AND App.FirstName = VIP.FirstName		--т.к. у нас абитуриент может быть добавлен как новый человек
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

GROUP BY App.Speciality, VIP.Speciality, IDFormEducation, VIP2.GroupName, VIP.GroupName, DateExit, App.Year
ORDER BY App.Year, Year(DateExit), VIP.Speciality, VIP2.GroupName, VIP.GroupName