pub const ApplicationStatus = enum {
    deleting,
    starting,
    stopping,
    ready,
    running,
    updating,
    autoscaling,
    force_stopping,
    rolling_back,
    maintenance,
    rolled_back,

    pub const json_field_names = .{
        .deleting = "DELETING",
        .starting = "STARTING",
        .stopping = "STOPPING",
        .ready = "READY",
        .running = "RUNNING",
        .updating = "UPDATING",
        .autoscaling = "AUTOSCALING",
        .force_stopping = "FORCE_STOPPING",
        .rolling_back = "ROLLING_BACK",
        .maintenance = "MAINTENANCE",
        .rolled_back = "ROLLED_BACK",
    };
};
