pub const ExperimentStatus = enum {
    created,
    updating,
    running,
    completed,
    cancelled,

    pub const json_field_names = .{
        .created = "CREATED",
        .updating = "UPDATING",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .cancelled = "CANCELLED",
    };
};
