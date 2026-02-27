/// A `UniqueKey` configuration that references a dataset column.
pub const UniqueKey = struct {
    /// The name of the column that is referenced in the `UniqueKey`
    /// configuration.
    column_names: []const []const u8,

    pub const json_field_names = .{
        .column_names = "ColumnNames",
    };
};
