SELECT          dbo.Strana.Ik_strana as [��������], 
				dbo.Strana.Cstrana as [������], 
				dbo.Strana.GUID as [GUID������], 
				dbo.Region.Ik_region as [���������], 
				dbo.Region.Cregion as [������], 
				dbo.Region.GUID as [GUID�������], 
				dbo.Raion.Ik_raion as [��������], 
				dbo.Raion.Craion as [�����], 
				dbo.Raion.GUID as [GUID������], 
                dbo.Gorod.Ik_gorod as [��������], 
				dbo.Gorod.Cgorod as [�����], 
				dbo.type_gorod.ctype_gorod as [���������], 
				dbo.Gorod.GUID as [GUID������], 
				dbo.Street.Ik_street as [�������], 
				dbo.Street.CStreet as [�����], 
				dbo.Type_street.CType_Street as [��������], 
				dbo.Street.GUID as [GUID�����]
FROM            dbo.Raion left JOIN
                        dbo.Gorod ON dbo.Raion.Ik_raion = dbo.Gorod.Ik_raion left JOIN
                         dbo.Region ON dbo.Raion.Ik_region = dbo.Region.Ik_region left JOIN
                        dbo.Strana ON dbo.Region.Ik_strana = dbo.Strana.Ik_strana left JOIN
                         dbo.Street ON dbo.Gorod.Ik_gorod = dbo.Street.ik_gorod left JOIN
                         dbo.type_gorod ON dbo.Gorod.ik_type_gorod = dbo.type_gorod.ik_type_gorod left JOIN
                         dbo.Type_street ON dbo.Street.Ik_type_street = dbo.Type_street.Ik_type_street

						order by Gorod.Ik_gorod desc
