/// Specifies that a value is less than an expression.
pub const LessThanExpression = struct {
    /// The name of the column.
    column_name: []const u8,

    /// The value that might be less than the expression.
    value: []const u8,

    pub const json_field_names = .{
        .column_name = "columnName",
        .value = "value",
    };
};
