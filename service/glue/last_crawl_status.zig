pub const LastCrawlStatus = enum {
    succeeded,
    cancelled,
    failed,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
    };
};
