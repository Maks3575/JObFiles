SELECT          *
FROM            [UGTU_TEST].[dbo].[AddressCleanerView]
where --GUIDгорода = GUIDрайона and Город = Район
GUIDулицы is not null and (GUIDрегиона is null or GUIDрайона is null or GUIDгорода is null)  --and идСтраны = 2-- and идГорода =889 in(791,513,889, 8690) Район GUIDрайона = GUIDрегиона
order by идГорода