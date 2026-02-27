/// The status of a test case execution.
pub const TestCaseExecutionStatus = enum {
    initiated,
    passed,
    failed,
    in_progress,
    stopped,

    pub const json_field_names = .{
        .initiated = "INITIATED",
        .passed = "PASSED",
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
        .stopped = "STOPPED",
    };
};
