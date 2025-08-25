# VS Live 2025 - Redmond HQ - JSON Samples

Make sure to use SQL Server 2025 to run the samples

If you need a SQL Server database you can use the free SQL Server Developer Edition. The easiest way to get started is to use the Docker container for SQL Server. You can find the instructions in the [Local SQL Server container](https://learn.microsoft.com/en-us/sql/tools/visual-studio-code-extensions/mssql/mssql-local-container?view=sql-server-ver17) documentation.


During the session I also showed the following demo that uses JSON to make the database schema as flexible as needed, taking advatange of the latest EF Core support to JSON columns:

https://github.com/Azure-Samples/azure-sql-db-dynamic-schema-ef

For even more samples on how JSON can be used in AZure SQL and as a great transport between your backend and the database, take a look at the following resources:

 - [Measure how fast you can move data between backend and Azure SQL using different tecniques](https://github.com/yorek/azure-sql-db-samples/tree/master/samples/07-network-latency)
 - [Implement Dynamic Schema support in your database using three different patterns](https://github.com/Azure-Samples/azure-sql-db-dynamic-schema)
 - [10k Request per Second REST API with Azure SQL, Dapper, and JSON](https://techcommunity.microsoft.com/t5/azure-sql-blog/10k-request-per-second-rest-api-with-azure-sql-dapper-and-json/ba-p/1189675)