pub const ApplicationLifecycle = enum {
    creating,
    created,
    available,
    ready,
    starting,
    running,
    stopping,
    stopped,
    failed,
    deleting,
    deleting_from_environment,

    pub const json_field_names = .{
        .creating = "CREATING",
        .created = "CREATED",
        .available = "AVAILABLE",
        .ready = "READY",
        .starting = "STARTING",
        .running = "RUNNING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .failed = "FAILED",
        .deleting = "DELETING",
        .deleting_from_environment = "DELETING_FROM_ENVIRONMENT",
    };
};
