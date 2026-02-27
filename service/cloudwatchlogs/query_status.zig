pub const QueryStatus = enum {
    scheduled,
    running,
    complete,
    failed,
    cancelled,
    timeout,
    unknown,

    pub const json_field_names = .{
        .scheduled = "Scheduled",
        .running = "Running",
        .complete = "Complete",
        .failed = "Failed",
        .cancelled = "Cancelled",
        .timeout = "Timeout",
        .unknown = "Unknown",
    };
};
