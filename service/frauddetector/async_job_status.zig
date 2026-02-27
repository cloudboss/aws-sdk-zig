pub const AsyncJobStatus = enum {
    in_progress_initializing,
    in_progress,
    cancel_in_progress,
    canceled,
    complete,
    failed,

    pub const json_field_names = .{
        .in_progress_initializing = "IN_PROGRESS_INITIALIZING",
        .in_progress = "IN_PROGRESS",
        .cancel_in_progress = "CANCEL_IN_PROGRESS",
        .canceled = "CANCELED",
        .complete = "COMPLETE",
        .failed = "FAILED",
    };
};
