pub const DataSourceRunStatus = enum {
    requested,
    running,
    failed,
    partially_succeeded,
    success,

    pub const json_field_names = .{
        .requested = "REQUESTED",
        .running = "RUNNING",
        .failed = "FAILED",
        .partially_succeeded = "PARTIALLY_SUCCEEDED",
        .success = "SUCCESS",
    };
};
