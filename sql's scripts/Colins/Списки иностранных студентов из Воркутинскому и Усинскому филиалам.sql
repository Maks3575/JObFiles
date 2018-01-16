SELECT DISTINCT 
			APP.FullName							[���] 
			, IIF(APP.IDGenderFIS = 1, '�', '�')	[���]
			, APP.Nationality						[�����������]
			, FORMAT(APP.DateBirth, 'd', 'de-de')	[���� ��������]					
			, APP.TypeDirection						[����������]
			, APP.Speciality						[����������c��]
			, ORD.OrderNumber						[����� �������]
			, FORMAT(ORD.DateOrder, 'd', 'de-de')	[���� �������]
			, ISNULL(DOC.Document, '')				[��������]
			, ISNULL(DOC.DocumentSeria, '')			[�����]
			, ISNULL(DOC.DocumentNumber, '')		[�����]
			, ISNULL(FORMAT(DOC.DateDocument, 'd', 'de-de'), '')	[���� ������ ���������]
			, ''													[���� ���������]
			, ISNULL([Telefon] + ', ', '')
				+ ISNULL([TelefonOther] + ' ', '')		[�������]
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
		WHERE ik_pricOtch IS NULL						--������� ����������
				AND APP.TypeCategoryZach IN (14, 15)	--������ � ��������
