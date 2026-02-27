pub const BatchLoadStatus = enum {
    created,
    in_progress,
    failed,
    succeeded,
    progress_stopped,
    pending_resume,

    pub const json_field_names = .{
        .created = "CREATED",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .progress_stopped = "PROGRESS_STOPPED",
        .pending_resume = "PENDING_RESUME",
    };
};
