SELECT          [UGTU].dbo.Strana.Ik_strana as [��������], 
				[UGTU].dbo.Strana.Cstrana as [������], 
				--[UGTU].dbo.Strana.GUID as [GUID������], 
				[UGTU].dbo.Region.Ik_region as [���������], 
				[UGTU].dbo.Region.Cregion as [������], 
				--[UGTU].dbo.Region.GUID as [GUID�������], 
				[UGTU].dbo.Raion.Ik_raion as [��������], 
				[UGTU].dbo.Raion.Craion as [�����], 
				--[UGTU].dbo.Raion.GUID as [GUID������], 
                [UGTU].dbo.Gorod.Ik_gorod as [��������], 
				[UGTU].dbo.Gorod.Cgorod as [�����], 
				[UGTU].dbo.type_gorod.ctype_gorod as [���������], 
				--[UGTU].dbo.Gorod.GUID as [GUID������], 
				[UGTU].dbo.Street.Ik_street as [�������], 
				[UGTU].dbo.Street.CStreet as [�����], 
				[UGTU].dbo.Type_street.CType_Street as [��������]
				--[UGTU].dbo.Street.GUID as [GUID�����]
FROM            [UGTU].dbo.Raion INNER JOIN
                         [UGTU].dbo.Gorod ON [UGTU].dbo.Raion.Ik_raion = [UGTU].dbo.Gorod.Ik_raion INNER JOIN
                         [UGTU].dbo.Region ON [UGTU].dbo.Raion.Ik_region = [UGTU].dbo.Region.Ik_region INNER JOIN
                         [UGTU].dbo.Strana ON [UGTU].dbo.Region.Ik_strana = [UGTU].dbo.Strana.Ik_strana INNER JOIN
                         [UGTU].dbo.Street ON [UGTU].dbo.Gorod.Ik_gorod = [UGTU].dbo.Street.ik_gorod INNER JOIN
                         [UGTU].dbo.type_gorod ON [UGTU].dbo.Gorod.ik_type_gorod = [UGTU].dbo.type_gorod.ik_type_gorod INNER JOIN
                         [UGTU].dbo.Type_street ON [UGTU].dbo.Street.Ik_type_street = [UGTU].dbo.Type_street.Ik_type_street
where [UGTU].dbo.Street.Ik_street = 4043
