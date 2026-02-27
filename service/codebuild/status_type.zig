pub const StatusType = enum {
    succeeded,
    failed,
    fault,
    timed_out,
    in_progress,
    stopped,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .fault = "FAULT",
        .timed_out = "TIMED_OUT",
        .in_progress = "IN_PROGRESS",
        .stopped = "STOPPED",
    };
};
