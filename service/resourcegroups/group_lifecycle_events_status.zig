pub const GroupLifecycleEventsStatus = enum {
    active,
    inactive,
    in_progress,
    @"error",

    pub const json_field_names = .{
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .in_progress = "IN_PROGRESS",
        .@"error" = "ERROR",
    };
};
