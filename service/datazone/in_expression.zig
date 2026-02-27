/// Specifies whether values are in the expression.
pub const InExpression = struct {
    /// The name of the column.
    column_name: []const u8,

    /// The values that might be in the expression.
    values: []const []const u8,

    pub const json_field_names = .{
        .column_name = "columnName",
        .values = "values",
    };
};
