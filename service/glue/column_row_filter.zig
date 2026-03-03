/// A filter that uses both column-level and row-level filtering.
pub const ColumnRowFilter = struct {
    /// A string containing the name of the column.
    column_name: ?[]const u8 = null,

    /// A string containing the row-level filter expression.
    row_filter_expression: ?[]const u8 = null,

    pub const json_field_names = .{
        .column_name = "ColumnName",
        .row_filter_expression = "RowFilterExpression",
    };
};
