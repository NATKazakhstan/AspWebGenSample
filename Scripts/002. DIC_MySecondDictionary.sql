if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DIC_MySecondDictionary') and o.name = 'FK_DIC_MySecondDictionary_DIC_MyFirstDictionary_refFirstDictionary')
alter table DIC_MySecondDictionary
   drop constraint FK_DIC_MySecondDictionary_DIC_MyFirstDictionary_refFirstDictionary
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DIC_MySecondDictionary')
            and   type = 'U')
   drop table DIC_MySecondDictionary
go

/*==============================================================*/
/* Table: DIC_MySecondDictionary                                */
/*==============================================================*/
create table DIC_MySecondDictionary (
   id                   bigint               identity,
   Name                 nvarchar(255)        not null,
   refFirstDictionary   bigint               not null,
   DecimalValue         decimal(10,2)        null,
   BoolValue            bit                  not null,
   RowVersion           timestamp            null,
   constraint PK_DIC_MYSECONDDICTIONARY primary key (id)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('DIC_MySecondDictionary') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'DIC_MySecondDictionary' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'My Second Dictionary', 
   'user', @CurrentUser, 'table', 'DIC_MySecondDictionary'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('DIC_MySecondDictionary')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'id')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'DIC_MySecondDictionary', 'column', 'id'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Identifier',
   'user', @CurrentUser, 'table', 'DIC_MySecondDictionary', 'column', 'id'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('DIC_MySecondDictionary')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'DIC_MySecondDictionary', 'column', 'Name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Name',
   'user', @CurrentUser, 'table', 'DIC_MySecondDictionary', 'column', 'Name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('DIC_MySecondDictionary')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'refFirstDictionary')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'DIC_MySecondDictionary', 'column', 'refFirstDictionary'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'First Dictionary Value',
   'user', @CurrentUser, 'table', 'DIC_MySecondDictionary', 'column', 'refFirstDictionary'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('DIC_MySecondDictionary')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'DecimalValue')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'DIC_MySecondDictionary', 'column', 'DecimalValue'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Decimal Value',
   'user', @CurrentUser, 'table', 'DIC_MySecondDictionary', 'column', 'DecimalValue'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('DIC_MySecondDictionary')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'BoolValue')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'DIC_MySecondDictionary', 'column', 'BoolValue'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Boolean Value',
   'user', @CurrentUser, 'table', 'DIC_MySecondDictionary', 'column', 'BoolValue'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('DIC_MySecondDictionary')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'RowVersion')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'DIC_MySecondDictionary', 'column', 'RowVersion'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'timestamp',
   'user', @CurrentUser, 'table', 'DIC_MySecondDictionary', 'column', 'RowVersion'
go

alter table DIC_MySecondDictionary
   add constraint FK_DIC_MySecondDictionary_DIC_MyFirstDictionary_refFirstDictionary foreign key (refFirstDictionary)
      references DIC_MyFirstDictionary (id)
go
