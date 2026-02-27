pub const CrawlerHistoryState = enum {
    running,
    completed,
    failed,
    stopped,

    pub const json_field_names = .{
        .running = "RUNNING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .stopped = "STOPPED",
    };
};
