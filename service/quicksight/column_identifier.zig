/// A column of a data set.
pub const ColumnIdentifier = struct {
    /// The name of the column.
    column_name: []const u8,

    /// The data set that the column belongs to.
    data_set_identifier: []const u8,

    pub const json_field_names = .{
        .column_name = "ColumnName",
        .data_set_identifier = "DataSetIdentifier",
    };
};
