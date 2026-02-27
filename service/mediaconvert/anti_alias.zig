/// The anti-alias filter is automatically applied to all outputs. The service
/// no longer accepts the value DISABLED for AntiAlias. If you specify that in
/// your job, the service will ignore the setting.
pub const AntiAlias = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
