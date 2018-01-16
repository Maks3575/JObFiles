SELECT DISTINCT 
			APP.FullName							[ФИО] 
			, IIF(APP.IDGenderFIS = 1, 'М', 'Ж')	[Пол]
			, APP.Nationality						[Гражданство]
			, FORMAT(APP.DateBirth, 'd', 'de-de')	[Дата рождения]					
			, APP.TypeDirection						[Напраление]
			, APP.Speciality						[Специальноcть]
			, ORD.OrderNumber						[Номер приказа]
			, FORMAT(ORD.DateOrder, 'd', 'de-de')	[Дата приказа]
			, ISNULL(DOC.Document, '')				[Документ]
			, ISNULL(DOC.DocumentSeria, '')			[Серия]
			, ISNULL(DOC.DocumentNumber, '')		[Номер]
			, ISNULL(FORMAT(DOC.DateDocument, 'd', 'de-de'), '')	[Дата выдачи документа]
			, ''													[Срок документа]
			, ISNULL([Telefon] + ', ', '')
				+ ISNULL([TelefonOther] + ' ', '')		[Телефон]
			, [Email]									[E-mail]
			, APP.TypeCategoryZach
			, APP.IDTypeCategoryZach
		FROM 
		(SELECT *
			FROM [FIS].[ApplicationView]
			WHERE IDFaculty IN (15, 17)
					AND (IDNationality IS NULL OR IDNationality <> 1)) APP
		LEFT JOIN [FIS].DocumentsView			DOC		ON DOC.IDPerson = APP.IDPerson
														   AND DOC.IDDictionaryFIS = 22
		INNER JOIN Zach									ON Zach.nCode = APP.IDPerson
		INNER JOIN [FIS].OrdersOfAdmissionView	ORD		ON ORD.IDOrder = APP.IDOrder
		INNER JOIN [dbo].[StudGrup]						ON [Zach].Ik_zach = [StudGrup].Ik_zach
		INNER JOIN [dbo].[Grup]							ON [Grup].Ik_grup = [StudGrup].Ik_grup
		WHERE ik_pricOtch IS NULL						--Причина отчисления
				AND APP.TypeCategoryZach IN (14, 15)	--Бюджет и контракт
