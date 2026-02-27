pub const FeatureStatus = enum {
    enabled,
    disabled,
    unsupported,
    enabled_pending_reboot,
    disabled_pending_reboot,
    unknown,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .unsupported = "UNSUPPORTED",
        .enabled_pending_reboot = "ENABLED_PENDING_REBOOT",
        .disabled_pending_reboot = "DISABLED_PENDING_REBOOT",
        .unknown = "UNKNOWN",
    };
};
