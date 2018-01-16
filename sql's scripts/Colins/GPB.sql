SELECT ROW_NUMBER() OVER(ORDER BY AppV.FullName)	[�]
		, 6130										[��� ����������� (����-6130)]
		, AppV.LastName								[�������]
		, AppV.FirstName							[���]
		, AppV.MiddleName							[��������]
		, IIF(AppV.IDGenderFIS = 1, '�', '�')		[���]
		, AdrV.Country								[������]
		, AdrV.Region								[������]
		, AdrV.Raion								[�����]
		, AdrV.Town									[�����]
		, AdrV.Street								[�����]
		, AdrV.House								[���]
		, AdrV.Flat									[��������]      
		, (CASE DocV.IDDocumentFIS
				WHEN 1 THEN 21
				WHEN 3 THEN 10
				WHEN 9 THEN 0
				WHEN 11 THEN 12
		  END)										[��� ������������� ��������]-- (21 - ������� ��, 12 - ��� �� ���������� ��, 14 - ����. ��. �������� ��, 10 - ����������� �������, 0 - ���� ��������)"]         
		, DocV.DocumentSeria						[�����]								                                                                                                    
		, DocV.DocumentNumber						[�����]		                                                                                                    
		, FORMAT(cast(DocV.DateDocument as DATE), 'd', 'de-de' )						[����� ������]	                                                                                                    
		, DocV.DocumentOrganization					[��� ������]	                                                                                                   
		, FORMAT(cast(AppV.DateBirth as DATE), 'd', 'de-de' )							[���� ��������]	                                                                                                    
		, P.Cplacebirth								[����� ��������]                                                                                                   
		, St.Cstrana								[������ ��������]                                                                                                   
		, P.ctelefon								[�������� �������]	                                                                                                  
		, P.cSotTel									[��������� �������]	                                                                                            
		, ''										[������� �������]                                                                                          
		, P.cEmail									[����������� �����]                                                                                           
		, ''										[������� �����]                                                                                              
		, ''										[��� � ��������� ������������ (� ������������ � ������. ��������� ��� �������)]                                                                                              
		, ''										[������� � ��������� ������������ (� ������������ � ������. ��������� ��� �������)]                                                                                              
		, IIF(AdrV.Town = '����', '1100000800000', IIF(AdrV.Town = '�������', '1100000200000',''))									["��� ������ ���������� (����-1100000800000, �������-1100000200000)"]                                                                                            
		, 1831										[ID (���) �������� ��������� (����-1831)]                                                                                              
		,(CASE AppV.IDFormEducation
				WHEN 1 THEN 2
				WHEN 2 THEN 1
		  END)	 									["����� �������� (������-1, ����-2)"]                                                                                            
		, 1											[���� (��� ��������)]                                                                                            
		, Prik.Nn_prikaz+' '+FORMAT(cast(Prik.Dd_prikaz as DATE), 'd', 'de-de' )						[����� ���������, ��������������� ���� �������� (�������� 16 ��������)]   	                                                                                         
		, 643										[������ ��]   
		, AppV.FacultyShort	 						[��������]   
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