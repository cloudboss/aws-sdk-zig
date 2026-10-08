/// Contains metadata about a column in the query results.
pub const ColumnInformation = struct {
    /// The name of the column.
    name: []const u8,

    /// The data type of the column. Valid values are STRING, DOUBLE, BOOLEAN,
    /// INTEGER, TIMESTAMP, and VARIANT.
    type: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .type = "type",
    };
};
