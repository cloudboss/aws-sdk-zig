pub const ScanJobState = enum {
    completed,
    completed_with_issues,
    failed,
    canceled,

    pub const json_field_names = .{
        .completed = "COMPLETED",
        .completed_with_issues = "COMPLETED_WITH_ISSUES",
        .failed = "FAILED",
        .canceled = "CANCELED",
    };
};
