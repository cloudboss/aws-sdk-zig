pub const HumanLoopStatus = enum {
    in_progress,
    failed,
    completed,
    stopped,
    stopping,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .completed = "COMPLETED",
        .stopped = "STOPPED",
        .stopping = "STOPPING",
    };
};
