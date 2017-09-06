--SELECT *
--  FROM [UGTU_TEST].[dbo].[Raion]
--  where GUID in (
select GUID, count(*) as co 
from [UGTU_TEST].[dbo].[Raion]
group by GUID
having count(*) > 1
order by co desc
--)