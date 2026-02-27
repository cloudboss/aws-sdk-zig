pub const DestinationState = enum {
    starting,
    active,
    stopping,
    reconnecting,
    failed,
    stopped,

    pub const json_field_names = .{
        .starting = "STARTING",
        .active = "ACTIVE",
        .stopping = "STOPPING",
        .reconnecting = "RECONNECTING",
        .failed = "FAILED",
        .stopped = "STOPPED",
    };
};
