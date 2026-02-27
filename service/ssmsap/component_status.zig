pub const ComponentStatus = enum {
    activated,
    starting,
    stopped,
    stopping,
    running,
    running_with_error,
    undefined,

    pub const json_field_names = .{
        .activated = "ACTIVATED",
        .starting = "STARTING",
        .stopped = "STOPPED",
        .stopping = "STOPPING",
        .running = "RUNNING",
        .running_with_error = "RUNNING_WITH_ERROR",
        .undefined = "UNDEFINED",
    };
};
