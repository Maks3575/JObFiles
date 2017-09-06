USE [UGTU_TEST]
GO

/****** Object:  View [dbo].[AddressCleanerView]    Script Date: 14.12.2016 10:11:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[AddressCleanerView]
as
SELECT          [UGTU_TEST].dbo.Strana.Ik_strana as [��������], 
				[UGTU_TEST].dbo.Strana.Cstrana as [������], 
				[UGTU_TEST].dbo.Strana.GUID as [GUID������], 
				[UGTU_TEST].dbo.Region.Ik_region as [���������], 
				[UGTU_TEST].dbo.Region.Cregion as [������], 
				[UGTU_TEST].dbo.Region.GUID as [GUID�������], 
				[UGTU_TEST].dbo.Raion.Ik_raion as [��������], 
				[UGTU_TEST].dbo.Raion.Craion as [�����], 
				[UGTU_TEST].dbo.Raion.GUID as [GUID������], 
                [UGTU_TEST].dbo.Gorod.Ik_gorod as [��������], 
				[UGTU_TEST].dbo.Gorod.Cgorod as [�����], 
				[UGTU_TEST].dbo.type_gorod.ctype_gorod as [���������], 
				[UGTU_TEST].dbo.Gorod.GUID as [GUID������], 
				[UGTU_TEST].dbo.Street.Ik_street as [�������], 
				[UGTU_TEST].dbo.Street.CStreet as [�����], 
				[UGTU_TEST].dbo.Type_street.CType_Street as [��������], 
				[UGTU_TEST].dbo.Street.GUID as [GUID�����]
FROM            [UGTU_TEST].dbo.Raion INNER JOIN
                         [UGTU_TEST].dbo.Gorod ON [UGTU_TEST].dbo.Raion.Ik_raion = [UGTU_TEST].dbo.Gorod.Ik_raion INNER JOIN
                         [UGTU_TEST].dbo.Region ON [UGTU_TEST].dbo.Raion.Ik_region = [UGTU_TEST].dbo.Region.Ik_region INNER JOIN
                         [UGTU_TEST].dbo.Strana ON [UGTU_TEST].dbo.Region.Ik_strana = [UGTU_TEST].dbo.Strana.Ik_strana INNER JOIN
                         [UGTU_TEST].dbo.Street ON [UGTU_TEST].dbo.Gorod.Ik_gorod = [UGTU_TEST].dbo.Street.ik_gorod INNER JOIN
                         [UGTU_TEST].dbo.type_gorod ON [UGTU_TEST].dbo.Gorod.ik_type_gorod = [UGTU_TEST].dbo.type_gorod.ik_type_gorod INNER JOIN
                         [UGTU_TEST].dbo.Type_street ON [UGTU_TEST].dbo.Street.Ik_type_street = [UGTU_TEST].dbo.Type_street.Ik_type_street
GO


