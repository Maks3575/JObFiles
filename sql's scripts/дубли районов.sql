select * from [dbo].[Raion] R
where R.Craion in (
select Craion from [dbo].[Raion]
group by Craion
having count(*) > 1
)
order by R.Craion desc
