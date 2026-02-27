/// The environment configuration parameter.
pub const EnvironmentConfigurationParameter = struct {
    /// Specifies whether the environment parameter is editable.
    is_editable: ?bool,

    /// The name of the environment configuration parameter.
    name: ?[]const u8,

    /// The value of the environment configuration parameter.
    value: ?[]const u8,

    pub const json_field_names = .{
        .is_editable = "isEditable",
        .name = "name",
        .value = "value",
    };
};
