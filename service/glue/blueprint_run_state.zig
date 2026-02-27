pub const BlueprintRunState = enum {
    running,
    succeeded,
    failed,
    rolling_back,

    pub const json_field_names = .{
        .running = "RUNNING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .rolling_back = "ROLLING_BACK",
    };
};
