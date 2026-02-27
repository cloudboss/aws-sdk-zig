pub const DatabaseStatus = enum {
    running,
    starting,
    stopped,
    warning,
    unknown,
    @"error",
    stopping,

    pub const json_field_names = .{
        .running = "RUNNING",
        .starting = "STARTING",
        .stopped = "STOPPED",
        .warning = "WARNING",
        .unknown = "UNKNOWN",
        .@"error" = "ERROR",
        .stopping = "STOPPING",
    };
};
