pub const Status = enum {
    not_started,
    in_progress,
    failed,
    completed,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .completed = "COMPLETED",
    };
};
