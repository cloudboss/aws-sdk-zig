/// Global Configuration Low Framerate Inputs
pub const GlobalConfigurationLowFramerateInputs = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
