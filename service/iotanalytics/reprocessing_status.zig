pub const ReprocessingStatus = enum {
    running,
    succeeded,
    cancelled,
    failed,

    pub const json_field_names = .{
        .running = "RUNNING",
        .succeeded = "SUCCEEDED",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
    };
};
