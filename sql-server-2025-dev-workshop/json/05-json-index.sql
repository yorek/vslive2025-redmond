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

dbcc freeproccache
go

-- Simulate a bigger table
update statistics test_json_index with rowcount = 10000000;
go

set statistics io on
go

select * from dbo.test_json_index
where cast(json_value(document, '$.id') as int) = 100;
go

select * from dbo.test_json_index
where json_value(document, '$.id' returning int) = 100;
go

select * from dbo.test_json_index
where cast(json_value(document, '$.id') as int) between 100 and 125;
go

select * from dbo.test_json_index
where json_value(document, '$.somedata1' returning varchar(64)) LIKE '2A94%';
go

-- Wildcard/pattern-based searches using JSON_CONTAINS
select * from dbo.test_json_index
where json_contains(document, '2A94%', '$.somedata1', 1) = 1;
go

select * from dbo.test_json_index
where json_contains(document, 100, '$.id') = 1

select * from dbo.test_json_index
where json_contains(document, 100, '$.somearray[*]') = 1

-- doesn't use index on CTP 2.1
select top(10) * from dbo.test_json_index
where json_value(document, '$.datetime' returning datetime2) >= '2025-07-24';

set static time on
set statistics io on
go

select * from dbo.test_json_index where json_value(document, '$.id' returning int) = 100

select * from dbo.test_json_index where json_contains(document, 100, '$.id') = 1

select * from dbo.test_json_index where json_contains(document, 100, '$.somearray[*]') = 1

