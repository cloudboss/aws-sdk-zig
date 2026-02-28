/// Includes basic information for a data column such as its description, name,
/// and
/// type.
pub const Column = struct {
    /// The description for a column.
    description: ?[]const u8,

    /// The column name.
    name: ?[]const u8,

    /// The kind of data a column stores.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .@"type" = "Type",
    };
};
