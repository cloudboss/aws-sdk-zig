pub const TelemetryState = enum {
    enabled,
    disabled,
    not_applicable,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .not_applicable = "NOT_APPLICABLE",
    };
};
