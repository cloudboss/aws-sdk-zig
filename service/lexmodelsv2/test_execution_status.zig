pub const TestExecutionStatus = enum {
    pending,
    waiting,
    in_progress,
    completed,
    failed,
    stopping,
    stopped,

    pub const json_field_names = .{
        .pending = "Pending",
        .waiting = "Waiting",
        .in_progress = "InProgress",
        .completed = "Completed",
        .failed = "Failed",
        .stopping = "Stopping",
        .stopped = "Stopped",
    };
};
