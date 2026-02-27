pub const TopicRuleDestinationStatus = enum {
    enabled,
    in_progress,
    disabled,
    @"error",
    deleting,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .in_progress = "IN_PROGRESS",
        .disabled = "DISABLED",
        .@"error" = "ERROR",
        .deleting = "DELETING",
    };
};
