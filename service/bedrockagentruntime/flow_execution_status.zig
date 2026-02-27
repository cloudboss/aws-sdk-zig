pub const FlowExecutionStatus = enum {
    running,
    succeeded,
    failed,
    timed_out,
    aborted,

    pub const json_field_names = .{
        .running = "RUNNING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .timed_out = "TIMED_OUT",
        .aborted = "ABORTED",
    };
};
