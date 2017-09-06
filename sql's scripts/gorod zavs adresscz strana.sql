--select * from dbo.Gorod
--where GUID is null
--and Ik_gorod in (select Ik_gorod from dbo.Zaved_stud)
--go 
SELECT          dbo.Strana.Ik_strana as [идСтраны], 
				dbo.Strana.Cstrana as [Страна], 
				dbo.Strana.GUID as [GUIDстраны], 
				dbo.Region.Ik_region as [идРегиона], 
				dbo.Region.Cregion as [Регион], 
				dbo.Region.GUID as [GUIDрегиона], 
				dbo.Raion.Ik_raion as [идРайона], 
				dbo.Raion.Craion as [Район], 
				dbo.Raion.GUID as [GUIDрайона], 
                dbo.Gorod.Ik_gorod as [идГорода], 
				dbo.Gorod.Cgorod as [Город], 
				dbo.type_gorod.ctype_gorod as [типГорода], 
				dbo.Gorod.GUID as [GUIDгорода]
FROM            dbo.Raion INNER JOIN
                         dbo.Gorod ON dbo.Raion.Ik_raion = dbo.Gorod.Ik_raion INNER JOIN
                         dbo.Region ON dbo.Raion.Ik_region = dbo.Region.Ik_region INNER JOIN
                         dbo.Strana ON dbo.Region.Ik_strana = dbo.Strana.Ik_strana INNER JOIN
                         dbo.type_gorod ON dbo.Gorod.ik_type_gorod = dbo.type_gorod.ik_type_gorod
where  
dbo.Strana.Ik_strana = 2
and
dbo.Gorod.GUID is null 
and 
(dbo.Gorod.ik_gorod in (select Ik_gorod from dbo.Zaved_stud)
or dbo.Gorod.ik_gorod in (select id_gorod from ShemaCZS.AddressCZS))