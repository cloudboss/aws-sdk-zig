pub const WorkerStatus = enum {
    created,
    started,
    stopping,
    stopped,
    not_responding,
    not_compatible,
    running,
    idle,

    pub const json_field_names = .{
        .created = "CREATED",
        .started = "STARTED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .not_responding = "NOT_RESPONDING",
        .not_compatible = "NOT_COMPATIBLE",
        .running = "RUNNING",
        .idle = "IDLE",
    };
};
