/// Specifies that a value is like the expression.
pub const LikeExpression = struct {
    /// The name of the column.
    column_name: []const u8,

    /// The value that might be like the expression.
    value: []const u8,

    pub const json_field_names = .{
        .column_name = "columnName",
        .value = "value",
    };
};
