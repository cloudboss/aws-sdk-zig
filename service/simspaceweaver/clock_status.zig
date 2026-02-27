pub const ClockStatus = enum {
    unknown,
    starting,
    started,
    stopping,
    stopped,

    pub const json_field_names = .{
        .unknown = "UNKNOWN",
        .starting = "STARTING",
        .started = "STARTED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
    };
};
