pub const IntegrationStatus = enum {
    pending,
    in_progress,
    active,
    inactive,
    disabling,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .disabling = "DISABLING",
    };
};
