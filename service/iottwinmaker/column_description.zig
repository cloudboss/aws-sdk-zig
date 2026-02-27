const ColumnType = @import("column_type.zig").ColumnType;

/// A description of the column in the query results.
pub const ColumnDescription = struct {
    /// The name of the column description.
    name: ?[]const u8,

    /// The type of the column description.
    type: ?ColumnType,

    pub const json_field_names = .{
        .name = "name",
        .type = "type",
    };
};
