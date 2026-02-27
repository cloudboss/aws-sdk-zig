pub const JobStatus = enum {
    running,
    succeeded,
    failed,
    queued,

    pub const json_field_names = .{
        .running = "RUNNING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .queued = "QUEUED",
    };
};
