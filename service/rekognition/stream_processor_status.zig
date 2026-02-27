pub const StreamProcessorStatus = enum {
    stopped,
    starting,
    running,
    failed,
    stopping,
    updating,

    pub const json_field_names = .{
        .stopped = "STOPPED",
        .starting = "STARTING",
        .running = "RUNNING",
        .failed = "FAILED",
        .stopping = "STOPPING",
        .updating = "UPDATING",
    };
};
