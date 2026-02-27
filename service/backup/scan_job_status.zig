pub const ScanJobStatus = enum {
    created,
    completed,
    completed_with_issues,
    running,
    failed,
    canceled,
    aggregate_all,
    any,

    pub const json_field_names = .{
        .created = "CREATED",
        .completed = "COMPLETED",
        .completed_with_issues = "COMPLETED_WITH_ISSUES",
        .running = "RUNNING",
        .failed = "FAILED",
        .canceled = "CANCELED",
        .aggregate_all = "AGGREGATE_ALL",
        .any = "ANY",
    };
};
