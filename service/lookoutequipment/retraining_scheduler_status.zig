pub const RetrainingSchedulerStatus = enum {
    pending,
    running,
    stopping,
    stopped,

    pub const json_field_names = .{
        .pending = "PENDING",
        .running = "RUNNING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
    };
};
