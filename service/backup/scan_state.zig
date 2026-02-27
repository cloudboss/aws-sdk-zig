pub const ScanState = enum {
    canceled,
    completed,
    completed_with_issues,
    created,
    failed,
    running,

    pub const json_field_names = .{
        .canceled = "CANCELED",
        .completed = "COMPLETED",
        .completed_with_issues = "COMPLETED_WITH_ISSUES",
        .created = "CREATED",
        .failed = "FAILED",
        .running = "RUNNING",
    };
};
