/// A calculated column for a dataset.
pub const CalculatedColumn = struct {
    /// A unique ID to identify a calculated column. During a dataset update, if the
    /// column ID
    /// of a calculated column matches that of an existing calculated column, Quick
    /// Sight
    /// preserves the existing calculated column.
    column_id: []const u8,

    /// Column name.
    column_name: []const u8,

    /// An expression that defines the calculated column.
    expression: []const u8,

    pub const json_field_names = .{
        .column_id = "ColumnId",
        .column_name = "ColumnName",
        .expression = "Expression",
    };
};
