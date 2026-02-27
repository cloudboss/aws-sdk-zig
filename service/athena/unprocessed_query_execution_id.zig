/// Describes a query execution that failed to process.
pub const UnprocessedQueryExecutionId = struct {
    /// The error code returned when the query execution failed to process, if
    /// applicable.
    error_code: ?[]const u8,

    /// The error message returned when the query execution failed to process, if
    /// applicable.
    error_message: ?[]const u8,

    /// The unique identifier of the query execution.
    query_execution_id: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .query_execution_id = "QueryExecutionId",
    };
};
