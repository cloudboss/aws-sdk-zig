pub const ProactiveEngagementStatus = enum {
    enabled,
    disabled,
    pending,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .pending = "PENDING",
    };
};
