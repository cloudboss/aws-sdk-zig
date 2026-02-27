pub const ConfigurationStatus = enum {
    configured,
    unconfigured,

    pub const json_field_names = .{
        .configured = "CONFIGURED",
        .unconfigured = "UNCONFIGURED",
    };
};
