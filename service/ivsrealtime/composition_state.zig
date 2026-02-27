pub const CompositionState = enum {
    starting,
    active,
    stopping,
    failed,
    stopped,

    pub const json_field_names = .{
        .starting = "STARTING",
        .active = "ACTIVE",
        .stopping = "STOPPING",
        .failed = "FAILED",
        .stopped = "STOPPED",
    };
};
