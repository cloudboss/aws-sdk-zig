pub const ExecutionStatus = enum {
    completed,
    in_progress,
    failed,

    pub const json_field_names = .{
        .completed = "COMPLETED",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
    };
};
