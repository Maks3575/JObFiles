
select GUID, count(*) as co 
from [UGTU_TEST].[dbo].[Region]
group by GUID
having count(*) > 1
order by co desc
