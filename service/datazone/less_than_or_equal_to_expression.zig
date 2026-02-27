/// Specifies that a value is less than or equal to an expression.
pub const LessThanOrEqualToExpression = struct {
    /// The name of the column.
    column_name: []const u8,

    /// The value that might be less than or equal to an expression.
    value: []const u8,

    pub const json_field_names = .{
        .column_name = "columnName",
        .value = "value",
    };
};
