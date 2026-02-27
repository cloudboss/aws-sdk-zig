/// The Auto-Tune desired state. Valid values are ENABLED and DISABLED.
pub const AutoTuneDesiredState = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
