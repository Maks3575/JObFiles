/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT *
  FROM [UGTU_TEST].[dbo].[Gorod]
where Cgorod = 'Красавино' or Cgorod = 'Лальск'
 order by [Ik_raion]

 go

 SELECT *
  FROM [UGTUTestForAddress].[dbo].[Gorod]
where Cgorod = 'Красавино' or Cgorod = 'Лальск'
 order by [Ik_raion]