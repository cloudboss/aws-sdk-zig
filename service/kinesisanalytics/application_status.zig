pub const ApplicationStatus = enum {
    deleting,
    starting,
    stopping,
    ready,
    running,
    updating,

    pub const json_field_names = .{
        .deleting = "DELETING",
        .starting = "STARTING",
        .stopping = "STOPPING",
        .ready = "READY",
        .running = "RUNNING",
        .updating = "UPDATING",
    };
};
