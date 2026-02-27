pub const State = enum {
    waiting,
    in_progress,
    @"error",
    completed,
    cancelled,
    timed_out,

    pub const json_field_names = .{
        .waiting = "WAITING",
        .in_progress = "IN_PROGRESS",
        .@"error" = "ERROR",
        .completed = "COMPLETED",
        .cancelled = "CANCELLED",
        .timed_out = "TIMED_OUT",
    };
};
