pub const RuleState = enum {
    enabled,
    disabled,
    enabled_with_all_cloudtrail_management_events,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .enabled_with_all_cloudtrail_management_events = "ENABLED_WITH_ALL_CLOUDTRAIL_MANAGEMENT_EVENTS",
    };
};
