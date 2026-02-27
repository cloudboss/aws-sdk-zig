pub const TlsSessionResumptionMode = enum {
    disabled,
    enabled,
    enforced,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
        .enforced = "ENFORCED",
    };
};
