pub const NotificationEvent = enum {
    all,
    in_progress,
    success,
    timed_out,
    cancelled,
    failed,

    pub const json_field_names = .{
        .all = "ALL",
        .in_progress = "IN_PROGRESS",
        .success = "SUCCESS",
        .timed_out = "TIMED_OUT",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
    };
};
