pub const ActionStatus = enum {
    unknown,
    in_progress,
    completed,
    failed,
    stopping,
    stopped,

    pub const json_field_names = .{
        .unknown = "UNKNOWN",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
    };
};
