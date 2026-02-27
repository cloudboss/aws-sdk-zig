pub const JobRunState = enum {
    starting,
    running,
    stopping,
    stopped,
    succeeded,
    failed,
    timeout,

    pub const json_field_names = .{
        .starting = "STARTING",
        .running = "RUNNING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .timeout = "TIMEOUT",
    };
};
