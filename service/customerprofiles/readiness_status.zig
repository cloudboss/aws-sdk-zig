pub const ReadinessStatus = enum {
    preparing,
    in_progress,
    completed,
    failed,

    pub const json_field_names = .{
        .preparing = "PREPARING",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
