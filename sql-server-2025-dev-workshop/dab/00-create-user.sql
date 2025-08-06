use vslive2025_redmond
go

if not exists (select * from sys.server_principals where [type] in ('E', 'S') and [name] = 'dab_user')
begin 
    create login [dab_user] with password = 'P@ssw0rd'
end    

if not exists (select * from sys.database_principals where [type] in ('E', 'S') and [name] = 'dab_user')
begin
    create user [dab_user] from login [dab_user]            
end

-- Just for demo purposes, don't do this in production, 
-- but, instead, give only the minimum permissions needed for the application to work
if not exists(select * from sys.database_role_members where 
                role_principal_id = database_principal_id('db_owner') and 
                member_principal_id = database_principal_id('dab_user'))
begin
    alter role db_owner add member [dab_user]
end