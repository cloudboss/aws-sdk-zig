/// Specifies that a value might be not like the expression.
pub const NotLikeExpression = struct {
    /// The name of the column.
    column_name: []const u8,

    /// The value that might not be like the expression.
    value: []const u8,

    pub const json_field_names = .{
        .column_name = "columnName",
        .value = "value",
    };
};
