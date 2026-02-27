pub const MapRunStatus = enum {
    running,
    succeeded,
    failed,
    aborted,

    pub const json_field_names = .{
        .running = "RUNNING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .aborted = "ABORTED",
    };
};
