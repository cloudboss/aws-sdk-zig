pub const ExecutionStatus = enum {
    running,
    invalid_query,
    complete,
    failed,
    timeout,

    pub const json_field_names = .{
        .running = "Running",
        .invalid_query = "InvalidQuery",
        .complete = "Complete",
        .failed = "Failed",
        .timeout = "Timeout",
    };
};
