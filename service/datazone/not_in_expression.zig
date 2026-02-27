/// Specifies that a value is not in the expression.
pub const NotInExpression = struct {
    /// The name of the column.
    column_name: []const u8,

    /// The value that might not be in the expression.
    values: []const []const u8,

    pub const json_field_names = .{
        .column_name = "columnName",
        .values = "values",
    };
};
