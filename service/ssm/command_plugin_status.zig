pub const CommandPluginStatus = enum {
    pending,
    in_progress,
    success,
    timed_out,
    cancelled,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .success = "SUCCESS",
        .timed_out = "TIMED_OUT",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
    };
};
