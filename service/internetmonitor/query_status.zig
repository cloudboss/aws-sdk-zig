pub const QueryStatus = enum {
    queued,
    running,
    succeeded,
    failed,
    canceled,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .running = "RUNNING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .canceled = "CANCELED",
    };
};
