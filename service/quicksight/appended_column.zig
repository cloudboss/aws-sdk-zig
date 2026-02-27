/// Represents a column that will be included in the result of an append
/// operation, combining data from multiple sources.
pub const AppendedColumn = struct {
    /// The name of the column to include in the appended result.
    column_name: []const u8,

    /// A unique identifier for the column in the appended result.
    new_column_id: []const u8,

    pub const json_field_names = .{
        .column_name = "ColumnName",
        .new_column_id = "NewColumnId",
    };
};
