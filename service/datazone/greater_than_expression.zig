/// Specifies whether the value is greater than an expression.
pub const GreaterThanExpression = struct {
    /// The name of the column.
    column_name: []const u8,

    /// The value that might be greater than an expression.
    value: []const u8,

    pub const json_field_names = .{
        .column_name = "columnName",
        .value = "value",
    };
};
