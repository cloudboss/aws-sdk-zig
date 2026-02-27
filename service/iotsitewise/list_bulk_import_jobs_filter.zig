pub const ListBulkImportJobsFilter = enum {
    all,
    pending,
    running,
    cancelled,
    failed,
    completed_with_failures,
    completed,

    pub const json_field_names = .{
        .all = "ALL",
        .pending = "PENDING",
        .running = "RUNNING",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
        .completed_with_failures = "COMPLETED_WITH_FAILURES",
        .completed = "COMPLETED",
    };
};
