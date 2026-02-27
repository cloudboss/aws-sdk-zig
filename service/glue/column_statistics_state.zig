pub const ColumnStatisticsState = enum {
    starting,
    running,
    succeeded,
    failed,
    stopped,

    pub const json_field_names = .{
        .starting = "STARTING",
        .running = "RUNNING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .stopped = "STOPPED",
    };
};
