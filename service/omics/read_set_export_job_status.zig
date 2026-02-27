pub const ReadSetExportJobStatus = enum {
    submitted,
    in_progress,
    cancelling,
    cancelled,
    failed,
    completed,
    completed_with_failures,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .in_progress = "IN_PROGRESS",
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
        .completed = "COMPLETED",
        .completed_with_failures = "COMPLETED_WITH_FAILURES",
    };
};
