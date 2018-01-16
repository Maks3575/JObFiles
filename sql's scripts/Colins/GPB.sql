SELECT ROW_NUMBER() OVER(ORDER BY AppV.FullName)	[№]
		, 6130										[код организации (УГТУ-6130)]
		, AppV.LastName								[Фамилия]
		, AppV.FirstName							[Имя]
		, AppV.MiddleName							[Отчество]
		, IIF(AppV.IDGenderFIS = 1, 'М', 'Ж')		[Пол]
		, AdrV.Country								[Страна]
		, AdrV.Region								[Регион]
		, AdrV.Raion								[Район]
		, AdrV.Town									[Город]
		, AdrV.Street								[Улица]
		, AdrV.House								[Дом]
		, AdrV.Flat									[Квартира]      
		, (CASE DocV.IDDocumentFIS
				WHEN 1 THEN 21
				WHEN 3 THEN 10
				WHEN 9 THEN 0
				WHEN 11 THEN 12
		  END)										[Тип удостоверения личности]-- (21 - паспорт РФ, 12 - вид на жительство РФ, 14 - врем. уд. личности РФ, 10 - иностранный паспорт, 0 - иной документ)"]         
		, DocV.DocumentSeria						[Серия]								                                                                                                    
		, DocV.DocumentNumber						[Номер]		                                                                                                    
		, FORMAT(cast(DocV.DateDocument as DATE), 'd', 'de-de' )						[Когда выдано]	                                                                                                    
		, DocV.DocumentOrganization					[Кем выдано]	                                                                                                   
		, FORMAT(cast(AppV.DateBirth as DATE), 'd', 'de-de' )							[Дата рождения]	                                                                                                    
		, P.Cplacebirth								[Место рождения]                                                                                                   
		, St.Cstrana								[Страна рождения]                                                                                                   
		, P.ctelefon								[Домашний телефон]	                                                                                                  
		, P.cSotTel									[Мобильный телефон]	                                                                                            
		, ''										[Рабочий телефон]                                                                                          
		, P.cEmail									[Электронная почта]                                                                                           
		, ''										[Кодовое слово]                                                                                              
		, ''										[Имя в латинской транскрипции (в соответствии с загран. паспортом при наличии)]                                                                                              
		, ''										[Фамилия в латинской транскрипции (в соответствии с загран. паспортом при наличии)]                                                                                              
		, IIF(AdrV.Town = 'Ухта', '1100000800000', IIF(AdrV.Town = 'Воркута', '1100000200000',''))									["Код города проживания (Ухта-1100000800000, Воркута-1100000200000)"]                                                                                            
		, 1831										[ID (код) учебного заведения (УГТУ-1831)]                                                                                              
		,(CASE AppV.IDFormEducation
				WHEN 1 THEN 2
				WHEN 2 THEN 1
		  END)	 									["Форма обучения (Заочно-1, Очно-2)"]                                                                                            
		, 1											[Курс (год обучения)]                                                                                            
		, Prik.Nn_prikaz+' '+FORMAT(cast(Prik.Dd_prikaz as DATE), 'd', 'de-de' )						[Номер документа, подтверждающего факт обучения (максимум 16 символов)]   	                                                                                         
		, 643										[Страна УЗ]   
		, AppV.FacultyShort	 						[Институт]   
FROM [FIS].ApplicationView			AppV
	INNER JOIN Person				P		ON P.nCode = AppV.IDPerson
	LEFT JOIN [FIS].AddressView		AdrV	ON AdrV.IDPerson = AppV.IDPerson
												AND AdrV.IDTypeAddress = 2
	LEFT JOIN [FIS].DocumentsView	DocV	ON DocV.IDPerson = AppV.IDPerson
												AND DocV.IDDictionary = 22
	INNER JOIN Strana				St		ON St.Ik_strana = P.Ik_grazd
	INNER JOIN dbo.Prikaz			Prik	ON AppV.IDOrder = Prik.Ik_prikaz
WHERE AppV.Year = 2017
		AND AppV.IDStateZachFIS = 8
		AND AppV.IDFaculty <> 31 
		AND AppV.IDFormEducation = 1
		AND AppV.IDTypeCategoryZach <> 15
		AND DocV.IDDocumentFIS <> 4


		--select * from [FIS].DocumentsView where IDDictionary NOT IN (31)