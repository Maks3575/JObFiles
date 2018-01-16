select * from [dbo].[Region] R
where R.Cregion in (
select Cregion from [dbo].[Region]
group by Cregion
having count(*) > 1
)
order by R.Cregion desc
