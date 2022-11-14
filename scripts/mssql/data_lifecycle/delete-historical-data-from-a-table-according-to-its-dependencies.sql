if object_id('tempdb..#tmp') is not null
	drop table #tmp;
create table  #tmp  (id int, tablename varchar(256), lvl int, ParentTable varchar(256));

insert into #tmp 
exec dbo.usp_RechercheDependance @nomTable='DHB_DIM.PATRIMOINE', @debug=0;

declare @where varchar(max) ='where DHB_DIM.PATRIMOINE.T_DATE_SUPP is not null' -- Si la clause est nulle ou vide, elle supprimera les tables dans leur ensemble dans le bon ordre (autant faire un truncate alors !)
--declare @otherWhere varchar(max) ='where DHB_DIM.PATRIMOINE.T_DATE_SUPP T_DATE_SUPP = ' + char(39) + '12/10/2017 10:56:17.507 AM' + char(39) -- Si la clause est nulle ou vide, elle supprimera les tables dans leur ensemble dans le bon ordre (autant faire un truncate alors !)
declare @curFK cursor, @fk_object_id int;
declare @sqlcmd varchar(max)='', @crlf char(2)=char(0x0d)+char(0x0a);
declare @child varchar(256), @parent varchar(256), @lvl int, @id int;
declare @i int;
declare @t table (tablename varchar(128));
declare @curT cursor;
if isnull(@where, '')= ''
begin
	set @curT = cursor for select tablename, lvl from #tmp order by lvl desc
	open @curT;
	fetch next from @curT into @child, @lvl;
	while @@fetch_status = 0
	begin -- boucle @curT
		if not exists (select 1 from @t where tablename=@child)
			insert into @t (tablename) values (@child);
		fetch next from @curT into @child, @lvl;
	end -- boucle @curT
	close @curT;
	deallocate @curT;

	select  @sqlcmd = @sqlcmd + 'delete from ' + tablename + @crlf from @t ;
	print @sqlcmd;
end
else
begin 
	declare curT cursor for
	select  lvl, id
	from #tmp
	order by lvl desc;

	open curT;
	fetch next from curT into  @lvl, @id;
	while @@FETCH_STATUS =0
	begin
		set @i=0;
		if @lvl =0
		begin -- c'est le niveau racine
			select @sqlcmd = 'delete from ' + tablename from #tmp where id = @id;
		end -- c'est le niveau racine

		while @i < @lvl
		begin -- while

			select top 1 @child=TableName, @parent=ParentTable from #tmp where id <= @id-@i and lvl <= @lvl-@i order by lvl desc, id desc;
			set @curFK = cursor for
			select object_id from sys.foreign_keys 
			where parent_object_id = object_id(@child)
			and referenced_object_id = object_id(@parent)

			open @curFK;
			fetch next from @curFk into @fk_object_id
			while @@fetch_status =0
			begin -- @curFK

				if @i=0
					set @sqlcmd = 'delete from ' + @child + @crlf +
					'from ' + @child + @crlf + 'inner join ' + @parent  ;
				else
					set @sqlcmd = @sqlcmd + @crlf + 'inner join ' + @parent ;

				;with c as 
				(
					select child = object_schema_name(fc.parent_object_id)+'.' + object_name(fc.parent_object_id), child_col=c.name
					, parent = object_schema_name(fc.referenced_object_id)+'.' + object_name(fc.referenced_object_id), parent_col=c2.name
					, rnk = row_number() over (order by (select null))
					from sys.foreign_key_columns fc
					inner join sys.columns c
					on fc.parent_column_id = c.column_id
					and fc.parent_object_id = c.object_id
					inner join sys.columns c2
					on fc.referenced_column_id = c2.column_id
					and fc.referenced_object_id = c2.object_id
					where fc.constraint_object_id=@fk_object_id
				)
					select @sqlcmd =@sqlcmd +  case rnk when 1 then ' on '  else ' and ' end 
					+ @child +'.'+ child_col +'='  +  @parent   +'.' + parent_col
					from c;
					fetch next from @curFK into @fk_object_id;
			end --@curFK
			close @curFK;
			deallocate @curFK;
			set @i = @i +1;
		end --while
		print @sqlcmd + @crlf + @where + ';';
		print '';
		fetch next from curT into  @lvl, @id;
	end
	close curT;
	deallocate curT;
end

go