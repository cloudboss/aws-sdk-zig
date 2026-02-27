pub const CanaryRunState = enum {
    running,
    passed,
    failed,

    pub const json_field_names = .{
        .running = "RUNNING",
        .passed = "PASSED",
        .failed = "FAILED",
    };
};
