/// The SQL query run details of a data lineage run.
pub const LineageSqlQueryRunDetails = struct {
    /// The error message of the SQL query run details of a data lineage run.
    error_messages: ?[]const []const u8 = null,

    /// The number of queries that failed in the SQL query run details of a data
    /// lineage run.
    num_queries_failed: ?i32 = null,

    /// The query end time in the SQL query run details of a data lineage run.
    query_end_time: ?i64 = null,

    /// The query start time in the SQL query run details of a data lineage run.
    query_start_time: ?i64 = null,

    /// The total queries processed in the SQL query run details of a data lineage
    /// run.
    total_queries_processed: ?i32 = null,

    pub const json_field_names = .{
        .error_messages = "errorMessages",
        .num_queries_failed = "numQueriesFailed",
        .query_end_time = "queryEndTime",
        .query_start_time = "queryStartTime",
        .total_queries_processed = "totalQueriesProcessed",
    };
};
