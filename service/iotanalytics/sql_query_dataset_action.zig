const QueryFilter = @import("query_filter.zig").QueryFilter;

/// The SQL query to modify the message.
pub const SqlQueryDatasetAction = struct {
    /// Prefilters applied to message data.
    filters: ?[]const QueryFilter,

    /// A SQL query string.
    sql_query: []const u8,

    pub const json_field_names = .{
        .filters = "filters",
        .sql_query = "sqlQuery",
    };
};
