/// The properties for the data export table.
pub const TablePropertyDescription = struct {
    /// The default value for the table.
    default_value: ?[]const u8 = null,

    /// The description for the table.
    description: ?[]const u8 = null,

    /// The name of the table.
    name: ?[]const u8 = null,

    /// The valid values for the table.
    valid_values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .default_value = "DefaultValue",
        .description = "Description",
        .name = "Name",
        .valid_values = "ValidValues",
    };
};
