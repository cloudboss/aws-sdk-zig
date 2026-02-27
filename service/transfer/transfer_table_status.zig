pub const TransferTableStatus = enum {
    queued,
    in_progress,
    completed,
    failed,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
