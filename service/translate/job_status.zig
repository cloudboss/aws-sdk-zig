pub const JobStatus = enum {
    submitted,
    in_progress,
    completed,
    completed_with_error,
    failed,
    stop_requested,
    stopped,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .completed_with_error = "COMPLETED_WITH_ERROR",
        .failed = "FAILED",
        .stop_requested = "STOP_REQUESTED",
        .stopped = "STOPPED",
    };
};
