pub const AppBlockBuilderState = enum {
    starting,
    running,
    stopping,
    stopped,

    pub const json_field_names = .{
        .starting = "STARTING",
        .running = "RUNNING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
    };
};
