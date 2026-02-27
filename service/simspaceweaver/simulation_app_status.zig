pub const SimulationAppStatus = enum {
    starting,
    started,
    stopping,
    stopped,
    @"error",
    unknown,

    pub const json_field_names = .{
        .starting = "STARTING",
        .started = "STARTED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .@"error" = "ERROR",
        .unknown = "UNKNOWN",
    };
};
