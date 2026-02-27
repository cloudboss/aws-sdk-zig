pub const FlywheelIterationStatus = enum {
    training,
    evaluating,
    completed,
    failed,
    stop_requested,
    stopped,

    pub const json_field_names = .{
        .training = "TRAINING",
        .evaluating = "EVALUATING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .stop_requested = "STOP_REQUESTED",
        .stopped = "STOPPED",
    };
};
