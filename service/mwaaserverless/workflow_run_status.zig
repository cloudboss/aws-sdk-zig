pub const WorkflowRunStatus = enum {
    starting,
    queued,
    running,
    success,
    failed,
    timeout,
    stopping,
    stopped,

    pub const json_field_names = .{
        .starting = "STARTING",
        .queued = "QUEUED",
        .running = "RUNNING",
        .success = "SUCCESS",
        .failed = "FAILED",
        .timeout = "TIMEOUT",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
    };
};
