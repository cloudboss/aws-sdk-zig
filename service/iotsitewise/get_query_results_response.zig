const ColumnInformation = @import("column_information.zig").ColumnInformation;

/// Contains the response for the GetQueryResults operation.
pub const GetQueryResultsResponse = struct {
    /// A list of column metadata for the query results. Each entry contains the
    /// column name and data type. Present when the query status is COMPLETED.
    column_info: ?[]const ColumnInformation = null,

    /// The token for the next set of results, or null if there are no additional
    /// results.
    next_token: ?[]const u8 = null,

    /// The result rows. Each row is a list of string column values, positional to
    /// match the columnInfo order. Present when the query status is COMPLETED.
    rows: ?[]const []const []const u8 = null,

    pub const json_field_names = .{
        .column_info = "columnInfo",
        .next_token = "nextToken",
        .rows = "rows",
    };
};
