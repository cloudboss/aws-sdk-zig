pub const EstimateStatus = enum {
    running,
    succeeded,
    failed,

    pub const json_field_names = .{
        .running = "RUNNING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };
};
