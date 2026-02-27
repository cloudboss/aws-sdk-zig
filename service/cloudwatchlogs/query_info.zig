const QueryLanguage = @import("query_language.zig").QueryLanguage;
const QueryStatus = @import("query_status.zig").QueryStatus;

/// Information about one CloudWatch Logs Insights query that matches the
/// request in a
/// `DescribeQueries` operation.
pub const QueryInfo = struct {
    /// The date and time that this query was created.
    create_time: ?i64,

    /// The name of the log group scanned by this query.
    log_group_name: ?[]const u8,

    /// The unique ID number of this query.
    query_id: ?[]const u8,

    /// The query language used for this query. For more information about the query
    /// languages
    /// that CloudWatch Logs supports, see [Supported query
    /// languages](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_AnalyzeLogData_Languages.html).
    query_language: ?QueryLanguage,

    /// The query string used in this query.
    query_string: ?[]const u8,

    /// The status of this query. Possible values are `Cancelled`,
    /// `Complete`, `Failed`, `Running`, `Scheduled`,
    /// and `Unknown`.
    status: ?QueryStatus,

    pub const json_field_names = .{
        .create_time = "createTime",
        .log_group_name = "logGroupName",
        .query_id = "queryId",
        .query_language = "queryLanguage",
        .query_string = "queryString",
        .status = "status",
    };
};
