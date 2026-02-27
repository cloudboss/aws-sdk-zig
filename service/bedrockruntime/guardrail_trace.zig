pub const GuardrailTrace = enum {
    enabled,
    disabled,
    enabled_full,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .enabled_full = "ENABLED_FULL",
    };
};
