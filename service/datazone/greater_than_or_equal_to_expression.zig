/// Specifies whether the value is greater than or equal to an expression.
pub const GreaterThanOrEqualToExpression = struct {
    /// The name of the column.
    column_name: []const u8,

    /// The value that might be greater than or equal to an expression.
    value: []const u8,

    pub const json_field_names = .{
        .column_name = "columnName",
        .value = "value",
    };
};
