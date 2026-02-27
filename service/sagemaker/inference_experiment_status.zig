pub const InferenceExperimentStatus = enum {
    creating,
    created,
    updating,
    running,
    starting,
    stopping,
    completed,
    cancelled,

    pub const json_field_names = .{
        .creating = "CREATING",
        .created = "CREATED",
        .updating = "UPDATING",
        .running = "RUNNING",
        .starting = "STARTING",
        .stopping = "STOPPING",
        .completed = "COMPLETED",
        .cancelled = "CANCELLED",
    };
};
