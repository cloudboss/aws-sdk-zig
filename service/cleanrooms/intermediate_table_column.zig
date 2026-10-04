/// Contains the name and type of a column in an intermediate table.
pub const IntermediateTableColumn = struct {
    /// The name of the column.
    name: []const u8,

    /// The data type of the column.
    @"type": []const u8,

    pub const json_field_names = .{
        .name = "name",
        .@"type" = "type",
    };
};
