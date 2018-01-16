SELECT          dbo.Strana.Ik_strana as [ид—траны], 
				dbo.Strana.Cstrana as [—трана], 
				dbo.Strana.GUID as [GUIDстраны], 
				dbo.Region.Ik_region as [ид–егиона], 
				dbo.Region.Cregion as [–егион], 
				dbo.Region.GUID as [GUIDрегиона], 
				dbo.Raion.Ik_raion as [ид–айона], 
				dbo.Raion.Craion as [–айон], 
				dbo.Raion.GUID as [GUIDрайона], 
                dbo.Gorod.Ik_gorod as [ид√орода], 
				dbo.Gorod.Cgorod as [√ород], 
				dbo.type_gorod.ctype_gorod as [тип√орода], 
				dbo.Gorod.GUID as [GUIDгорода], 
				dbo.Street.Ik_street as [ид”лицы], 
				dbo.Street.CStreet as [”лица], 
				dbo.Type_street.CType_Street as [тип”лицы], 
				dbo.Street.GUID as [GUIDулицы]
FROM            dbo.Raion left JOIN
                        dbo.Gorod ON dbo.Raion.Ik_raion = dbo.Gorod.Ik_raion left JOIN
                         dbo.Region ON dbo.Raion.Ik_region = dbo.Region.Ik_region left JOIN
                        dbo.Strana ON dbo.Region.Ik_strana = dbo.Strana.Ik_strana left JOIN
                         dbo.Street ON dbo.Gorod.Ik_gorod = dbo.Street.ik_gorod left JOIN
                         dbo.type_gorod ON dbo.Gorod.ik_type_gorod = dbo.type_gorod.ik_type_gorod left JOIN
                         dbo.Type_street ON dbo.Street.Ik_type_street = dbo.Type_street.Ik_type_street

						order by Gorod.Ik_gorod desc
