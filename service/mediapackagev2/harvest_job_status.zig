pub const HarvestJobStatus = enum {
    queued,
    in_progress,
    cancelled,
    completed,
    failed,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .in_progress = "IN_PROGRESS",
        .cancelled = "CANCELLED",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
