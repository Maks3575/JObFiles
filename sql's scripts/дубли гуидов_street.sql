
select GUID, count(*) as co 
from [UGTU_TEST].[dbo].[Street]
group by GUID
having count(*) > 1
order by co desc
