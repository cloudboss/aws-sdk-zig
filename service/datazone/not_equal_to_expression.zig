/// Specifies that a value is not equal to the expression.
pub const NotEqualToExpression = struct {
    /// The name of the column.
    column_name: []const u8,

    /// The value that might not be equal to the expression.
    value: []const u8,

    pub const json_field_names = .{
        .column_name = "columnName",
        .value = "value",
    };
};
