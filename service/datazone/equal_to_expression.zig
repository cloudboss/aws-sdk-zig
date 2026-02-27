/// Specifies whether the value is equal to an expression.
pub const EqualToExpression = struct {
    /// The name of the column.
    column_name: []const u8,

    /// The value that might be equal to an expression.
    value: []const u8,

    pub const json_field_names = .{
        .column_name = "columnName",
        .value = "value",
    };
};
