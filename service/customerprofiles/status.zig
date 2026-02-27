pub const Status = enum {
    not_started,
    in_progress,
    complete,
    failed,
    split,
    retry,
    cancelled,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .in_progress = "IN_PROGRESS",
        .complete = "COMPLETE",
        .failed = "FAILED",
        .split = "SPLIT",
        .retry = "RETRY",
        .cancelled = "CANCELLED",
    };
};
