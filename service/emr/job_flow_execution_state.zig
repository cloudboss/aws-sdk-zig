/// The type of instance.
pub const JobFlowExecutionState = enum {
    starting,
    bootstrapping,
    running,
    waiting,
    shutting_down,
    terminated,
    completed,
    failed,

    pub const json_field_names = .{
        .starting = "STARTING",
        .bootstrapping = "BOOTSTRAPPING",
        .running = "RUNNING",
        .waiting = "WAITING",
        .shutting_down = "SHUTTING_DOWN",
        .terminated = "TERMINATED",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
