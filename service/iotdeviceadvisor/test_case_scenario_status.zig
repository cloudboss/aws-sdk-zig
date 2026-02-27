pub const TestCaseScenarioStatus = enum {
    pass,
    fail,
    canceled,
    pending,
    running,
    stopping,
    stopped,
    pass_with_warnings,
    @"error",

    pub const json_field_names = .{
        .pass = "PASS",
        .fail = "FAIL",
        .canceled = "CANCELED",
        .pending = "PENDING",
        .running = "RUNNING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .pass_with_warnings = "PASS_WITH_WARNINGS",
        .@"error" = "ERROR",
    };
};
