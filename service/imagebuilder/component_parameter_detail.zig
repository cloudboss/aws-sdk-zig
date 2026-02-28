/// Defines a parameter that is used to provide configuration details for the
/// component.
pub const ComponentParameterDetail = struct {
    /// The default value of this parameter if no input is provided.
    default_value: ?[]const []const u8,

    /// Describes this parameter.
    description: ?[]const u8,

    /// The name of this input parameter.
    name: []const u8,

    /// The type of input this parameter provides. The currently supported value is
    /// "string".
    @"type": []const u8,

    pub const json_field_names = .{
        .default_value = "defaultValue",
        .description = "description",
        .name = "name",
        .@"type" = "type",
    };
};
