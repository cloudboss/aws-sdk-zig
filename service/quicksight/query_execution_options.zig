const QueryExecutionMode = @import("query_execution_mode.zig").QueryExecutionMode;

/// A structure that describes the query execution options.
pub const QueryExecutionOptions = struct {
    /// A structure that describes the query execution mode.
    query_execution_mode: ?QueryExecutionMode = null,

    pub const json_field_names = .{
        .query_execution_mode = "QueryExecutionMode",
    };
};
