pub const TaskStatus = enum {
    scheduled,
    started,
    in_progress,
    completed,
    @"error",
    skipped,
    cancelled,

    pub const json_field_names = .{
        .scheduled = "SCHEDULED",
        .started = "STARTED",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .@"error" = "ERROR",
        .skipped = "SKIPPED",
        .cancelled = "CANCELLED",
    };
};
