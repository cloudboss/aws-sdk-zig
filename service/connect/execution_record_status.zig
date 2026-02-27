pub const ExecutionRecordStatus = enum {
    passed,
    failed,
    in_progress,
    stopped,

    pub const json_field_names = .{
        .passed = "PASSED",
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
        .stopped = "STOPPED",
    };
};
