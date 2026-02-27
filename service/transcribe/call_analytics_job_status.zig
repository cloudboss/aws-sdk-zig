pub const CallAnalyticsJobStatus = enum {
    queued,
    in_progress,
    failed,
    completed,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .completed = "COMPLETED",
    };
};
