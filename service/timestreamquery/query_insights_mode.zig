pub const QueryInsightsMode = enum {
    enabled_with_rate_control,
    disabled,

    pub const json_field_names = .{
        .enabled_with_rate_control = "ENABLED_WITH_RATE_CONTROL",
        .disabled = "DISABLED",
    };
};
