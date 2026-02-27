/// Specifies the Auto-Tune desired state. Valid values are ENABLED, DISABLED.
pub const AutoTuneDesiredState = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
