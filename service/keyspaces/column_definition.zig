/// The names and data types of regular columns.
pub const ColumnDefinition = struct {
    /// The name of the column.
    name: []const u8,

    /// The data type of the column. For a list of available data types, see [Data
    /// types](https://docs.aws.amazon.com/keyspaces/latest/devguide/cql.elements.html#cql.data-types) in the *Amazon Keyspaces Developer Guide*.
    @"type": []const u8,

    pub const json_field_names = .{
        .name = "name",
        .@"type" = "type",
    };
};
