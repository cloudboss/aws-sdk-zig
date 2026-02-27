/// A transform operation that renames a column.
pub const RenameColumnOperation = struct {
    /// The name of the column to be renamed.
    column_name: []const u8,

    /// The new name for the column.
    new_column_name: []const u8,

    pub const json_field_names = .{
        .column_name = "ColumnName",
        .new_column_name = "NewColumnName",
    };
};
