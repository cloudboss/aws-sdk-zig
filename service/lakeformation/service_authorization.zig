/// Authorization status for service integrations. Specify a value of `ENABLED`
/// or `DISABLED`.
pub const ServiceAuthorization = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
