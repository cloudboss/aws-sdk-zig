pub const Status = enum {
    not_started,
    starting,
    failed_start,
    running,
    stopping,
    failed_stop,
    stopped,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .starting = "STARTING",
        .failed_start = "FAILED_START",
        .running = "RUNNING",
        .stopping = "STOPPING",
        .failed_stop = "FAILED_STOP",
        .stopped = "STOPPED",
    };
};
