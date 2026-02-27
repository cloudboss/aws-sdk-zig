pub const TableOptimizerEventType = enum {
    starting,
    completed,
    failed,
    in_progress,

    pub const json_field_names = .{
        .starting = "STARTING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
    };
};
