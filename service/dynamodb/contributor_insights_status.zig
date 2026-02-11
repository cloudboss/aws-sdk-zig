pub const ContributorInsightsStatus = enum {
    enabling,
    enabled,
    disabling,
    disabled,
    failed,

    pub const json_field_names = .{
        .enabling = "ENABLING",
        .enabled = "ENABLED",
        .disabling = "DISABLING",
        .disabled = "DISABLED",
        .failed = "FAILED",
    };
};
