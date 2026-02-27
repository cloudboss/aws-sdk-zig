pub const CalculationExecutionState = enum {
    creating,
    created,
    queued,
    running,
    canceling,
    canceled,
    completed,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .created = "CREATED",
        .queued = "QUEUED",
        .running = "RUNNING",
        .canceling = "CANCELING",
        .canceled = "CANCELED",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
