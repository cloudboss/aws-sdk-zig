pub const JobStatus = enum {
    submitted,
    in_progress,
    completed,
    failed,
    stop_requested,
    stopped,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .stop_requested = "STOP_REQUESTED",
        .stopped = "STOPPED",
    };
};
