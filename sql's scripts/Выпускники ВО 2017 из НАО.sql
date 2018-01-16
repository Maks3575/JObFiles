SELECT  DiSTINCT
	P.Clastname 
		+ IIF(P.Cfirstname IS NULL, '', ' ' + P.Cfirstname)
		+ IIF(P.Cotch IS NULL, '', ' ' + P.Cotch)		[���]
	,ISNULL(P.cSotTel,'') 
		+ IIF(P.ctelefon IS NULL, '', ' ' + P.ctelefon)	[�������]	
	, A.Region 
		+ IIF(A.Town IS NULL, '', ', ' + A.Town)
		+ IIF(A.Street IS NULL, '', ', ' + A.Street)	[�����]
	, D.cName_direction									[�����������]
	, EDU.Cname_spec									[�������������]
	, [Grup].Cname_grup									[������]
	, IIF(ik_pricOtch IS NULL, '���', '����')			[������ �� ���������� ��������]
FROM[dbo].[Zach]
INNER JOIN [dbo].[StudGrup]						ON [Zach].Ik_zach = [StudGrup].Ik_zach
INNER JOIN [dbo].[Grup]							ON [Grup].Ik_grup = [StudGrup].Ik_grup
INNER JOIN [dbo].[Relation_spec_fac]	RSF		ON RSF.ik_spec_fac = [Grup].ik_spec_fac
INNER JOIN [dbo].[EducationBranch]		EDU		ON EDU.[ik_spec] = RSF.[ik_spec]
INNER JOIN [dbo].Person					P		ON P.nCode = [Zach].nCode
INNER JOIN [FIS].AddressView			A		ON A.IDPerson = P.nCode
INNER JOIN Direction					D		ON D.ik_direction = EDU.ik_direction
WHERE	D.ik_direction NOT IN (5, 12)					--��
		AND (ik_pricOtch = 3
			OR ik_pricOtch IS NULL)						--������� ���������� - �������� ����������
		AND Year(DateExit) in (2015, 2016, 2017)		--���� ���������
		AND A.IDRaion = 15								--�����

		--select Distinct IDRaion, Raion from [FIS].AddressView
		