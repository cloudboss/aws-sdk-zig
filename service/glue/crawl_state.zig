pub const CrawlState = enum {
    running,
    cancelling,
    cancelled,
    succeeded,
    failed,
    @"error",

    pub const json_field_names = .{
        .running = "RUNNING",
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .@"error" = "ERROR",
    };
};
