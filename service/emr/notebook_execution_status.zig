pub const NotebookExecutionStatus = enum {
    start_pending,
    starting,
    running,
    finishing,
    finished,
    failing,
    failed,
    stop_pending,
    stopping,
    stopped,

    pub const json_field_names = .{
        .start_pending = "START_PENDING",
        .starting = "STARTING",
        .running = "RUNNING",
        .finishing = "FINISHING",
        .finished = "FINISHED",
        .failing = "FAILING",
        .failed = "FAILED",
        .stop_pending = "STOP_PENDING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
    };
};
