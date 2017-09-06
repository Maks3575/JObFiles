USE [UGTU_TEST]
GO

/****** Object:  View [dbo].[AddressCleanerView]    Script Date: 14.12.2016 10:11:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[AddressCleanerView]
as
SELECT          [UGTU_TEST].dbo.Strana.Ik_strana as [ид—траны], 
				[UGTU_TEST].dbo.Strana.Cstrana as [—трана], 
				[UGTU_TEST].dbo.Strana.GUID as [GUIDстраны], 
				[UGTU_TEST].dbo.Region.Ik_region as [ид–егиона], 
				[UGTU_TEST].dbo.Region.Cregion as [–егион], 
				[UGTU_TEST].dbo.Region.GUID as [GUIDрегиона], 
				[UGTU_TEST].dbo.Raion.Ik_raion as [ид–айона], 
				[UGTU_TEST].dbo.Raion.Craion as [–айон], 
				[UGTU_TEST].dbo.Raion.GUID as [GUIDрайона], 
                [UGTU_TEST].dbo.Gorod.Ik_gorod as [ид√орода], 
				[UGTU_TEST].dbo.Gorod.Cgorod as [√ород], 
				[UGTU_TEST].dbo.type_gorod.ctype_gorod as [тип√орода], 
				[UGTU_TEST].dbo.Gorod.GUID as [GUIDгорода], 
				[UGTU_TEST].dbo.Street.Ik_street as [ид”лицы], 
				[UGTU_TEST].dbo.Street.CStreet as [”лица], 
				[UGTU_TEST].dbo.Type_street.CType_Street as [тип”лицы], 
				[UGTU_TEST].dbo.Street.GUID as [GUIDулицы]
FROM            [UGTU_TEST].dbo.Raion INNER JOIN
                         [UGTU_TEST].dbo.Gorod ON [UGTU_TEST].dbo.Raion.Ik_raion = [UGTU_TEST].dbo.Gorod.Ik_raion INNER JOIN
                         [UGTU_TEST].dbo.Region ON [UGTU_TEST].dbo.Raion.Ik_region = [UGTU_TEST].dbo.Region.Ik_region INNER JOIN
                         [UGTU_TEST].dbo.Strana ON [UGTU_TEST].dbo.Region.Ik_strana = [UGTU_TEST].dbo.Strana.Ik_strana INNER JOIN
                         [UGTU_TEST].dbo.Street ON [UGTU_TEST].dbo.Gorod.Ik_gorod = [UGTU_TEST].dbo.Street.ik_gorod INNER JOIN
                         [UGTU_TEST].dbo.type_gorod ON [UGTU_TEST].dbo.Gorod.ik_type_gorod = [UGTU_TEST].dbo.type_gorod.ik_type_gorod INNER JOIN
                         [UGTU_TEST].dbo.Type_street ON [UGTU_TEST].dbo.Street.Ik_type_street = [UGTU_TEST].dbo.Type_street.Ik_type_street
GO


