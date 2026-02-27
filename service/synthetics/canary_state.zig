pub const CanaryState = enum {
    creating,
    ready,
    starting,
    running,
    updating,
    stopping,
    stopped,
    @"error",
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .ready = "READY",
        .starting = "STARTING",
        .running = "RUNNING",
        .updating = "UPDATING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .@"error" = "ERROR",
        .deleting = "DELETING",
    };
};
