pub const JobStatus = enum {
    submitted,
    queued,
    in_progress,
    completed_with_errors,
    completed,
    failed,
    cancel_submitted,
    cancel_in_progress,
    cancel_completed,
    cancel_failed,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .queued = "QUEUED",
        .in_progress = "IN_PROGRESS",
        .completed_with_errors = "COMPLETED_WITH_ERRORS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .cancel_submitted = "CANCEL_SUBMITTED",
        .cancel_in_progress = "CANCEL_IN_PROGRESS",
        .cancel_completed = "CANCEL_COMPLETED",
        .cancel_failed = "CANCEL_FAILED",
    };
};
