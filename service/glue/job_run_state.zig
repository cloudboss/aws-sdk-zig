pub const JobRunState = enum {
    starting,
    running,
    stopping,
    stopped,
    succeeded,
    failed,
    timeout,
    @"error",
    waiting,
    expired,

    pub const json_field_names = .{
        .starting = "STARTING",
        .running = "RUNNING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .timeout = "TIMEOUT",
        .@"error" = "ERROR",
        .waiting = "WAITING",
        .expired = "EXPIRED",
    };
};
