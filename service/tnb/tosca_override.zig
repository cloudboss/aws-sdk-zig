/// Overrides of the TOSCA node.
pub const ToscaOverride = struct {
    /// Default value for the override.
    default_value: ?[]const u8,

    /// Name of the TOSCA override.
    name: ?[]const u8,

    pub const json_field_names = .{
        .default_value = "defaultValue",
        .name = "name",
    };
};
