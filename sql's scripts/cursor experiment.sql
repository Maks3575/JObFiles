begin 
	declare @name varchar(max)
	declare @id int
	declare @idtype int
	declare @guid varchar(max)
	declare @lv1 cursor 
	set @lv1 = cursor scroll  
			   for select Cregion, Ik_strana, GUID from dbo.Region where GUID is not null


	open @lv1
	fetch next from @lv1 into @name, @id, @guid
	while @@FETCH_STATUS = 0
	begin
	if (
		select count(*) as co 
		from.dbo.Region
		where GUID is not null and Cregion = @name 
		and Ik_strana = @id 
		) >1
	print @name+ ' : ' + cast(@id as varchar(max))
	fetch next from @lv1 into @name, @id, @guid
	end
	close @lv1
end