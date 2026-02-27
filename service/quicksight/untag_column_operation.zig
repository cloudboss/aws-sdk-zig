const ColumnTagName = @import("column_tag_name.zig").ColumnTagName;

/// A transform operation that removes tags associated with a column.
pub const UntagColumnOperation = struct {
    /// The column that this operation acts on.
    column_name: []const u8,

    /// The column tags to remove from this column.
    tag_names: []const ColumnTagName,

    pub const json_field_names = .{
        .column_name = "ColumnName",
        .tag_names = "TagNames",
    };
};
