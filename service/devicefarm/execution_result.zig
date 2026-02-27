pub const ExecutionResult = enum {
    pending,
    passed,
    warned,
    failed,
    skipped,
    errored,
    stopped,

    pub const json_field_names = .{
        .pending = "PENDING",
        .passed = "PASSED",
        .warned = "WARNED",
        .failed = "FAILED",
        .skipped = "SKIPPED",
        .errored = "ERRORED",
        .stopped = "STOPPED",
    };
};
