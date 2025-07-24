use vslive2025_redmond;
go

drop table if exists dbo.test_json_index;
create table dbo.test_json_index
(
    id int not null primary key,
    [document] json not null
)
go

insert into dbo.test_json_index
select 
    [value],
    json_object(
            'id': [value],
            'datetime': sysdatetime(),
            'somedata1': newid(),
            'somedata2': newid(),
            'somedata3': newid(),
            'somedata4': newid(),
            'somedata5': newid(),
            'somedata6': newid(),
            'somearray': json_array(newid(), newid(), newid(), [value])            
    ) as document
from 
    generate_series(1, 100000)
go

create json index ixj on dbo.test_json_index(document)
go

set statistics io on

select * from dbo.test_json_index where json_value(document, '$.id' returning int) = 100

select * from dbo.test_json_index where json_contains(document, 100, '$.id') = 1

select * from dbo.test_json_index where json_contains(document, 100, '$.somearray[*]') = 1

