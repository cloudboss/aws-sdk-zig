pub const ApplicationInstanceHealthStatus = enum {
    running,
    @"error",
    not_available,

    pub const json_field_names = .{
        .running = "RUNNING",
        .@"error" = "ERROR",
        .not_available = "NOT_AVAILABLE",
    };
};
