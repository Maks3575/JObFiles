SELECT          [UGTU].dbo.Strana.Ik_strana as [ид—траны], 
				[UGTU].dbo.Strana.Cstrana as [—трана], 
				--[UGTU].dbo.Strana.GUID as [GUIDстраны], 
				[UGTU].dbo.Region.Ik_region as [ид–егиона], 
				[UGTU].dbo.Region.Cregion as [–егион], 
				--[UGTU].dbo.Region.GUID as [GUIDрегиона], 
				[UGTU].dbo.Raion.Ik_raion as [ид–айона], 
				[UGTU].dbo.Raion.Craion as [–айон], 
				--[UGTU].dbo.Raion.GUID as [GUIDрайона], 
                [UGTU].dbo.Gorod.Ik_gorod as [ид√орода], 
				[UGTU].dbo.Gorod.Cgorod as [√ород], 
				[UGTU].dbo.type_gorod.ctype_gorod as [тип√орода], 
				--[UGTU].dbo.Gorod.GUID as [GUIDгорода], 
				[UGTU].dbo.Street.Ik_street as [ид”лицы], 
				[UGTU].dbo.Street.CStreet as [”лица], 
				[UGTU].dbo.Type_street.CType_Street as [тип”лицы]
				--[UGTU].dbo.Street.GUID as [GUIDулицы]
FROM            [UGTU].dbo.Raion INNER JOIN
                         [UGTU].dbo.Gorod ON [UGTU].dbo.Raion.Ik_raion = [UGTU].dbo.Gorod.Ik_raion INNER JOIN
                         [UGTU].dbo.Region ON [UGTU].dbo.Raion.Ik_region = [UGTU].dbo.Region.Ik_region INNER JOIN
                         [UGTU].dbo.Strana ON [UGTU].dbo.Region.Ik_strana = [UGTU].dbo.Strana.Ik_strana INNER JOIN
                         [UGTU].dbo.Street ON [UGTU].dbo.Gorod.Ik_gorod = [UGTU].dbo.Street.ik_gorod INNER JOIN
                         [UGTU].dbo.type_gorod ON [UGTU].dbo.Gorod.ik_type_gorod = [UGTU].dbo.type_gorod.ik_type_gorod INNER JOIN
                         [UGTU].dbo.Type_street ON [UGTU].dbo.Street.Ik_type_street = [UGTU].dbo.Type_street.Ik_type_street
where [UGTU].dbo.Street.Ik_street = 4043
