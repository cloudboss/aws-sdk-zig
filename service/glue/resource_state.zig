pub const ResourceState = enum {
    queued,
    in_progress,
    success,
    stopped,
    failed,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .in_progress = "IN_PROGRESS",
        .success = "SUCCESS",
        .stopped = "STOPPED",
        .failed = "FAILED",
    };
};
