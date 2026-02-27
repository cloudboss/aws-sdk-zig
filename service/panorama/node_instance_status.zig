pub const NodeInstanceStatus = enum {
    running,
    @"error",
    not_available,
    paused,

    pub const json_field_names = .{
        .running = "RUNNING",
        .@"error" = "ERROR",
        .not_available = "NOT_AVAILABLE",
        .paused = "PAUSED",
    };
};
