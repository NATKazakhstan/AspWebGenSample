if exists (select 1
            from  sysobjects
           where  id = object_id('DIC_MyFirstDictionary')
            and   type = 'U')
   drop table DIC_MyFirstDictionary
go

/*==============================================================*/
/* Table: DIC_MyFirstDictionary                                 */
/*==============================================================*/
create table DIC_MyFirstDictionary (
   id                   bigint               identity,
   Code                 nvarchar(4)          not null,
   Name                 nvarchar(255)        not null,
   DateStart            datetime             not null,
   DateEnd              datetime             null,
   RowVersion           timestamp            null,
   constraint PK_DIC_MYFIRSTDICTIONARY primary key (id)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('DIC_MyFirstDictionary') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'DIC_MyFirstDictionary' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'My First Dictionary', 
   'user', @CurrentUser, 'table', 'DIC_MyFirstDictionary'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('DIC_MyFirstDictionary')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'DIC_MyFirstDictionary', 'column', 'id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Identifier',
   'user', @CurrentUser, 'table', 'DIC_MyFirstDictionary', 'column', 'id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('DIC_MyFirstDictionary')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Code')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'DIC_MyFirstDictionary', 'column', 'Code'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'System code',
   'user', @CurrentUser, 'table', 'DIC_MyFirstDictionary', 'column', 'Code'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('DIC_MyFirstDictionary')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'DIC_MyFirstDictionary', 'column', 'Name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Name',
   'user', @CurrentUser, 'table', 'DIC_MyFirstDictionary', 'column', 'Name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('DIC_MyFirstDictionary')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'DateStart')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'DIC_MyFirstDictionary', 'column', 'DateStart'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Date time Start',
   'user', @CurrentUser, 'table', 'DIC_MyFirstDictionary', 'column', 'DateStart'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('DIC_MyFirstDictionary')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'DateEnd')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'DIC_MyFirstDictionary', 'column', 'DateEnd'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Date time End',
   'user', @CurrentUser, 'table', 'DIC_MyFirstDictionary', 'column', 'DateEnd'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('DIC_MyFirstDictionary')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'RowVersion')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'DIC_MyFirstDictionary', 'column', 'RowVersion'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'timestamp',
   'user', @CurrentUser, 'table', 'DIC_MyFirstDictionary', 'column', 'RowVersion'
go
