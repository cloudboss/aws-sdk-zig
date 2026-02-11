pub const ExecutionStatus = enum {
    running,
    succeeded,
    failed,
    timed_out,
    stopped,

    pub const json_field_names = .{
        .running = "RUNNING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .timed_out = "TIMED_OUT",
        .stopped = "STOPPED",
    };
};
