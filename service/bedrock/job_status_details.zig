pub const JobStatusDetails = enum {
    in_progress,
    completed,
    stopping,
    stopped,
    failed,
    not_started,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .failed = "FAILED",
        .not_started = "NOT_STARTED",
    };
};
