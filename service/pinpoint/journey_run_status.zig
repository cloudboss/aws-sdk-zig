pub const JourneyRunStatus = enum {
    scheduled,
    running,
    completed,
    cancelled,

    pub const json_field_names = .{
        .scheduled = "SCHEDULED",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .cancelled = "CANCELLED",
    };
};
