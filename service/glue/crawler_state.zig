pub const CrawlerState = enum {
    ready,
    running,
    stopping,

    pub const json_field_names = .{
        .ready = "READY",
        .running = "RUNNING",
        .stopping = "STOPPING",
    };
};
