const EngineVersion = @import("engine_version.zig").EngineVersion;
const ManagedQueryResultsConfiguration = @import("managed_query_results_configuration.zig").ManagedQueryResultsConfiguration;
const QueryExecutionContext = @import("query_execution_context.zig").QueryExecutionContext;
const QueryResultsS3AccessGrantsConfiguration = @import("query_results_s3_access_grants_configuration.zig").QueryResultsS3AccessGrantsConfiguration;
const ResultConfiguration = @import("result_configuration.zig").ResultConfiguration;
const ResultReuseConfiguration = @import("result_reuse_configuration.zig").ResultReuseConfiguration;
const StatementType = @import("statement_type.zig").StatementType;
const QueryExecutionStatistics = @import("query_execution_statistics.zig").QueryExecutionStatistics;
const QueryExecutionStatus = @import("query_execution_status.zig").QueryExecutionStatus;

/// Information about a single instance of a query execution.
pub const QueryExecution = struct {
    /// The engine version that executed the query.
    engine_version: ?EngineVersion = null,

    /// A list of values for the parameters in a query. The values are applied
    /// sequentially to
    /// the parameters in the query in the order in which the parameters occur. The
    /// list of
    /// parameters is not returned in the response.
    execution_parameters: ?[]const []const u8 = null,

    /// The configuration for storing results in Athena owned storage, which
    /// includes whether
    /// this feature is enabled; whether encryption configuration, if any, is used
    /// for
    /// encrypting query results.
    managed_query_results_configuration: ?ManagedQueryResultsConfiguration = null,

    /// The SQL query statements which the query execution ran.
    query: ?[]const u8 = null,

    /// The database in which the query execution occurred.
    query_execution_context: ?QueryExecutionContext = null,

    /// The unique identifier for each query execution.
    query_execution_id: ?[]const u8 = null,

    /// Specifies whether Amazon S3 access grants are enabled for query
    /// results.
    query_results_s3_access_grants_configuration: ?QueryResultsS3AccessGrantsConfiguration = null,

    /// The location in Amazon S3 where query and calculation results are stored and
    /// the encryption option, if any, used for query results. These are known as
    /// "client-side
    /// settings". If workgroup settings override client-side settings, then the
    /// query uses the
    /// location for the query results and the encryption configuration that are
    /// specified for
    /// the workgroup.
    result_configuration: ?ResultConfiguration = null,

    /// Specifies the query result reuse behavior that was used for the query.
    result_reuse_configuration: ?ResultReuseConfiguration = null,

    /// The type of query statement that was run. `DDL` indicates DDL query
    /// statements. `DML` indicates DML (Data Manipulation Language) query
    /// statements, such as `CREATE TABLE AS SELECT`. `UTILITY` indicates
    /// query statements other than DDL and DML, such as `SHOW CREATE TABLE`,
    /// `EXPLAIN`, `DESCRIBE`, or `SHOW TABLES`.
    statement_type: ?StatementType = null,

    /// Query execution statistics, such as the amount of data scanned, the amount
    /// of time
    /// that the query took to process, and the type of statement that was run.
    statistics: ?QueryExecutionStatistics = null,

    /// The completion date, current state, submission time, and state change reason
    /// (if
    /// applicable) for the query execution.
    status: ?QueryExecutionStatus = null,

    /// The kind of query statement that was run.
    substatement_type: ?[]const u8 = null,

    /// The name of the workgroup in which the query ran.
    work_group: ?[]const u8 = null,

    pub const json_field_names = .{
        .engine_version = "EngineVersion",
        .execution_parameters = "ExecutionParameters",
        .managed_query_results_configuration = "ManagedQueryResultsConfiguration",
        .query = "Query",
        .query_execution_context = "QueryExecutionContext",
        .query_execution_id = "QueryExecutionId",
        .query_results_s3_access_grants_configuration = "QueryResultsS3AccessGrantsConfiguration",
        .result_configuration = "ResultConfiguration",
        .result_reuse_configuration = "ResultReuseConfiguration",
        .statement_type = "StatementType",
        .statistics = "Statistics",
        .status = "Status",
        .substatement_type = "SubstatementType",
        .work_group = "WorkGroup",
    };
};
