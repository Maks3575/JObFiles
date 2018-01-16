select * from [dbo].[Gorod] R
where R.Cgorod in (
select Cgorod from [dbo].[Gorod]
group by Cgorod
having count(*) > 1
)
order by R.Cgorod desc
