pub const LDAPSStatus = enum {
    enabling,
    enabled,
    enable_failed,
    disabled,

    pub const json_field_names = .{
        .enabling = "ENABLING",
        .enabled = "ENABLED",
        .enable_failed = "ENABLE_FAILED",
        .disabled = "DISABLED",
    };
};
