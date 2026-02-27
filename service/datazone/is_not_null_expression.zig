/// Specifies that the expression is not null.
pub const IsNotNullExpression = struct {
    /// The name of the column.
    column_name: []const u8,

    pub const json_field_names = .{
        .column_name = "columnName",
    };
};
