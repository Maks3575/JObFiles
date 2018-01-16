select * from [dbo].[Street] R
where R.CStreet in (
select CStreet from [dbo].[Street]
group by CStreet
having count(*) > 1
)
order by R.CStreet desc
