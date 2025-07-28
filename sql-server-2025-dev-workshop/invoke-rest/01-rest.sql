use vslive2025_redmond
go

declare @rv int;
declare @response nvarchar(max);

exec @rv = sp_invoke_external_rest_endpoint 
    @method = 'GET',
    @url = 'https://opentdb.com/api.php?amount=10',
    @response = @response output;

--select @response;

--select * from openjson(@response);

select * from openjson(@response, '$.result.results')
with (
    [type] nvarchar(50),
    [difficulty] nvarchar(50),
    [category] nvarchar(150),
    [question] nvarchar(max),
    [correct_answer] nvarchar(max),
    [incorrect_answers] nvarchar(max) as json
);