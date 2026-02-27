const ColumnType = @import("column_type.zig").ColumnType;

/// Metadata for a column.
pub const ColumnSchema = struct {
    /// The name of a column.
    column_name: []const u8,

    /// The data type of column.
    column_types: []const ColumnType,

    pub const json_field_names = .{
        .column_name = "columnName",
        .column_types = "columnTypes",
    };
};
