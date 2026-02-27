pub const ExecutionStatus = enum {
    running,
    succeeded,
    failed,
    timed_out,
    aborted,
    pending_redrive,

    pub const json_field_names = .{
        .running = "RUNNING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .timed_out = "TIMED_OUT",
        .aborted = "ABORTED",
        .pending_redrive = "PENDING_REDRIVE",
    };
};
