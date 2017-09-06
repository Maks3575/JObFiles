select * from dbo.Region
where GUID is not null and Ik_strana = 2
order by Cregion

go

select * from dbo.Raion
where GUID is null and Ik_region in 
(select Ik_region from dbo.Region
where GUID is null and Ik_strana = 2)

go

select * from dbo.Gorod
where GUID is null and Ik_raion in 
(select r.Ik_raion from dbo.Region re 
inner join dbo.Raion r
on r.Ik_region = re.Ik_region
 where re.Ik_strana = 2
)

go

select * from dbo.Street
where GUID is null and ik_gorod in 
(select g.ik_gorod from dbo.Region re inner join 
dbo.Raion r 
on r.Ik_region = re.Ik_region inner join 
dbo.Gorod g
on g.Ik_raion = r.Ik_raion
where re.Ik_strana = 2
) 