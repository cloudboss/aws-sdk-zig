const ColumnMetadata = @import("column_metadata.zig").ColumnMetadata;

/// The metadata of the result set returned by a SQL statement.
pub const ResultSetMetadata = struct {
    /// The number of columns in the result set.
    column_count: i64 = 0,

    /// The metadata of the columns in the result set.
    column_metadata: ?[]const ColumnMetadata = null,

    pub const json_field_names = .{
        .column_count = "columnCount",
        .column_metadata = "columnMetadata",
    };
};
