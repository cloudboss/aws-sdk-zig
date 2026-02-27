pub const ExecutionStatus = enum {
    in_progress,
    completed,
    exception,
    handling_exception,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .exception = "EXCEPTION",
        .handling_exception = "HANDLING_EXCEPTION",
    };
};
