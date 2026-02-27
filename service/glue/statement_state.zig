pub const StatementState = enum {
    waiting,
    running,
    available,
    cancelling,
    cancelled,
    @"error",

    pub const json_field_names = .{
        .waiting = "WAITING",
        .running = "RUNNING",
        .available = "AVAILABLE",
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
        .@"error" = "ERROR",
    };
};
