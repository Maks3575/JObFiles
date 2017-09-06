
select GUID, count(*) as co 
from [dbo].[Gorod]
group by GUID
having count(*) > 1
order by co desc
