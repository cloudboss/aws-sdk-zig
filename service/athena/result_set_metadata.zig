const ColumnInfo = @import("column_info.zig").ColumnInfo;

/// The metadata that describes the column structure and data types of a table
/// of query
/// results. To return a `ResultSetMetadata` object, use GetQueryResults.
pub const ResultSetMetadata = struct {
    /// Information about the columns returned in a query result metadata.
    column_info: ?[]const ColumnInfo = null,

    pub const json_field_names = .{
        .column_info = "ColumnInfo",
    };
};
