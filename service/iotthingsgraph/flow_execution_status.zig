pub const FlowExecutionStatus = enum {
    running,
    aborted,
    succeeded,
    failed,

    pub const json_field_names = .{
        .running = "RUNNING",
        .aborted = "ABORTED",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };
};
