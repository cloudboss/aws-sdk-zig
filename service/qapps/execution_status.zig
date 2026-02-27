pub const ExecutionStatus = enum {
    in_progress,
    waiting,
    completed,
    @"error",

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .waiting = "WAITING",
        .completed = "COMPLETED",
        .@"error" = "ERROR",
    };
};
